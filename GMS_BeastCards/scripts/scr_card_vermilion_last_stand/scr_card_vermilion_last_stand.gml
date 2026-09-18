//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_LAST_STAND
// FUNCTION: Resolves Last Stand.
//           Grants the selected allied Beast Last Stand for 3 rounds.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the allied Beast receiving Last Stand.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_last_stand(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	//================//
	//APPLY LAST STAND//
	//================//
	scr_status_apply_buff(
		"LAST_STAND",
		_stct_card._val_card_magnitude,
		3
	);
}