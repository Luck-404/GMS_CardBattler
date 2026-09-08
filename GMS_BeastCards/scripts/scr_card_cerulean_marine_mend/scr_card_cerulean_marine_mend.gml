//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_MARINE_MEND
// FUNCTION: Resolves Marine Mend.
//           Removes all cleansable Auras from the target.
//
//===============================================================================//

function scr_card_cerulean_marine_mend(_stct_card,_ref_caster,_ref_target){

	//---------------//
	//CLEANSE AURAS//
	//---------------//
	scr_status_cleanse_aura(_ref_target);

}