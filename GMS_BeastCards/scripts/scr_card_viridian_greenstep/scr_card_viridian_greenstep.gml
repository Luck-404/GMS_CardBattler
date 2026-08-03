//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_GREENSTEP
// FUNCTION: Resolves Greenstep.
//           Swaps the caster's position with the selected allied Beast.
//           Heals both the caster and target for the card's magnitude.
//
//===============================================================================//
function scr_card_viridian_greenstep(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//SWAP POSITIONS//
	//----------------//
	scr_reposition_target(_stct_card,_ref_caster,_ref_target);

	//---------------//
	//HEAL BOTH//
	//---------------//
	scr_heal_target(_stct_card._val_card_magnitude,_ref_caster);
	scr_heal_target(_stct_card._val_card_magnitude,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_heal,0,false);
}