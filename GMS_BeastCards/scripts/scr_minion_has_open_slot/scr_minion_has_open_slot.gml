//===============================================================================//
//
// SCRIPT: scr_minion_has_open_slot
// FUNCTION: Returns whether a Beast has room for another minion.
//
//===============================================================================//

function scr_minion_has_open_slot(_ref_target){

	if (!instance_exists(_ref_target)){
		return false;
	}

	return ds_list_size(_ref_target._list_minions) < _ref_target._ct_minions_max;
}