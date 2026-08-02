//===============================================================================//
//
// SCRIPT: SCR_CLEANSE_DEBUFF
// FUNCTION: Removes debuff statuses from a target Beast.
//           Randomly removes the requested number of cleansable debuffs.
//           Supports future targeting of a specific status ID.
//
//===============================================================================//

function scr_cleanse_debuff(_ref_target,_ct_amount,_str_status_id=undefined){

	//------------------------//
	//FUTURE SPECIFIC STATUS//
	//------------------------//
	// _str_status_id may later specify a particular debuff status.

	return scr_cleanse_status_type(_ref_target,"DEBUFF",_ct_amount,_str_status_id);
}