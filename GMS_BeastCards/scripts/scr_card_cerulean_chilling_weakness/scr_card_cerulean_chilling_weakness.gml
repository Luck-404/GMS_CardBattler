//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CHILLING_WEAKNESS
// FUNCTION: Resolves Chilling Weakness.
//           Applies Weakness for 3 rounds.
//
// ARGUMENTS: _stct_card is the Chilling Weakness card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_chilling_weakness(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY WEAKNESS//
	//================//
	scr_status_apply_debuff("WEAKNESS", _ref_target, 3);
}