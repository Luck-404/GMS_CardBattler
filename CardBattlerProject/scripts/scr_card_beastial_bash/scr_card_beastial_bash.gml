function scr_card_beastial_bash(_target){
	//3-man swipe
	// middle unit is _target
	var _mid_id = ds_list_find_index(global.enemy_team,_target);
	var _left_target = undefined;
	var _right_target = undefined;
	if (ds_list_size(global.enemy_team) > 1){
		if ((_mid_id-1 != -1) && (ds_list_find_value(global.enemy_team,_mid_id-1) != undefined)){
			//left unit
			_left_target = ds_list_find_value(global.enemy_team,_mid_id-1)
		}
		if ((_mid_id+1 != 6) && (ds_list_find_value(global.enemy_team,_mid_id+1) != undefined)){
			//right unit	
			_right_target = ds_list_find_value(global.enemy_team,_mid_id-1)
		}
	}
	
	//////////
	// LEFT //
	//////////
	if (_left_target != undefined){
		//deal damage
			_left_target._creature_hp_current -= abs(_left_target._creature_def-6);	
			_left_target._creature_def -= 6;
			if (_left_target._creature_def <= 0){
				_left_target._creature_def = 0;
			}
		var _ref_effect1 = instance_create_layer(_left_target.x,_left_target.y,"Effects",obj_card_effect);
		_ref_effect1.sprite_index = spr_effect_strike;
	}
	
	///////////
	// RIGHT //
	///////////
	if (_right_target != undefined){
		//deal damage
			_right_target._creature_hp_current -= abs(_right_target._creature_def-6);	
			_right_target._creature_def -= 6;
			if (_right_target._creature_def <= 0){
				_right_target._creature_def = 0;
			}
		var _ref_effect2 = instance_create_layer(_right_target.x,_right_target.y,"Effects",obj_card_effect);
		_ref_effect2.sprite_index = spr_effect_strike;
	}

	////////////
	// MIDDLE //
	////////////
		//deal damage
			_target._creature_hp_current -= abs(_target._creature_def-6);	
			_target._creature_def -= 6;
			if (_target._creature_def <= 0){
				_target._creature_def = 0;
			}	
		//set up a poison counter
		var _ref_counter = instance_create_layer(0,0,"GUI",obj_card_counter);
		_ref_counter.x = _target.x+20;
		_ref_counter.y = _target.y - 100;
		_ref_counter._draw_color = c_orange;	
		_ref_counter._turn_lifespan = 1;
		_ref_counter._reference_script = scr_card_stun;
		_ref_counter._target = _target;
		var _ref_effect3 = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
		_ref_effect3._vspd = -10;
		_ref_effect3._count_lifetime = 30;
		_ref_effect3.sprite_index = spr_effect_beastial_bash;

	//play SOUND effect!	
	audio_play_sound(snd_effect_beastial_bash,0,false);	
}