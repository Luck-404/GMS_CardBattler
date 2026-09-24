//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROSTFORM
// FUNCTION: Resolves Frostform.
//           Applies the Frostform Self Aura.
//
// ARGUMENTS: _stct_card is the Frostform card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_frostform(_stct_card,_ref_caster,_ref_target){


	//================//
	//APPLY FROSTFORM//
	//================//
	scr_status_apply_aura("FROSTFORM", _ref_caster, 0);

}