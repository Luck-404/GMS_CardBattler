function scr_init_minion(_id,_card,_caster,_target){
	switch(_id){
		case "LIFE_SPIRIT":
			var _new_minion = instance_create_layer(_target.x,_target.y,"ily_minions",obj_battle_minion);
			_new_minion._team = _target._team;
			_new_minion._name = "LIFE SPIRIT";
			_new_minion._cur_hp = 2;
			_new_minion._max_hp = 2;
			_new_minion._host = _target;
			_new_minion._minion_sprite = spr_minion_life_spirit;
	
			if (ds_list_size(_target._minions) < _target._minions_max){
		
				ds_list_add(_target._minions,_new_minion);
				//PLAY ANIMATION
	
				//PLAY SOUND
	
				//POPUP
				scr_spawn_scrolling_popup("TEXT","+ MINION",undefined,c_black,_target.x+irandom_range(-32,32),_target.y-24+irandom_range(-32,32));		
			} else {
				//REPLACE OLDEST
				var _old_min = ds_list_find_value(_target._minions,0);
				ds_list_replace(_target._minions,0,_new_minion);
				instance_destroy(_old_min);
		
				//PLAY ANIMATION
	
				//PLAY SOUND
	
				//POPUP
				scr_spawn_scrolling_popup("TEXT","+ MINION (REPLACED OLDEST)",undefined,c_black,_target.x+irandom_range(-32,32),_target.y-24+irandom_range(-32,32));		
			}
			
		scr_check_unit_pos(_target);	
		scr_check_status_pos(_target);				
		break;
	}
}