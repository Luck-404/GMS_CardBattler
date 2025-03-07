function scr_card_power_strike(_card,_channel,_target){
	///////////////////////
	// CALC DAMAGE BONUS //
	///////////////////////
	var _base_dmg = _card[?"damage"];
	var _dmg_mult = scr_calculate_color_damage_bonus(_channel,_base_dmg,_target);
	// uncolored so cant have a damage bonus
	var _mult = _channel._creature_attack_scalar;
	var _linear = _channel._creature_attack_linear;
	_base_dmg = _base_dmg*_mult;
	_base_dmg = _base_dmg+_linear;
	
	////////////
	// DAMAGE //
	////////////
	_target._creature_hp_current -= abs(_target._creature_def-_base_dmg);	
	_target._creature_def -= _base_dmg;
	if (_target._creature_def <= 0){
		_target._creature_def = 0;
	}
	
	////////////
	// EFFECT //
	////////////
	var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_strike;
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_power_strike,0,false);	
	
	////////////
	// BANNER //
	////////////
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_zone_banner);
	_ref_banner._ban_color = c_black;
	_ref_banner._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"] + " on " + _target._creature_name + " for " + string(_base_dmg);
}