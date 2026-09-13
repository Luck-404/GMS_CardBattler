//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_CURE_ALL
// FUNCTION: Resolves Cure All.
//           Removes every cleansable negative status from the selected Beast.
//           Negative statuses include Debuffs, DoTs, and Crowd Control.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: True if the card resolves, otherwise false.
//
//===============================================================================//

function scr_card_viridian_cure_all(_stct_card,_ref_caster,_ref_target){

	//================//
	//VALIDATE TARGET//
	//================//
	if (!instance_exists(_ref_target)){
		return false;
	}

	//=========================//
	//CLEANSE NEGATIVE STATUSES//
	//=========================//
	scr_status_cleanse_negative(
		_ref_target,
		ds_list_size(_ref_target._list_statuses)
	);

	return true;
}