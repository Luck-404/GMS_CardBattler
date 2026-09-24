//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_LAST_STAND
// FUNCTION: Resolves Last Stand.
//           Grants the selected allied Beast Last Stand for 3 rounds.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the allied Beast receiving Last Stand.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_last_stand(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY LAST STAND//
	//================//
	scr_status_apply_buff("LAST_STAND", _ref_target, _stct_card._val_card_magnitude, 3);
}