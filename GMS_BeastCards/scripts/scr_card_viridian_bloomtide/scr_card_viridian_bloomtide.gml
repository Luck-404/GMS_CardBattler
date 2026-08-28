//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BLOOMTIDE
// FUNCTION: Resolves the Bloomtide card effect.
//           Begins the Bloomtide Event.
//
//===============================================================================//

function scr_card_viridian_bloomtide(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//BEGIN BLOOMTIDE//
	//----------------//
	scr_apply_event_status("BLOOMTIDE");

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}