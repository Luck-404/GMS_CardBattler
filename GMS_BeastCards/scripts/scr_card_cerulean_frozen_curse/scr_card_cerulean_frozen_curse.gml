//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROZEN_CURSE
// FUNCTION: Resolves Frozen Curse.
//           Applies Frozen Curse for 3 rounds.
//
// ARGUMENTS: _stct_card is the Frozen Curse card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_frozen_curse(_stct_card,_ref_caster,_ref_target){

	//===================//
	//APPLY FROZEN CURSE//
	//===================//
	scr_status_apply_debuff("FROZEN_CURSE", _ref_target, 3);
}