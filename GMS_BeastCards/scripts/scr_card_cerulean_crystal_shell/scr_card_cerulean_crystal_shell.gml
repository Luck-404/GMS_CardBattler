//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CRYSTAL_SHELL
// FUNCTION: Resolves Crystal Shell.
//           Grants the selected allied Beast 2 Divine Protection.
//
// ARGUMENTS: _stct_card is the Crystal Shell card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_crystal_shell(_stct_card,_ref_caster,_ref_target){

	//================//
	//VALIDATE TARGET//
	//================//
	if (!instance_exists(_ref_target)){
		return;
	}

	//================//
	//TARGET BEAST//
	//================//
	var _ref_original_target = global.ref_target_beast;
	global.ref_target_beast = _ref_target;

	//========================//
	//GAIN DIVINE PROTECTION//
	//========================//
	scr_status_apply_buff(
		"DIVINE_PROTECTION",
		2
	);

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;
}