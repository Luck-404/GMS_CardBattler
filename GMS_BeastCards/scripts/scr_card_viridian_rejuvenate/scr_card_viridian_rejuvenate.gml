//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_REJUVENATE
// FUNCTION: Resolves the Rejuvenate card effect.
//           Calculates linearly scaled healing from the caster's MAGPOW.
//           Adds that healing as a Regeneration stack for 3 rounds.
//
//===============================================================================//
function scr_card_viridian_rejuvenate(_stct_card,_ref_caster,_ref_target){

	//------------------//
	//CALCULATE HEALING//
	//------------------//
	var _val_healing = scr_get_heal_linear_amount(
		_stct_card._val_card_magnitude,
		_ref_caster,
		_stct_card
	);

	//-------------------//
	//APPLY REGENERATION//
	//-------------------//
	scr_apply_buff_status("REGENERATION",_val_healing,3);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_heal,0,false);
}