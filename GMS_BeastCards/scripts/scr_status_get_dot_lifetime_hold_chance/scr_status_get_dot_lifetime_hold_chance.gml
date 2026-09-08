//===============================================================================//
//
// SCRIPT: scr_status_get_dot_lifetime_hold_chance
// FUNCTION: Returns the highest active chance for a Beast's DoTs
//           to preserve their duration when they tick.
//
//===============================================================================//

function scr_status_get_dot_lifetime_hold_chance(_ref_host){

	if (!instance_exists(_ref_host)){
		return 0;
	}

	var _val_hold_chance =
		0;

	for (
		var _it_status = 0;
		_it_status < ds_list_size(_ref_host._list_statuses);
		_it_status++
	){

		var _ref_status =
			ds_list_find_value(
				_ref_host._list_statuses,
				_it_status
			);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (
			!variable_instance_exists(
				_ref_status,
				"_val_dot_lifetime_hold_chance"
			)
		){
			continue;
		}

		_val_hold_chance =
			max(
				_val_hold_chance,
				_ref_status._val_dot_lifetime_hold_chance
			);
	}

	return clamp(_val_hold_chance,0,100);
}