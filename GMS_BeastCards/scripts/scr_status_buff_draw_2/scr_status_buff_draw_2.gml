//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_DRAW_2
// FUNCTION: Handles the Draw 2 global Buff.
//           Grants +2 card draw while active.
//           Reapplication refreshes duration without stacking the bonus.
//
//===============================================================================//
function scr_status_buff_draw_2(_str_tag,_ref_status,_val_lifetime=undefined){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_lifetime =
				max(1,_val_lifetime);

			var _ref_existing_status =
				scr_check_for_status(
					"DRAW_2",
					global.list_statuses
				);

			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				return _ref_existing_status;
			}

			var _ref_new_status =
				instance_create_layer(
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

			_ref_new_status._scr_status =
				scr_status_buff_draw_2;

			_ref_new_status._ref_host =
				undefined;

			_ref_new_status._str_status_name =
				"DRAW_2";

			_ref_new_status._str_status_desc =
				"+2 CARD DRAW FOR " +
				string(_val_lifetime) +
				" TURNS";

			_ref_new_status._spr_status =
				spr_status_buff_draw_2;

			_ref_new_status._str_trigger_region =
				"END";

			_ref_new_status._str_status_type =
				"GLOBAL";

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._val_status_magnitude =
				2;

			obj_battle_player_controller._ct_draw_amount +=
				2;

			ds_list_add(
				global.list_statuses,
				_ref_new_status
			);

			scr_reposition_statuses(
				global.list_statuses
			);

			return _ref_new_status;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			scr_status_tick_lifetime(
				_ref_status
			);

			scr_reposition_statuses(
				global.list_statuses
			);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			obj_battle_player_controller._ct_draw_amount =
				max(
					0,
					obj_battle_player_controller._ct_draw_amount -
					_ref_status._val_status_magnitude
				);

			scr_destroy_status(
				_ref_status
			);

		break;
	}

	return undefined;
}