//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_TIDAL_FLOW
// FUNCTION: Resolves Tidal Flow.
//           Generates 1 Mana and draws 1 card.
//
//===============================================================================//

function scr_card_cerulean_tidal_flow(_stct_card,_ref_caster,_ref_target){

	//-------------//
	//GENERATE MANA//
	//-------------//
	scr_gain_mana(_stct_card._val_card_magnitude);

	//-----------//
	//DRAW CARD//
	//-----------//
	scr_draw_cards(1);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_battle_sfx_draw_card,0,false);

	//-------------//
	//SPAWN POPUPS//
	//-------------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"+" + string(_stct_card._val_card_magnitude) + " MANA",
		undefined,
		c_blue,
		room_width / 2 - 300,
		room_height / 2 - 24
	);

	scr_spawn_popup_scrolling(
		"TEXT",
		"+1 CARD",
		undefined,
		c_black,
		room_width / 2 - 300,
		room_height / 2 + 24
	);
}