//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_INTERLOCKING_SCALES
// FUNCTION: Resolves the Interlocking Scales card effect.
//           Grants linearly scaled Armor to the caster.
//           Armor scales from the caster's PHYPOW.
//
//===============================================================================//

function scr_card_viridian_interlocking_scales(_stct_card,_ref_caster,_ref_target){

	//-------------//
	//GRANT ARMOR//
	//-------------//
	scr_battle_armor_target_linear(_stct_card._val_card_magnitude,_ref_caster);

}