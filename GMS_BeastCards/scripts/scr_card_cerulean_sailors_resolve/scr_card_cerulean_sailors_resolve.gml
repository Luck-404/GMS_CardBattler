//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SAILORS_RESOLVE
// FUNCTION: Resolves Sailor's Resolve.
//           Increases the selected allied Beast's healing received
//           for 3 rounds.
//
// ARGUMENTS: _stct_card is the Sailor's Resolve card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_sailors_resolve(_stct_card,_ref_caster,_ref_target){

	//=========================//
	//APPLY SAILOR'S RESOLVE//
	//=========================//
	scr_status_apply_buff(
		"SAILORS_RESOLVE",
		_stct_card._val_card_magnitude,
		3
	);
}