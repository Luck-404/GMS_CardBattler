function scr_card_beastial_bash(_card,_channel,_target){
	// left target
	if (_target._left_unit != undefined){
	var _left_target = _target._left_unit;
		///////////////////////
		// CALC DAMAGE BONUS //
		///////////////////////
		var _base_dmg = _card[?"damage"];
		var _color_mult = scr_calculate_color_damage_bonus(_channel,_left_target);
		var _scalar = _channel._creature_attack_scalar;
		var _linear = _channel._creature_attack_linear;
		var _scaled_dmg = _base_dmg*_scalar*_color_mult;
		var _final_dmg = _scaled_dmg+_linear;
	
		////////////
		// DAMAGE //
		////////////
		_left_target._creature_hp_current -= abs(_left_target._creature_def-_final_dmg);	
		_left_target._creature_def -= _final_dmg;
		if (_left_target._creature_def <= 0){
			_left_target._creature_def = 0;
		}
	
		////////////
		// EFFECT //
		////////////
		var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
		_ref_effect.sprite_index = spr_effect_beastial_bash;

		////////////
		// BANNER //
		////////////
		var _ref_banner_left = instance_create_layer(room_width/2,room_height/2-500,"GUI",obj_zone_banner);
		_ref_banner_left._ban_color = c_black;
		_ref_banner_left._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"] + " on " + _left_target._creature_name + " for " + string(_final_dmg);	
	}
		
		
		
		
	// right target
	if (_target._right_unit != undefined){
	var _right_target = _target._right_unit;
		///////////////////////
		// CALC DAMAGE BONUS //
		///////////////////////
		var _base_dmg = _card[?"damage"];
		var _color_mult = scr_calculate_color_damage_bonus(_channel,_right_target);
		var _scalar = _channel._creature_attack_scalar;
		var _linear = _channel._creature_attack_linear;
		var _scaled_dmg = _base_dmg*_scalar*_color_mult;
		var _final_dmg = _scaled_dmg+_linear;
	
		////////////
		// DAMAGE //
		////////////
		_right_target._creature_hp_current -= abs(_right_target._creature_def-_final_dmg);	
		_right_target._creature_def -= _final_dmg;
		if (_right_target._creature_def <= 0){
			_right_target._creature_def = 0;
		}
	
		////////////
		// EFFECT //
		////////////
		var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
		_ref_effect.sprite_index = spr_effect_beastial_bash;
		
		////////////
		// BANNER //
		////////////
		var _ref_banner_right = instance_create_layer(room_width/2,room_height/2-200,"GUI",obj_zone_banner);
		_ref_banner_right._ban_color = c_black;
		_ref_banner_right._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"] + " on " + _right_target._creature_name + " for " + string(_final_dmg);	
	}
	
	
	
	
	// middle target
	///////////////////////
	// CALC DAMAGE BONUS //
	///////////////////////
	var _base_dmg = _card[?"damage"];
	var _color_mult = scr_calculate_color_damage_bonus(_channel,_target);
	var _scalar = _channel._creature_attack_scalar;
	var _linear = _channel._creature_attack_linear;
	var _scaled_dmg = _base_dmg*_scalar*_color_mult;
	var _final_dmg = _scaled_dmg+_linear;
	
	////////////
	// DAMAGE //
	////////////
	_target._creature_hp_current -= abs(_target._creature_def-_final_dmg);	
	_target._creature_def -= _final_dmg;
	if (_target._creature_def <= 0){
		_target._creature_def = 0;
	}
	
	////////////
	// EFFECT //
	////////////
	var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_strike;
		
	//STUN middle target
if (_target._stunned == false){		
	var _ref_counter = instance_create_layer(_target.x,_target.y-100,"GUI",obj_card_counter);
	_ref_counter.x = _target.x+20;
	_ref_counter.y = _target.y - 100;
	_ref_counter._draw_color = c_orange;	
	_ref_counter._turn_lifespan = 1;
	_ref_counter._trigger_my_effect = true;
	_target._stun_counter_ref = _ref_counter;
	_ref_counter._reference_script = scr_card_stun;
	_ref_counter._target = _target;
	_target._stunned = true;
} else {
	//destroy
	_target._stun_counter_ref._turn_lifespan = 1;
}
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_beastial_bash,0,false);	
	
	////////////
	// BANNER //
	////////////
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_zone_banner);
	_ref_banner._ban_color = c_black;
	_ref_banner._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"] + " on " + _target._creature_name + " for " + string(_final_dmg);
}