//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_MANA_SPRING
// FUNCTION: Handles the Mana Spring global Mana Buff.
//           Grants temporary Maximum Mana and grants Current Mana.
//           Reapplication refreshes duration without stacking itself.
//           Stacks independently with Inspiration and Manavine.
//           Uses the shared Mana Gain and Maximum Mana systems.
//
//===============================================================================//

function scr_status_buff_mana_spring(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//-----------------//
			//VALIDATE SYSTEM//
			//-----------------//
			if (!instance_exists(obj_battle_player_controller)){
				return undefined;
			}

			if (!variable_global_exists("list_statuses")){
				return undefined;
			}

			if (!ds_exists(global.list_statuses,ds_type_list)){
				return undefined;
			}

			//----------//
			//DEFAULTS//
			//----------//
			if (_val_magnitude == undefined){
				_val_magnitude = 2;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_magnitude = max(0,_val_magnitude);
			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("MANA_SPRING",global.list_statuses);

			//------------------//
			//REFRESH EXISTING//
			//------------------//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				_ref_existing_status._str_status_desc =
					"+" +
					string(_ref_existing_status._val_status_magnitude) +
					" MAXIMUM/CURRENT MANA FOR " +
					string(_val_lifetime) +
					" ROUNDS";

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_status",
				obj_battle_status
			);

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_buff_mana_spring;

			_ref_new_status._ref_host = undefined;

			_ref_new_status._str_status_type = "GLOBAL";
			_ref_new_status._str_status_name = "MANA_SPRING";
			_ref_new_status._str_status_desc =
				"+" +
				string(_val_magnitude) +
				" MAXIMUM/CURRENT MANA FOR " +
				string(_val_lifetime) +
				" ROUNDS";

			_ref_new_status._spr_status = spr_status_buff_mana_spring;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = _val_magnitude;

			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._str_trigger_region = "END";

			//----------------------//
			//INCREASE MAXIMUM MANA//
			//----------------------//
			scr_battle_change_max_mana(
				_val_magnitude
			);

			//-------------------//
			//GAIN CURRENT MANA//
			//-------------------//
			scr_battle_gain_mana(
				_val_magnitude
			);

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				global.list_statuses,
				_ref_new_status
			);

			scr_status_reposition(global.list_statuses);

			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			if (
				!variable_global_exists("list_statuses") ||
				!ds_exists(global.list_statuses,ds_type_list)
			){

				scr_status_destroy(_ref_status);

				return undefined;
			}

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(_ref_status);
			scr_status_reposition(global.list_statuses);

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _val_mana_bonus = max(0,_ref_status._val_status_magnitude);

			//---------------------//
			//REMOVE MAXIMUM MANA//
			//---------------------//
			scr_battle_change_max_mana(
				-_val_mana_bonus
			);

			//----------------//
			//DESTROY STATUS//
			//----------------//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}