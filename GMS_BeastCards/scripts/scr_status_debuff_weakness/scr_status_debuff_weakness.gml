function scr_status_debuff_weakness(_tag,_ref){
	switch(_tag){
		case "APPLY":
			_ref = global.target_beast;
			
			var _status = scr_check_unit_status("WEAKNESS",_ref);
			if (_status != -1){
				_status._status_lifetime = 3;
				_status._status_stacks += 1;
				return _status;
			}
	
			//Make a new status obj
			var _new_status = instance_create_layer(_ref.x,_ref.y,"ily_status",obj_battle_status);
			_new_status._status_lifetime = 3;
			_new_status._status_scr = scr_status_debuff_weakness;			
			_new_status._ref_host = _ref;
			_new_status._status_name = "WEAKNESS";
			_new_status._status_desc = "-2 DAMAGE PER STACK";
			_new_status._status_sprite = spr_status_debuff_weakness;
			_new_status._status_stacks = 1;
			_new_status._trigger_region = "END";
	
			ds_list_add(_ref._statuses,_new_status);
	
			//SOUND
	
			//EFFECTS
	
			scr_check_status_pos(_ref);
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
			scr_check_status_pos(_ref._ref_host);				
		break;
		
		case "DEATH":
			scr_destroy_status(_ref);
		break;
	}
}