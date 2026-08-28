//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PREDATORY_SCENT
// FUNCTION: Resolves the Predatory Scent card effect.
//           Applies Focus to the selected Beast for 3 rounds.
//           Focus causes opposing Minions to prioritize the affected Beast.
//
//===============================================================================//
function scr_card_viridian_predatory_scent(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//APPLY FOCUS//
	//-----------//
	scr_apply_debuff_status("FOCUS",3);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_debuff,0,false);
}