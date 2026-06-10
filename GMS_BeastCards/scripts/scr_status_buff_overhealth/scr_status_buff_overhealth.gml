function scr_status_buff_overhealth(_tag,_ref){
	switch(_tag){
		case "APPLY":
			_ref = global.target_beast;
			
			var _status = scr_check_for_status("OVERHEALTH",_ref);
			if (_status != -1){
				_status._status_lifetime = 4;
				_status._status_stacks += 1;
				_ref._overhealth += 5;
				return _status;
			}
	
			//Make a new status obj
			var _new_status = instance_create_layer(_ref.x,_ref.y,"ily_status",obj_battle_status);
			_new_status._status_lifetime = 4;
			_new_status._status_scr = scr_status_buff_overhealth;			
			_new_status._ref_host = _ref;
			_new_status._status_name = "OVERHEALTH";
			_new_status._status_desc = "+5 OVRHP PER STACK";
			_new_status._status_sprite = spr_status_buff_overhealth;
			_new_status._status_stacks = 1;
			_new_status._trigger_region = "START";
	
			_ref._overhealth += 5;
	
			ds_list_add(_ref._statuses,_new_status);
	
			//SOUND
	
			//EFFECTS
	
			scr_reposition_statuses(_ref);
		break;
		
		case "REPEAT":
			//REGENERATE A STACKS WORTH EVERY TURN (1 STACK == REGENERATE 1), cant go over though
			_ref._ref_host._overhealth += _ref._status_stacks;
			if (_ref._ref_host._overhealth > _ref._status_stacks*5){
				_ref._ref_host._overhealth = _ref._status_stacks*5;
			}
		    //----------------------------------------------------
		    // HANDLING
		    //----------------------------------------------------
			_ref._status_lifetime--;
			if (_ref._status_lifetime <= 0){
				_ref._status_command = "DEATH";	
			} else {
				_ref._status_command = "WAIT";	
			}
			scr_reposition_statuses(_ref._ref_host);				
		break;
		
		case "DEATH":
			_ref._ref_host._overhealth = 0;
			scr_destroy_status(_ref);
		break;
	}
}