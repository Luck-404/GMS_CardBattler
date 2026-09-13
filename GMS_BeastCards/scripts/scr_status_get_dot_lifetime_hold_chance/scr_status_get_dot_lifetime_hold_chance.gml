//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_DOT_LIFETIME_HOLD_CHANCE
// FUNCTION: Returns the highest active chance for a Beast's DoTs to preserve
//           their duration when they tick.
//
// ARGUMENTS: _ref_host is the Beast whose active Statuses are checked.
// RETURNS: The highest active DoT lifetime hold chance from 0 to 100.
//
//===============================================================================//

function scr_status_get_dot_lifetime_hold_chance(_ref_host){

	//---------------//
	//VALIDATE HOST//
	//---------------//
	if (!instance_exists(_ref_host)){
		return 0;
	}

	if (!ds_exists(_ref_host._list_statuses,ds_type_list)){
		return 0;
	}

	var _val_hold_chance = 0;

	//===================//
	//CHECK ALL STATUSES//
	//===================//
	for (var _it_status = 0;_it_status < ds_list_size(_ref_host._list_statuses);_it_status++){

		var _ref_status = ds_list_find_value(_ref_host._list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		//-------------------//
		//CHECK HOLD CHANCE//
		//-------------------//
		if (!variable_instance_exists(_ref_status,"_val_dot_lifetime_hold_chance")){
			continue;
		}

		_val_hold_chance = max(
			_val_hold_chance,
			_ref_status._val_dot_lifetime_hold_chance
		);
	}

	return clamp(_val_hold_chance,0,100);
}