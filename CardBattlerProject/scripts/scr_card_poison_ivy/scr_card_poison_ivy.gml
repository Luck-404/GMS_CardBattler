function scr_card_poison_ivy(_target){
	//3-man swipe
	// middle unit is _target
	var _mid_id = ds_list_find_index(global.enemy_party,_target);
	var _left_target = undefined;
	var _right_target = undefined;
	if (ds_list_size(global.enemy_party) > 1){
		if ((_mid_id-1 != -1) && (ds_list_find_value(global.enemy_party,_mid_id-1) != undefined)){
			//left unit
			_left_target = ds_list_find_value(global.enemy_party,_mid_id-1)
		}
		if ((_mid_id+1 != 6) && (ds_list_find_value(global.enemy_party,_mid_id+1) != undefined)){
			//right unit	
			_right_target = ds_list_find_value(global.enemy_party,_mid_id-1)
		}
	}
	
	//////////
	// LEFT //
	//////////
	if (_left_target != undefined){
		//set up a poison counter
		var _ref_counter = instance_create_layer(0,0,"GUI",obj_card_counter);
		_ref_counter.x = _left_target.x+10;
		_ref_counter.y = _left_target.y - 100;
		_ref_counter._draw_color = c_green;	
		_ref_counter._turn_lifespan = 2;
		_ref_counter._reference_script = scr_card_poison;
		_ref_counter._target = _left_target;
		var _ref_effect1 = instance_create_layer(_left_target.x,_left_target.y,"Effects",obj_card_effect);
		_ref_effect1.sprite_index = spr_effect_poison_ivy;
	}
	
	///////////
	// RIGHT //
	///////////
	if (_right_target != undefined){
		//set up a poison counter
		var _ref_counter = instance_create_layer(0,0,"GUI",obj_card_counter);
		_ref_counter.x = _right_target.x+10;
		_ref_counter.y = _right_target.y - 100;
		_ref_counter._draw_color = c_green;	
		_ref_counter._turn_lifespan = 2;
		_ref_counter._reference_script = scr_card_poison;
		_ref_counter._target = _right_target;
		var _ref_effect2 = instance_create_layer(_right_target.x,_right_target.y,"Effects",obj_card_effect);
		_ref_effect2.sprite_index = spr_effect_poison_ivy;
	}

	////////////
	// MIDDLE //
	////////////
		//set up a poison counter
		var _ref_counter = instance_create_layer(0,0,"GUI",obj_card_counter);
		_ref_counter.x = _target.x+10;
		_ref_counter.y = _target.y - 100;
		_ref_counter._draw_color = c_green;	
		_ref_counter._turn_lifespan = 2;
		_ref_counter._reference_script = scr_card_poison;
		_ref_counter._target = _target;
		var _ref_effect3 = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
		_ref_effect3.sprite_index = spr_effect_poison_ivy;

	//play SOUND effect!	
	audio_play_sound(snd_effect_poison_ivy,0,false);	
}