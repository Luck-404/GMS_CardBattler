//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_POTENT_SPORE
// FUNCTION: Resolves the Potent Spore card effect.
//           Applies three Poison stacks to the selected target.
//
//===============================================================================//

function scr_card_viridian_potent_spore(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//APPLY 3 POISON//
	//----------------//
	repeat (3){
		scr_apply_dot_status("POISON");
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_debuff,0,false);
}