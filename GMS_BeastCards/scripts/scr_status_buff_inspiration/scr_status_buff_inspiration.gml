function scr_status_buff_inspiration(_tag,_ref){
	switch(_tag){
		case "APPLY":
			_ref = global.statuses;
			
			var _status = scr_check_for_status("INSPIRATION",global.statuses);
			if (_status != -1){
				_status._status_lifetime = 3;			
				return _status;
			}
	
			//Make a new status obj
			var _new_status = instance_create_layer(x,y,"ily_status",obj_battle_status);
			_new_status._status_lifetime = 3;
			_new_status._status_scr = scr_status_buff_inspiration;				
			_new_status._ref_host = undefined;
			_new_status._status_name = "INSPIRATION";
			_new_status._status_desc = "+2 MANA FOR 3 TURNS";
			_new_status._status_sprite = spr_status_buff_inspiration;
			_new_status._trigger_region = "END";
			_new_status._status_type = "GLOBAL";
	
			obj_battle_player_controller._max_mana += 2;
			obj_battle_player_controller._cur_mana += 2;			
	
			ds_list_add(global.statuses,_new_status);
	
			//SOUND
	
			//EFFECTS
	
			scr_reposition_statuses(global.statuses);
		break;
		
		case "REPEAT":
			
		    //----------------------------------------------------
		    // HANDLING
		    //----------------------------------------------------
			_ref._status_lifetime--;
			if (_ref._status_lifetime <= 0){
				_ref._status_command = "DEATH";	
			} else {
				_ref._status_command = "WAIT";	
			}
			scr_reposition_statuses(global.statuses);				
		break;
		
		case "DEATH":
			obj_battle_player_controller._max_mana = obj_battle_player_controller._saved_max_mana;
			obj_battle_player_controller._cur_mana -= 2;
			if (obj_battle_player_controller._cur_mana < 0){
				obj_battle_player_controller._cur_mana = 0;	
			}
		
			scr_destroy_status(_ref);
		break;
	}
}