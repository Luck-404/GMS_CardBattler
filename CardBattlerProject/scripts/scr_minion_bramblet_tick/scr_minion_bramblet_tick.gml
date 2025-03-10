//////////////////////////////////////////////////////////////////////
//						SCR_MINION_BRAMBLET_TICK					//
//																	//
// > ADD 5 DEF TO HOST												//	
//////////////////////////////////////////////////////////////////////
function scr_minion_bramblet_tick(_host,_self){
	_host._creature_def += 5; 
	_self._minion_def = 2;
	////////////
	// EFFECT //
	////////////
	var _ref_effect = instance_create_layer(_host.x,_host.y,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_block;
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_block,0,false);	
}