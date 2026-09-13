//===============================================================================//
//
// SCRIPT: SCR_MINION_HAS_OPEN_SLOT
// FUNCTION: Returns whether a battle Beast has room for another Minion.
//
// INPUT:    _ref_host - Battle Beast whose Minion capacity is checked.
//
//===============================================================================//

function scr_minion_has_open_slot(_ref_host){

	//---------------//
	//VALIDATE HOST//
	//---------------//
	if (!instance_exists(_ref_host)){
		return false;
	}

	//--------------------//
	//VALIDATE MINION LIST//
	//--------------------//
	if (!ds_exists(_ref_host._list_minions,ds_type_list)){
		return false;
	}

	//----------------//
	//CHECK CAPACITY//
	//----------------//
	return ds_list_size(_ref_host._list_minions) < _ref_host._ct_minions_max;
}