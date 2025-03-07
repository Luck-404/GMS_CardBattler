function scr_card_natures_remedy(_card,_channel,_target){
	///////////////
	// MAGNITUDE //
	///////////////
	//get 30% of max hp
	var _30p = ceil((_target._creature_hp_max)*0.30);
	
	//add the hp
	_target._creature_hp_current += _30p;
	
	//check for overflow
	if (_target._creature_hp_current > _target._creature_hp_max){
		_target._creature_hp_current = _target._creature_hp_max;
	}
	
	////////////
	// EFFECT //
	////////////
	var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_grow_natures_remedy;
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_natures_remedy,0,false);	
	
	////////////
	// BANNER //
	////////////
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_zone_banner);
	_ref_banner._ban_color = c_black;
	_ref_banner._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"] + " on " + _target._creature_name;
}