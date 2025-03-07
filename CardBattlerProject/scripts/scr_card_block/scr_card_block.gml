function scr_card_block(_card,_channel,_target){
	///////////////
	// MAGNITUDE //
	///////////////
	_target._creature_def += 5;
	
	////////////
	// EFFECT //
	////////////
	var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_block;
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_block,0,false);
	
	////////////
	// BANNER //
	////////////
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_zone_banner);
	_ref_banner._ban_color = c_black;
	_ref_banner._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"];
}