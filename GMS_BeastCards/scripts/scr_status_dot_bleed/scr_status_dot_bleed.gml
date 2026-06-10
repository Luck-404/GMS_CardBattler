//
//
//
//
//
function scr_status_dot_bleed(_tag,_ref){
	switch(_tag){
		case "APPLY":
			_ref = global.target_beast;

			var _status = scr_check_for_status("BLEED",_ref);
			if (_status != -1){
				_status._status_lifetime = 5;
				_status._status_stacks += 1;
				return _status;
			}
	
			//Make a new status obj
			var _new_status = instance_create_layer(_ref.x,_ref.y,"ily_status",obj_battle_status);
			_new_status._status_lifetime = 5;
			_new_status._status_scr = scr_status_dot_bleed;
			_new_status._ref_host = _ref;
			_new_status._status_name = "BLEED";
			_new_status._status_desc = "BLEEDING";
			_new_status._status_sprite = spr_status_dot_bleed;
			_new_status._status_stacks = 1;
			_new_status._trigger_region = "START";
	
	
			ds_list_add(_ref._statuses,_new_status);
	
			//SOUND
	
			//EFFECTS
	
			scr_reposition_statuses(_ref);
		break;
		
		case "REPEAT":
			var _damage = _ref._status_stacks;
		    //----------------------------------------------------
		    // PHASE 3: HOST OVERHEALTH
		    //----------------------------------------------------
		    if (_damage > 0 && _ref._ref_host._overhealth > 0)
		    {
		        var _blocked = min(_ref._ref_host._overhealth, _damage);
				scr_spawn_popup_scrolling("TEXT","-" + string(_blocked),undefined,c_green,_ref._ref_host.x+irandom_range(-32,32),_ref._ref_host.y-24+irandom_range(-32,32));	
		        _ref._ref_host._overhealth -= _blocked;
		        _damage -= _blocked;
		    }

		    //----------------------------------------------------
		    // PHASE 4: HOST HP
		    //----------------------------------------------------
		    if (_damage > 0)
		    {
				scr_spawn_popup_scrolling("TEXT","-" + string(_damage),undefined,c_maroon,_ref._ref_host.x+irandom_range(-32,32),_ref._ref_host.y-24+irandom_range(-32,32));	
		        _ref._ref_host._cur_hp -= _damage;
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
			scr_destroy_status(_ref);
		break;
	}
}