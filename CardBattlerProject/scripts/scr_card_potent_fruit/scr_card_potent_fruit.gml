function scr_card_potent_fruit(_card,_channel,_target){
	////////////
	// EFFECT //
	////////////
	var _existing_potent = undefined;
		//see if the target already has a potent fruit buff on
		for (var _i = 0; _i < ds_list_size(_target._buffs); _i++){
			var _buff = ds_list_find_value(_target._buffs,_i);
			if (_buff._counter_name == "Potent Fruit"){
				_existing_potent = _buff
			}
		}
	if (_existing_potent == undefined){			
		var _ref_counter = instance_create_layer(0,0,"GUI",obj_card_counter);
		_ref_counter.x = _target.x;
		_ref_counter.y = _target.y - 100;
		_ref_counter._draw_color = c_red;	
		_ref_counter._turn_lifespan = 3;
		_ref_counter._reference_script = scr_card_potent_fruit_repeat;
		_ref_counter._target = _target;
		_ref_counter._counter_name = "Potent Fruit";
		//add this type of buff to the buffs list
		ds_list_add(_target._buffs,_ref_counter);
		_ref_counter._trigger_my_effect = true;
		_target._creature_attack_scalar = _target._creature_attack_scalar+1;
	
	} else {
		_existing_potent._turn_lifespan = 3;
	}

	var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_potent_fruit;
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_potent_fruit,0,false);	
	
	////////////
	// BANNER //
	////////////
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_zone_banner);
	_ref_banner._ban_color = c_black;
	_ref_banner._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"] + " on " + _target._creature_name;
}