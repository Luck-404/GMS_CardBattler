//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_NATURES_BOND
// FUNCTION: Resolves the Nature's Bond card effect.
//           Heals the caster for 5 HP.
//           Applies one stack of Nature's Bond for 5 rounds.
//
//===============================================================================//
function scr_card_viridian_natures_bond(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//HEAL CASTER//
	//-----------//
	scr_heal_target(_stct_card._val_card_magnitude,_ref_caster);

	//-------------------//
	//APPLY NATURE'S BOND//
	//-------------------//
	scr_apply_buff_status("NATURES_BOND",2,5);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_heal,0,false);
}