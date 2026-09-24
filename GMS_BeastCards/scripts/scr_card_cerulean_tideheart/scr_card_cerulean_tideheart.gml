//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_TIDEHEART
// FUNCTION: Resolves Tideheart.
//           Cleanses all negative statuses from the caster.
//           Adds 1 Echo through the shared Echo resource system.
//
// ARGUMENTS: _stct_card is the Tideheart card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_tideheart(_stct_card,_ref_caster,_ref_target){

	//=========================//
	//CLEANSE NEGATIVE STATUSES//
	//=========================//
	scr_status_cleanse(
		_ref_caster,
		"NEGATIVE",
		"ALL"
	);
	
	//================//
	//GAIN ECHO//
	//================//
	scr_status_gain_echo(1);
}