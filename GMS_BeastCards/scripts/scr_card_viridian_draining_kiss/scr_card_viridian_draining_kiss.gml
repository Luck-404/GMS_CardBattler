//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_DRAINING_KISS
// FUNCTION: Resolves the Draining Kiss card effect.
//           Heals the caster for 5 HP.
//           Applies Drained to the selected target for 3 rounds.
//
//===============================================================================//
function scr_card_viridian_draining_kiss(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//HEAL CASTER//
	//-----------//
	scr_battle_heal_target(_stct_card._val_card_magnitude,_ref_caster);

	//--------------//
	//APPLY DRAINED//
	//--------------//
	scr_status_apply_debuff("DRAINED",3);
}