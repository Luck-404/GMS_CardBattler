//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_MOLTEN_BRAND
// FUNCTION: Applies Molten Brand to the selected Beast for 2 rounds.
//           Vermilion Cards deal 25% increased damage to the affected Beast.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_molten_brand(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY MOLTEN BRAND//
	//================//
	scr_status_apply_debuff("MOLTEN_BRAND", _ref_target, 2, 25);
}