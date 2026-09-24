//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_NATURAL_CYCLE
// FUNCTION: Sacrifices the oldest Minion on the selected allied Beast, heals
//           that Beast, and draws 2 cards. Fails when no valid Minion exists.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected allied Beast.
// RETURNS: True if the card resolves, otherwise false.
//
//===============================================================================//
function scr_card_viridian_natural_cycle(_stct_card,_ref_caster,_ref_target){

	//================//
	//SACRIFICE MINION//
	//================//
	var _stct_sacrifice = scr_battle_sacrifice("MINION",_ref_target,"OLDEST");

	if (!_stct_sacrifice._flag_success){
		audio_play_sound(snd_gui_error,0,false);
		scr_gui_spawn_popup_error("NO MINIONS",60);
		return false;
	}

	//================//
	//HEAL HOST//
	//================//
	scr_battle_heal_target(
		"FIXED",
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//================//
	//DRAW CARDS//
	//================//
	scr_battle_draw_cards(2);

	return true;
}