//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_INSPIRATION
// FUNCTION: Resolves Inspiration.
//           Applies Inspiration using the Card's Magnitude for 3 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_uncolored_inspiration(_stct_card,_ref_caster,_ref_target){

	//===================//
	//APPLY BUFF STATUS//
	//===================//
	scr_status_apply_buff(
		"INSPIRATION",
		_ref_caster,
		_stct_card._val_card_magnitude,
		3
	);
}
