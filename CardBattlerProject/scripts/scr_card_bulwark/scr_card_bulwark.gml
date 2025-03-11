//////////////////////////////////////////////////////////////////////
//							SCR_CARD_BULWARK						//
//																	//
// > CAST A SHIELD ON SELF											//
//////////////////////////////////////////////////////////////////////
function scr_card_bulwark(_card,_channel,_target){
	///////////////
	// MAGNITUDE //
	///////////////
	_target._creature_def += 10;
	
	
	var _popup = instance_create_layer(_target.x, _target.y, "GUI", obj_combat_values_popup);
	_popup._text = string(10);
	_popup._type = "Shields";
	
	////////////
	// EFFECT //
	////////////
	var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_bulwark;
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_bulwark,0,false);	
	
	////////////
	// BANNER //
	////////////
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_zone_banner);
	_ref_banner._ban_color = c_black;
	_ref_banner._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"];
	
	scr_trigger_minion_reactions(_card,_target,_channel,0);	
}