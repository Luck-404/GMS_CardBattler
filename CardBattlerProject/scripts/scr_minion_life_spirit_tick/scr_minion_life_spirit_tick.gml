//////////////////////////////////////////////////////////////////////
//					SCR_MINION_LIFE_SPIRIT_TICK						//
//																	//
// > HEAL A UNIT FOR 20% MAX HP										//	
//////////////////////////////////////////////////////////////////////
function scr_minion_life_spirit_tick(_host,_self){
	
	var _5p = ceil((_host._creature_hp_max)*0.05); //get 5% of max hp

	_host._creature_hp_current += _5p; //add the hp
	
	if (_host._creature_hp_current > _host._creature_hp_max){ //check for overflow
		_host._creature_hp_current = _host._creature_hp_max;
	}
	
	var _popup = instance_create_layer(_host.x, _host.y, "GUI", obj_combat_values_popup);
	_popup._text = string(_5p);
	_popup._type = "Healing";		
	
	////////////
	// EFFECT //
	////////////
	var _ref_effect = instance_create_layer(_host.x,_host.y,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_grow_natures_remedy;
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_natures_remedy,0,false);	
}