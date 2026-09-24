//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BURNING_PARRY
// FUNCTION: Resolves Burning Parry.
//           Grants the caster Burning Parry for 2 rounds.
//           The next enemy Melee Attack against the caster is blocked and
//           answered with linear Physical damage.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the caster for this Self-target Card.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_burning_parry(_stct_card,_ref_caster,_ref_target){

	//=====================//
	//GAIN BURNING PARRY//
	//=====================//
	scr_status_apply_buff("BURNING_PARRY", _ref_caster, _stct_card._val_card_magnitude, 2);

}
