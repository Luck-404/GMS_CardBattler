//===============================================================================//
//
// SCRIPT: SCR_HAS_OPEN_MINION_SLOT
// FUNCTION: Returns whether a Beast has room for another minion.
//
//===============================================================================//

function scr_has_open_minion_slot(_ref_target){

	if (!instance_exists(_ref_target)){
		return false;
	}

	return ds_list_size(_ref_target._list_minions) < _ref_target._ct_minions_max;
}