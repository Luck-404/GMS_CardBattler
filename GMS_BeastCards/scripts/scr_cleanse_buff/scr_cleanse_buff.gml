//===============================================================================//
//
// SCRIPT: SCR_CLEANSE_BUFF
// FUNCTION: Removes buff statuses from a target Beast.
//           Randomly removes the requested number of cleansable buffs.
//           May be used offensively against enemy positive effects.
//
//===============================================================================//

function scr_cleanse_buff(_ref_target,_ct_amount,_str_status_id=undefined){

	//------------------------//
	//FUTURE SPECIFIC STATUS//
	//------------------------//
	// _str_status_id may later specify a particular buff status.

	return scr_cleanse_status_type(_ref_target,"BUFF",_ct_amount,_str_status_id);
}