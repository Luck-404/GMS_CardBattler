//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_EMBER_TURRET
// FUNCTION: Resolves Ember Turret.
//           Summons an Ember Turret on the selected allied Beast.
//
// ARGUMENTS: _stct_card is the Ember Turret Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is the selected allied Beast.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_ember_turret(_stct_card,_ref_caster,_ref_target){

	//====================//
	//SUMMON EMBER TURRET//
	//====================//
	scr_minion_init(
		"EMBER_TURRET",
		_stct_card,
		_ref_caster,
		_ref_target
	);
}