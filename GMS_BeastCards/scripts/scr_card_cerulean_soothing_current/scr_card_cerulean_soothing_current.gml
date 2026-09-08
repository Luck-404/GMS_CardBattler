//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SOOTHING_CURRENT
// FUNCTION: Resolves Soothing Current.
//           Heals the caster for 12 HP.
//
//===============================================================================//

function scr_card_cerulean_soothing_current(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//HEAL CASTER//
	//-----------//
	scr_battle_heal_target(
		_stct_card._val_card_magnitude,
		_ref_caster
	);
}