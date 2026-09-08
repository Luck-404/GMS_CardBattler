//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_LIFEBLOOM
// FUNCTION: Resolves the Lifebloom card effect.
//           Restores linearly scaled HP to the selected allied Beast.
//
//===============================================================================//
function scr_card_viridian_lifebloom(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//HEAL TARGET//
	//-----------//
	scr_battle_heal_target_linear(
		_stct_card._val_card_magnitude,
		_ref_target
	);

}