//===============================================================================//
//
// SCRIPT: SCR_CLEANSE_CC
// FUNCTION: Removes Crowd Control statuses from a target Beast.
//           Randomly removes the requested number of cleansable CC statuses.
//           Supports future targeting of a specific status ID.
//
//===============================================================================//

function scr_cleanse_cc(_ref_target,_ct_amount,_str_status_id=undefined){

	//------------------------//
	//FUTURE SPECIFIC STATUS//
	//------------------------//
	// _str_status_id may later specify a particular CC status.

	return scr_cleanse_status_type(_ref_target,"CC",_ct_amount,_str_status_id);
}