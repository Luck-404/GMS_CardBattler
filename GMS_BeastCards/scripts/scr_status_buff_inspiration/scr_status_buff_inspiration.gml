//===============================================================================//
//
// SCR_STATUS_BUFF_INSPIRATION
// FUNCTION: Handles the Inspiration global buff status.
//           Grants temporary max/current mana on apply.
//           Removes the mana bonus when the status expires.
//
//===============================================================================//
function scr_status_buff_inspiration(_str_tag,_ref_status){

	switch(_str_tag){

		case "APPLY":

			var _ref_existing_status = scr_check_for_status("INSPIRATION",global.statuses);

			if (_ref_existing_status != -1){
				_ref_existing_status._val_status_lifetime = 3;
				return _ref_existing_status;
			}

			var _ref_new_status = instance_create_layer(x,y,"ily_status",obj_battle_status);

			_ref_new_status._val_status_lifetime = 3;
			_ref_new_status._scr_status = scr_status_buff_inspiration;
			_ref_new_status._ref_host = undefined;
			_ref_new_status._str_status_name = "INSPIRATION";
			_ref_new_status._str_status_desc = "+2 MANA FOR 3 TURNS";
			_ref_new_status._spr_status = spr_status_buff_inspiration;
			_ref_new_status._str_trigger_region = "END";
			_ref_new_status._str_status_type = "GLOBAL";

			obj_battle_player_controller._val_max_mana += 2;
			obj_battle_player_controller._val_cur_mana += 2;

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

			obj_battle_player_controller._val_max_mana = obj_battle_player_controller._val_saved_max_mana;
			obj_battle_player_controller._val_cur_mana -= 2;

			if (obj_battle_player_controller._val_cur_mana < 0){
				obj_battle_player_controller._val_cur_mana = 0;
			}

			scr_destroy_status(_ref_status);

		break;
	}
}