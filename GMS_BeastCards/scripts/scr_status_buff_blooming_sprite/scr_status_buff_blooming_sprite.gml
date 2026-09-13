//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_BLOOMING_SPRITE
// FUNCTION: Handles the Blooming Sprite Buff.
//           Grants its host +2 Linear Damage per source Minion Magnitude.
//           Updates the granted bonus when that source Minion changes Magnitude.
//           Remains active until that exact Blooming Sprite is destroyed.
//           Cannot be cleansed or transferred away from its source Minion.
//
//===============================================================================//

function scr_status_buff_blooming_sprite(_str_tag,_ref_status,_ref_source_minion){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//-----------------------//
			//VALIDATE SOURCE MINION//
			//-----------------------//
			if (!instance_exists(_ref_source_minion)){
				return undefined;
			}

			var _ref_target = _ref_source_minion._ref_host;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//-----------------------//
			//CALCULATE DAMAGE BONUS//
			//-----------------------//
			var _val_damage_bonus = _ref_source_minion._val_magnitude * 2;

			//==========================//
			//CHECK EXACT SOURCE MINION//
			//==========================//
			for (var _it_status = 0;_it_status < ds_list_size(_ref_target._list_statuses);_it_status++){

				var _ref_existing_status = ds_list_find_value(_ref_target._list_statuses,_it_status);

				if (!instance_exists(_ref_existing_status)){
					continue;
				}

				if (_ref_existing_status._str_status_name != "BLOOMING_SPRITE"){
					continue;
				}

				if (
					!variable_instance_exists(_ref_existing_status,"_ref_source_minion") ||
					_ref_existing_status._ref_source_minion != _ref_source_minion
				){
					continue;
				}

				//----------------//
				//GET BONUS CHANGE//
				//----------------//
				var _val_bonus_change = _val_damage_bonus - _ref_existing_status._val_status_magnitude;

				//------------------//
				//UPDATE HOST BONUS//
				//------------------//
				_ref_target._val_dmg_linear_bonus += _val_bonus_change;

				//---------------//
				//UPDATE STATUS//
				//---------------//
				_ref_existing_status._val_status_magnitude = _val_damage_bonus;

				_ref_existing_status._str_status_desc =
					"+" +
					string(_val_damage_bonus) +
					" LINEAR DAMAGE WHILE BLOOMING SPRITE LIVES";

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

			//-------------------//
			//INFINITE LIFETIME//
			//-------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_buff_blooming_sprite;

			_ref_new_status._ref_host = _ref_target;
			_ref_new_status._ref_source_minion = _ref_source_minion;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "BLOOMING_SPRITE";

			_ref_new_status._str_status_desc =
				"+" +
					string(_val_damage_bonus) +
					" LINEAR DAMAGE WHILE BLOOMING SPRITE LIVES";

			_ref_new_status._spr_status = spr_status_buff_blooming_sprite;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = _val_damage_bonus;

			_ref_new_status._flag_status_stackable = false;
			_ref_new_status._flag_status_uncleansable = true;
			_ref_new_status._flag_status_requires_live_source_minion = true;

			_ref_new_status._str_trigger_region = undefined;

			//--------------------//
			//GRANT DAMAGE BONUS//
			//--------------------//
			_ref_target._val_dmg_linear_bonus += _val_damage_bonus;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

			return _ref_new_status;

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			//--------------------//
			//REMOVE DAMAGE BONUS//
			//--------------------//
			if (instance_exists(_ref_host)){

				_ref_host._val_dmg_linear_bonus =
					max(
						0,
						_ref_host._val_dmg_linear_bonus -
							_ref_status._val_status_magnitude
					);
			}

			//----------------//
			//DESTROY STATUS//
			//----------------//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}