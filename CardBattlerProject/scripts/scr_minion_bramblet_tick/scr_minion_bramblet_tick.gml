//////////////////////////////////////////////////////////////////////
//						SCR_MINION_BRAMBLET_TICK					//
//																	//
// > ADD 5 DEF TO HOST												//	
//////////////////////////////////////////////////////////////////////
function scr_minion_bramblet_tick(_host,_self){
	_host._creature_def += 5; 
	_self._minion_def = 2;
		var _popup = instance_create_layer(_host.x, _host.y, "GUI", obj_combat_values_popup);
		_popup._text = "5";
		_popup._type = "Shields";	
		
		_popup2 = instance_create_layer(_self.x, _self.y, "GUI", obj_combat_values_popup);
		_popup2._text = "2";
		_popup2._type = "Shields";	
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