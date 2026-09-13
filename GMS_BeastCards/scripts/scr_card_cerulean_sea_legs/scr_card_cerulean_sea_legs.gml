//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SEA_LEGS
// FUNCTION: Resolves Sea Legs.
//           Grants the caster Immovable for 2 rounds.
//
// ARGUMENTS: _stct_card is the Sea Legs card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_sea_legs(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY IMMOVABLE//
	//================//
	scr_status_apply_buff(
		"IMMOVABLE",
		0,
		2
	);
}