//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_RAZOR_SHELL
// FUNCTION: Resolves Razor Shell.
//           For 3 rounds, successful enemy Attack damage against the caster
//           deals neutral damage to the attacker.
//
// ARGUMENTS: _stct_card is the Razor Shell card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_razor_shell(_stct_card,_ref_caster,_ref_target){

	//=================//
	//APPLY RAZOR SHELL//
	//=================//
	scr_status_apply_buff("RAZOR_SHELL", _ref_target, _stct_card._val_card_magnitude, 3);
}
