//===============================================================================//
//
// SCRIPT: SCR_STATUS_CLEANSE_DEBUFF
// FUNCTION: Removes Debuff Statuses from a target Beast.
//           Randomly removes the requested number of cleansable Debuffs.
//           May target one specific Debuff when a Status ID is supplied.
//
// ARGUMENTS: _ref_target is the Beast being cleansed, _ct_amount is the maximum
//            number removed, and _str_status_id optionally restricts the cleanse.
// RETURNS: The number of Debuff Statuses successfully removed.
//
//===============================================================================//

function scr_status_cleanse_debuff(_ref_target,_ct_amount,_str_status_id=undefined){

	//==================//
	//CLEANSE DEBUFFS//
	//==================//
	return scr_status_cleanse_type(
		_ref_target,
		"DEBUFF",
		_ct_amount,
		_str_status_id
	);
}