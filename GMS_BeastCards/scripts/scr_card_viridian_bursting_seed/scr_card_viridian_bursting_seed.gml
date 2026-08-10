//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BURSTING_SEED
// FUNCTION: Resolves the Bursting Seed card effect.
//           Applies Armorbreak for two rounds.
//           Applies Vulnerable for one round.
//
//===============================================================================//
function scr_card_viridian_bursting_seed(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//APPLY ARMORBREAK//
	//----------------//
	scr_apply_debuff_status("ARMORBREAK",2);

	//----------------//
	//APPLY VULNERABLE//
	//----------------//
	scr_apply_debuff_status("VULNERABLE",1);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_debuff,0,false);
}