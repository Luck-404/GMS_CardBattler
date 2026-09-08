//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CRYOGENIC_RECOVERY
// FUNCTION: Resolves Cryogenic Recovery.
//           Heals the target for 15 HP.
//           Cleanses 1 CC.
//
//===============================================================================//

function scr_card_cerulean_cryogenic_recovery(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//HEAL TARGET//
	//-----------//
	scr_battle_heal_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//------------//
	//CLEANSE CC//
	//------------//
	scr_cleanse_cc(
		_ref_target,
		1
	);

}