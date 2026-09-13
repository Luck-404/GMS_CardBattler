//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ICE_ACCRETION
// FUNCTION: Resolves Ice Accretion.
//           Grants the selected allied Beast Armor at the end of each round
//           for 3 rounds.
//
// ARGUMENTS: _stct_card is the Ice Accretion card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_ice_accretion(_stct_card,_ref_caster,_ref_target){

	//======================//
	//APPLY ARMOR OVER TIME//
	//======================//
	scr_status_apply_buff(
		"ARMOR_OVER_TIME",
		_stct_card._val_card_magnitude,
		3
	);
}