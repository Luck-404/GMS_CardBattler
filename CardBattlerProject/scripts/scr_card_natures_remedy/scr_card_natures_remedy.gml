//////////////////////////////////////////////////////////////////////
//						SCR_CARD_NATURES_REMEDY						//
//																	//
// > HEAL A UNIT FOR 20% MAX HP										//	
//////////////////////////////////////////////////////////////////////
function scr_card_natures_remedy(_card,_channel,_target){
	///////////////
	// MAGNITUDE //
	///////////////
	var _20p = ceil((_target._creature_hp_max)*0.20); //get 20% of max hp

	_target._creature_hp_current += _20p; //add the hp
	
	if (_target._creature_hp_current > _target._creature_hp_max){ //check for overflow
		_target._creature_hp_current = _target._creature_hp_max;
	}
	
	////////////
	// EFFECT //
	////////////
	var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_grow_natures_remedy;
	
	///////////////////
	// SCROLLING DMG //
	///////////////////
	//popup the reason
	var _popup = instance_create_layer(_target.x, _target.y, "GUI", obj_combat_values_popup);
	_popup._text = string(_20p);
	_popup._type = "Healing";	
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_natures_remedy,0,false);	
	
	////////////
	// BANNER //
	////////////
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_banner);
	_ref_banner._ban_color = c_black;
	_ref_banner._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"] + " on " + _target._creature_name;
	
	scr_trigger_minion_reactions(_card,_target,_channel,0);	
}