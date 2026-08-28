//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_CLEARCAST
// FUNCTION: Resolves the Clearcast card effect.
//           Removes all active WEATHER statuses.
//           Runs each Weather status's normal death/cleanup behavior.
//           Plays the associated animation, sound, and popup effects.
//
//===============================================================================//
function scr_card_uncolored_clearcast(_stct_card,_ref_caster,_ref_target){

	//---------------------//
	//REMOVE ACTIVE WEATHER//
	//---------------------//
	scr_clear_weather();

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
	
	//-------------//
	//SPAWN POPUP//
	//-------------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"WEATHER CLEARED",
		undefined,
		c_black,
		room_width / 2 - 300,
		room_height / 2
	);
}