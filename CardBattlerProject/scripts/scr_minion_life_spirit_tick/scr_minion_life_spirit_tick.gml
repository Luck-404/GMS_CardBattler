//////////////////////////////////////////////////////////////////////
//					SCR_MINION_LIFE_SPIRIT_TICK						//
//																	//
// > HEAL A UNIT FOR 20% MAX HP										//	
//////////////////////////////////////////////////////////////////////
function scr_minion_life_spirit_tick(_host,_self){
	///////////////
	// HEAL HOST //
	///////////////
	var _5p = ceil((_host._creature_hp_max)*0.05); //get 5% of max hp

	_host._creature_hp_current += _5p; //add the hp
	
	if (_host._creature_hp_current > _host._creature_hp_max){ //check for overflow
		_host._creature_hp_current = _host._creature_hp_max;
	}
	
	//////////////////
	// COMBAT POPUP //
	//////////////////
	scr_create_combat_popup(_host,string(_5p),"Healing",0,0);
	
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_host,spr_effect_grow_natures_remedy,0,0);	
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_natures_remedy,0,false);	
}