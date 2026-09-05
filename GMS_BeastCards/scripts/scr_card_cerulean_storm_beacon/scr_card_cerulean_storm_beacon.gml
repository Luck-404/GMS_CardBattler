//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_STORM_BEACON
// FUNCTION: Resolves Storm Beacon.
//           Places a card-cast-triggered Trap on the selected enemy Beast.
//
//===============================================================================//

function scr_card_cerulean_storm_beacon(_stct_card,_ref_caster,_ref_target){

	//----------//
	//SET TRAP//
	//----------//
	scr_init_trap("STORM_BEACON",_stct_card,_ref_caster,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}