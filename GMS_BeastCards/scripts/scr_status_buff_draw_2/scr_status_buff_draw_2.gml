//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_DRAW_2
// FUNCTION: Handles Draw 2.
//           Unstackable Timed Global Buff.
//           Grants +2 card draw while active.
//           Reapplication refreshes duration without stacking the bonus.
//
//===============================================================================//

function scr_status_buff_draw_2(_str_tag,_ref_status,_val_lifetime=undefined){

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
			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("DRAW_2",global.list_statuses);

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

				_ref_existing_status._str_status_desc = "+2 CARD DRAW FOR " + string(_val_lifetime) + " TURNS";

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

			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_buff_draw_2;

			_ref_new_status._ref_host = undefined;

			_ref_new_status._str_status_type = "GLOBAL";
			_ref_new_status._str_status_name = "DRAW_2";
			_ref_new_status._str_status_desc = "+2 CARD DRAW FOR " + string(_val_lifetime) + " TURNS";

			_ref_new_status._spr_status = spr_status_buff_draw_2;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = 2;

			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._str_trigger_region = "END";

			//--------------------//
			//INCREASE CARD DRAW//
			//--------------------//
			obj_battle_player_controller._ct_draw_amount += _ref_new_status._val_status_magnitude;

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

			//------------------//
			//REMOVE DRAW BONUS//
			//------------------//
			if (instance_exists(obj_battle_player_controller)){

				obj_battle_player_controller._ct_draw_amount =
					max(
						0,
						obj_battle_player_controller._ct_draw_amount -
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