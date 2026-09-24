//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_ANEMIA
// FUNCTION: Resolves Anemia.
//           Reduces the target's PHYPOW by 30 for 3 rounds.
//
// ARGUMENTS: _stct_card is the Anemia Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is the selected enemy Beast.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_anemia(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY ANEMIA//
	//================//
	scr_status_apply_debuff("ANEMIA", _ref_target, 3);
}
