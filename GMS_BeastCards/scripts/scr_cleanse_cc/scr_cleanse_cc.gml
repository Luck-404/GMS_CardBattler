//===============================================================================//
//
// SCRIPT: SCR_STATUS_CLEANSE_CC
// FUNCTION: Removes Crowd Control Statuses from a target Beast.
//           Randomly removes the requested number of cleansable CC Statuses.
//           May target one specific CC Status when a Status ID is supplied.
//
//===============================================================================//

function scr_status_cleanse_cc(_ref_target,_ct_amount,_str_status_id=undefined){

	//------------//
	//CLEANSE CC//
	//------------//
	return scr_status_cleanse_type(
		_ref_target,
		"CC",
		_ct_amount,
		_str_status_id
	);
}