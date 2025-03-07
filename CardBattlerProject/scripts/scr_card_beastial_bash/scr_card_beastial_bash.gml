function scr_card_beastial_bash(_card,_channel,_target){
	// left target
	if (_target._left_target != undefined){
	var _left_target = _target._left_target;
		///////////////////////
		// CALC DAMAGE BONUS //
		///////////////////////
		var _base_dmg = _card[?"damage"];
		var _dmg_mult = scr_calculate_color_damage_bonus(_channel,_base_dmg,_left_target);
		var _mult = _channel._creature_attack_scalar;
		var _linear = _channel._creature_attack_linear;
		_base_dmg = _base_dmg*_mult;
		_base_dmg = _base_dmg+_linear;
		
		////////////
		// DAMAGE //
		////////////
		_left_target._creature_hp_current -= abs(_left_target._creature_def-_dmg_mult);	
		_left_target._creature_def -= _dmg_mult;
		if (_left_target._creature_def <= 0){
			_left_target._creature_def = 0;
		}
	
		////////////
		// EFFECT //
		////////////
		_ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
		_ref_effect.sprite_index = spr_effect_beastial_bash;
	}
		
		
		
		
	// right target
	if (_target._right_target != undefined){	
	var _right_target = _target._right_target;	
		///////////////////////
		// CALC DAMAGE BONUS //
		///////////////////////
		var _base_dmg = _card[?"damage"];
		var _dmg_mult = scr_calculate_color_damage_bonus(_channel,_base_dmg,_right_target);
		var _mult = _channel._creature_attack_scalar;
		var _linear = _channel._creature_attack_linear;
		_base_dmg = _base_dmg*_mult;
		_base_dmg = _base_dmg+_linear;
		
		////////////
		// DAMAGE //
		////////////
		_right_target._creature_hp_current -= abs(_right_target._creature_def-_dmg_mult);	
		_right_target._creature_def -= _dmg_mult;
		if (_right_target._creature_def <= 0){
			_right_target._creature_def = 0;
		}
	
		////////////
		// EFFECT //
		////////////
		_ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
		_ref_effect.sprite_index = spr_effect_beastial_bash;
	}
	
	
	
	
	// middle target
		///////////////////////
		// CALC DAMAGE BONUS //
		///////////////////////
		var _base_dmg = _card[?"damage"];
		var _dmg_mult = scr_calculate_color_damage_bonus(_channel,_base_dmg,_target);
		var _mult = _channel._creature_attack_scalar;
		var _linear = _channel._creature_attack_linear;
		_base_dmg = _base_dmg*_mult;
		_base_dmg = _base_dmg+_linear;
		
		////////////
		// DAMAGE //
		////////////
		_target._creature_hp_current -= abs(_target._creature_def-_dmg_mult);	
		_target._creature_def -= _dmg_mult;
		if (_target._creature_def <= 0){
			_target._creature_def = 0;
		}
	
		////////////
		// EFFECT //
		////////////
		_ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
		_ref_effect.sprite_index = spr_effect_beastial_bash;
		
		//STUN middle target
		var _ref_counter = instance_create_layer(_target.x,_target.y-100,"GUI",obj_card_counter);
		_ref_counter.x = _target.x+20;
		_ref_counter.y = _target.y - 100;
		_ref_counter._draw_color = c_orange;	
		_ref_counter._turn_lifespan = 1;
		_ref_counter._reference_script = scr_card_stun;
		_ref_counter._target = _target;
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_beastial_bash,0,false);	
	
	////////////
	// BANNER //
	////////////
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_zone_banner);
	_ref_banner._ban_color = c_black;
	_ref_banner._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"] + " on " + "three targets" + " for " + string(_dmg_mult);
}