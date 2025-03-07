function scr_card_poison_ivy(_card,_channel,_target){
	// left target
	if (_target._left_target != undefined){	
	var _left_target = _target._left_target;
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
		_left_target._poison_count++;
	}
	// right target
	if (_target._right_target != undefined){
	var _right_target = _target._right_target;	
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
		_right_target._poison_count++;	
	}
	// middle target
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
		_target._poison_count++;		
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_poison_ivy,0,false);	
	
	////////////
	// BANNER //
	////////////
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_zone_banner);
	_ref_banner._ban_color = c_black;
	_ref_banner._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"] + " on " + "three targets";
}