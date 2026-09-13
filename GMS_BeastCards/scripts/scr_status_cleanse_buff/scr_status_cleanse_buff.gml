//===============================================================================//
//
// SCRIPT: SCR_STATUS_CLEANSE_BUFF
// FUNCTION: Removes Buff Statuses from a target Beast.
//           Randomly removes the requested number of cleansable Buffs.
//           May target one specific Buff when a Status ID is supplied.
//           May be used offensively against enemy positive effects.
//
//===============================================================================//

function scr_status_cleanse_buff(_ref_target,_ct_amount,_str_status_id=undefined){

	//--------------//
	//CLEANSE BUFF//
	//--------------//
	return scr_status_cleanse_type(
		_ref_target,
		"BUFF",
		_ct_amount,
		_str_status_id
	);
}