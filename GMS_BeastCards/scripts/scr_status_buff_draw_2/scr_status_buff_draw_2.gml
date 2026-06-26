//===============================================================================//
//
// SCR_STATUS_BUFF_DRAW_2
// FUNCTION: Handles the Draw 2 global buff status.
//           Increases player card draw while active.
//           Removes the card draw bonus when the status expires.
//
//===============================================================================//
function scr_status_buff_draw_2(_str_tag,_ref_status){

	switch(_str_tag){

		case "APPLY":

			var _ref_existing_status = scr_check_for_status("DRAW_2",global.statuses);

			if (_ref_existing_status != -1){
				_ref_existing_status._val_status_lifetime = 3;
				return _ref_existing_status;
			}

			var _ref_new_status = instance_create_layer(x,y,"ily_status",obj_battle_status);

			_ref_new_status._val_status_lifetime = 3;
			_ref_new_status._scr_status = scr_status_buff_draw_2;
			_ref_new_status._ref_host = undefined;
			_ref_new_status._str_status_name = "DRAW_2";
			_ref_new_status._str_status_desc = "+2 CARD DRAW FOR 3 TURNS";
			_ref_new_status._spr_status = spr_status_buff_draw_2;
			_ref_new_status._str_trigger_region = "END";
			_ref_new_status._str_status_type = "GLOBAL";

			obj_battle_player_controller._ct_draw_amount += 2;

			ds_list_add(global.statuses,_ref_new_status);

			scr_reposition_statuses(global.statuses);

		break;

		case "REPEAT":

			_ref_status._val_status_lifetime--;

			if (_ref_status._val_status_lifetime <= 0){
				_ref_status._str_status_command = "DEATH";
			}
			else{
				_ref_status._str_status_command = "WAIT";
			}

			scr_reposition_statuses(global.statuses);

		break;

		case "DEATH":

			obj_battle_player_controller._ct_draw_amount -= 2;

			scr_destroy_status(_ref_status);

		break;
	}
}