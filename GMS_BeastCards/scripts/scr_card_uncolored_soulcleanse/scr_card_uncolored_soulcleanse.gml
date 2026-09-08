//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_SOULCLEANSE
// FUNCTION: Resolves the Soulcleanse card effect.
//           Removes every cleansable Aura hosted by the selected Beast.
//
//===============================================================================//
function scr_card_uncolored_soulcleanse(_stct_card,_ref_caster,_ref_target){

	//---------------//
	//CLEANSE AURAS//
	//---------------//
	scr_status_cleanse_aura(_ref_target);

}