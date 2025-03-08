function scr_card_poison_ivy(_card,_channel,_target){
	//check if a counter already exists on the unit

	
	// left target
	if (_target._left_unit != undefined){	
		var _left_target = _target._left_unit;
		if (_left_target._poison_count == 0){	
			//set up a poison counter
			var _ref_counter = instance_create_layer(0,0,"GUI",obj_card_counter);
			_ref_counter.x = _left_target.x+10;
			_ref_counter.y = _left_target.y - 100;
			_ref_counter._draw_color = c_green;	
			_ref_counter._turn_lifespan = 3;
			_left_target._poison_counter_ref = _ref_counter;
			_ref_counter._trigger_my_effect = false;
			_ref_counter._reference_script = scr_card_poison;
			_ref_counter._target = _left_target;
			var _ref_effect1 = instance_create_layer(_left_target.x,_left_target.y,"Effects",obj_card_effect);
			_ref_effect1.sprite_index = spr_effect_poison_ivy;
			_left_target._poison_count++;
		} else {
			_left_target._poison_counter_ref._turn_lifespan = 3;
			_left_target._poison_count++;
		}
	}
	// right target
	if (_target._right_unit != undefined){
		var _right_target = _target._right_unit;		
		if (_right_target._poison_count == 0){		
			//set up a poison counter
			var _ref_counter = instance_create_layer(0,0,"GUI",obj_card_counter);
			_ref_counter.x = _right_target.x+10;
			_ref_counter.y = _right_target.y - 100;
			_ref_counter._draw_color = c_green;	
			_ref_counter._turn_lifespan = 3;
			_right_target._poison_counter_ref = _ref_counter;	
			_ref_counter._trigger_my_effect = false;
			_ref_counter._reference_script = scr_card_poison;
			_ref_counter._target = _right_target;
			var _ref_effect2 = instance_create_layer(_right_target.x,_right_target.y,"Effects",obj_card_effect);
			_ref_effect2.sprite_index = spr_effect_poison_ivy;
			_right_target._poison_count++;	
		} else {
			_right_target._poison_counter_ref._turn_lifespan = 3;
			_right_target._poison_count++;
		}
	}
	// middle target
		if (_target._poison_count == 0){				
			//set up a poison counter
			var _ref_counter = instance_create_layer(0,0,"GUI",obj_card_counter);
			_ref_counter.x = _target.x+10;
			_ref_counter.y = _target.y - 100;
			_ref_counter._draw_color = c_green;	
			_ref_counter._turn_lifespan = 3;
			_target._poison_counter_ref = _ref_counter;				
			_ref_counter._trigger_my_effect = false;
			_ref_counter._reference_script = scr_card_poison;
			_ref_counter._target = _target;
			var _ref_effect3 = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
			_ref_effect3.sprite_index = spr_effect_poison_ivy;
			_target._poison_count++;		
		}else {
			_target._poison_counter_ref._turn_lifespan = 3;
			_target._poison_count++;
		}
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_poison_ivy,0,false);	
	
	////////////
	// BANNER //
	////////////
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_zone_banner);
	_ref_banner._ban_color = c_black;
	_ref_banner._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"];
}