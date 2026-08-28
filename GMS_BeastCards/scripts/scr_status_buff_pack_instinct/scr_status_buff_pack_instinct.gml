//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_PACK_INSTINCT
// FUNCTION: Handles the Pack Instinct Buff.
//           Unstackable Timed.
//           Grants +2 linear damage and +2 Maximum HP per living Minion.
//           Dynamically updates its bonuses as the host's Minion count changes.
//
//===============================================================================//
function scr_status_buff_pack_instinct(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			//------------------//
			//DEFAULT MAGNITUDE//
			//------------------//
			if (_val_magnitude == undefined){
				_val_magnitude = 2;
			}

			//----------------//
			//DEFAULT LENGTH//
			//----------------//
			if (_val_lifetime == undefined){
				_val_lifetime = 4;
			}

			_val_magnitude = max(0,_val_magnitude);
			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_check_for_status("PACK_INSTINCT",_ref_target);

			//------------------//
			//REFRESH EXISTING//
			//------------------//
			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(_ref_existing_status,_val_lifetime);

				_ref_existing_status._scr_status("TRIGGER",_ref_existing_status);

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			_ref_new_status._scr_status =
				scr_status_buff_pack_instinct;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"PACK_INSTINCT";

			_ref_new_status._str_status_desc =
				"+0 DAMAGE / +0 MAX HP";

			_ref_new_status._spr_status =
				spr_status_buff_pack_instinct;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._val_status_magnitude =
				_val_magnitude;

			_ref_new_status._str_buff_trigger =
				"MINION_COUNT";

			_ref_new_status._str_trigger_region =
				"END";

			//--------------------------//
			//TRACK APPLIED CONTRIBUTION//
			//--------------------------//
			_ref_new_status._val_pack_damage_bonus =
				0;

			_ref_new_status._val_pack_max_hp_bonus =
				0;

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(_ref_new_status,_val_lifetime,false,false);

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(_ref_target._list_statuses,_ref_new_status);

			//---------------------//
			//CALCULATE FIRST BONUS//
			//---------------------//
			_ref_new_status._scr_status("TRIGGER",_ref_new_status);

			scr_reposition_statuses(_ref_target);

			return _ref_new_status;

		break;


		//---------//
		//TRIGGER//
		//---------//
		case "TRIGGER":

			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			//----------------------//
			//COUNT LIVING MINIONS//
			//----------------------//
			var _ct_living_minions = 0;

			for (var _it_minion = 0; _it_minion < ds_list_size(_ref_host._list_minions); _it_minion++){

				var _ref_minion = ds_list_find_value(_ref_host._list_minions,_it_minion);

				if (!instance_exists(_ref_minion)){
					continue;
				}

				if (_ref_minion._val_cur_hp <= 0){
					continue;
				}

				_ct_living_minions++;
			}

			//----------------------//
			//CALCULATE NEW BONUSES//
			//----------------------//
			var _val_new_bonus =
				_ct_living_minions *
				_ref_status._val_status_magnitude;

			var _val_damage_change =
				_val_new_bonus -
				_ref_status._val_pack_damage_bonus;

			var _val_max_hp_change =
				_val_new_bonus -
				_ref_status._val_pack_max_hp_bonus;

			//---------------------//
			//UPDATE DAMAGE BONUS//
			//---------------------//
			_ref_host._val_dmg_linear_bonus +=
				_val_damage_change;

			//-------------------//
			//UPDATE MAXIMUM HP//
			//-------------------//
			_ref_host._val_max_hp +=
				_val_max_hp_change;

			_ref_host._val_max_hp =
				max(1,_ref_host._val_max_hp);

			_ref_host._val_cur_hp =
				min(
					_ref_host._val_cur_hp,
					_ref_host._val_max_hp
				);

			//-------------------//
			//STORE CONTRIBUTION//
			//-------------------//
			_ref_status._val_pack_damage_bonus =
				_val_new_bonus;

			_ref_status._val_pack_max_hp_bonus =
				_val_new_bonus;

			//----------------//
			//UPDATE DISPLAY//
			//----------------//
			_ref_status._str_status_desc =
				"+" +
				string(_val_new_bonus) +
				" DAMAGE / +" +
				string(_val_new_bonus) +
				" MAX HP";

			return true;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_destroy_status(_ref_status);

				return undefined;
			}

			//-----------------//
			//REFRESH BONUSES//
			//-----------------//
			_ref_status._scr_status("TRIGGER",_ref_status);

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(_ref_status);

			scr_reposition_statuses(_ref_host);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (instance_exists(_ref_host)){

				//--------------------//
				//REMOVE DAMAGE BONUS//
				//--------------------//
				_ref_host._val_dmg_linear_bonus -=
					_ref_status._val_pack_damage_bonus;

				//----------------------//
				//REMOVE MAXIMUM HP BONUS//
				//----------------------//
				_ref_host._val_max_hp -=
					_ref_status._val_pack_max_hp_bonus;

				_ref_host._val_max_hp =
					max(1,_ref_host._val_max_hp);

				_ref_host._val_cur_hp =
					min(
						_ref_host._val_cur_hp,
						_ref_host._val_max_hp
					);
			}

			scr_destroy_status(_ref_status);

		break;
	}

	return undefined;
}