//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_BITTER_CHILL
// FUNCTION: Resolves the Bitter Chill card effect.
//           Applies 1 Frostbite and Weakness to the selected target.
//
//===============================================================================//

function scr_card_cerulean_bitter_chill(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	//----------------//
	//APPLY FROSTBITE//
	//----------------//
	scr_status_apply_dot("FROSTBITE");

	//----------------//
	//APPLY WEAKNESS//
	//----------------//
	scr_status_apply_debuff("WEAKNESS");
}