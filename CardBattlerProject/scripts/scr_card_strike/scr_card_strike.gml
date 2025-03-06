function scr_card_strike(_card,_mult_dmg,_base_dmg,_channel,_target){
	//damage calc
	_target._creature_hp_current -= abs(_target._creature_def-6);	
	_target._creature_def -= 6;
	if (_target._creature_def <= 0){
		_target._creature_def = 0;
	}
	
	//effect spawn
	var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_strike;
	
	//sound effect
	audio_play_sound(snd_effect_strike,0,false);	
	
	//banner summon
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_zone_banner);
	_ref_banner._ban_color = c_white;
	_ref_banner._ban_text = _channel[?"name"] + " casts " + _card[?"name"] + " on " + _target[?"name"] + " for " + string(6);
}