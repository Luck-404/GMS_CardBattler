//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_MANA_SPRING
// FUNCTION: Resolves Mana Spring.
//           Grants increased maximum and current Mana for 3 rounds.
//
// ARGUMENTS: _stct_card is the Mana Spring card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_mana_spring(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY MANA BUFF//
	//================//
	scr_status_apply_buff(
		"MANA_SPRING",
		_stct_card._val_card_magnitude,
		3
	);
}