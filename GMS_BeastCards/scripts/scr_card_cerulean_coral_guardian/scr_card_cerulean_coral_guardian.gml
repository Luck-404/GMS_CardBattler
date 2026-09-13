//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CORAL_GUARDIAN
// FUNCTION: Resolves Coral Guardian.
//           Summons a Coral Guardian on the caster.
//
// ARGUMENTS: _stct_card is the Coral Guardian card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_coral_guardian(_stct_card,_ref_caster,_ref_target){

	//======================//
	//SUMMON CORAL GUARDIAN//
	//======================//
	scr_minion_init(
		"CORAL_GUARDIAN",
		_stct_card,
		_ref_caster,
		_ref_caster
	);
}