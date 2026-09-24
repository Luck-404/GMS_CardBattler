//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_MELTING_ARMAMENTS
// FUNCTION: Grants the selected Beast Melting Armaments for 3 rounds.
//           Its Attack hits destroy up to 4 Armor before normal damage.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_melting_armaments(_stct_card,_ref_caster,_ref_target){

	//========================//
	//APPLY MELTING ARMAMENTS//
	//========================//
	scr_status_apply_buff("MELTING_ARMAMENTS", _ref_target, 4, 3);
}