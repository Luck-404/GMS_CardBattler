//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_BITTER_CHILL
// FUNCTION: Resolves Bitter Chill.
//           Applies 1 Frostbite and Weakness to the selected target.
//
// ARGUMENTS: _stct_card is the Bitter Chill card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_bitter_chill(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY FROSTBITE//
	//================//
	scr_status_apply_dot("FROSTBITE");

	//================//
	//APPLY WEAKNESS//
	//================//
	scr_status_apply_debuff("WEAKNESS");
}