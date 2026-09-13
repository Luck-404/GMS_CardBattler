//===============================================================================//
//
// SCRIPT: SCR_STATUS_CLEANSE_DOT
// FUNCTION: Removes damage-over-time Statuses from a target Beast.
//           Randomly removes the requested number of cleansable DoTs.
//           May target one specific DoT when a Status ID is supplied.
//
// ARGUMENTS: _ref_target is the Beast being cleansed, _ct_amount is the maximum
//            number removed, and _str_status_id optionally restricts the cleanse.
// RETURNS: The number of DoT Statuses successfully removed.
//
//===============================================================================//

function scr_status_cleanse_dot(_ref_target,_ct_amount,_str_status_id=undefined){

	//===============//
	//CLEANSE DOTS//
	//===============//
	return scr_status_cleanse_type(
		_ref_target,
		"DOT",
		_ct_amount,
		_str_status_id
	);
}