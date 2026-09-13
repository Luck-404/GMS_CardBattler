//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CRYOGENIC_RECOVERY
// FUNCTION: Resolves Cryogenic Recovery.
//           Heals the selected target for the card magnitude.
//           Cleanses 1 CC.
//
// ARGUMENTS: _stct_card is the Cryogenic Recovery card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_cryogenic_recovery(_stct_card,_ref_caster,_ref_target){

	//================//
	//VALIDATE TARGET//
	//================//
	if (!instance_exists(_ref_target)){
		return;
	}

	//================//
	//HEAL TARGET//
	//================//
	scr_battle_heal_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//================//
	//CLEANSE CC//
	//================//
	scr_status_cleanse_cc(
		_ref_target,
		1
	);
}