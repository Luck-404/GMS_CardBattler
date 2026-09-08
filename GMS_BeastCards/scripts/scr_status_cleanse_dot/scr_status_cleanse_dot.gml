//===============================================================================//
//
// SCRIPT: scr_status_cleanse_dot
// FUNCTION: Removes damage-over-time statuses from a target Beast.
//           Randomly removes the requested number of cleansable DoT statuses.
//           Removes the full status instance including all stacks.
//
//===============================================================================//

function scr_status_cleanse_dot(_ref_target,_ct_amount,_str_status_id=undefined){

	//------------------------//
	//FUTURE SPECIFIC STATUS//
	//------------------------//
	// _str_status_id may later specify a particular DoT status.

	return scr_status_cleanse_type(_ref_target,"DOT",_ct_amount,_str_status_id);
}