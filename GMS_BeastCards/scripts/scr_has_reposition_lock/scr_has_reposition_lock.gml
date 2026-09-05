//===============================================================================//
//
// SCRIPT: SCR_HAS_REPOSITION_LOCK
// FUNCTION: Returns whether a Beast currently has any active source
//           preventing repositioning.
//           Supports overlapping independent movement-lock sources.
//           Source-Min​​ion effects only function while their source is active.
//
//===============================================================================//

function scr_has_reposition_lock(_ref_beast){

	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (
		_ref_beast._str_list != "ALIVE" ||
		_ref_beast._val_cur_hp <= 0
	){
		return false;
	}

	for (
		var _it_status = 0;
		_it_status < ds_list_size(_ref_beast._list_statuses);
		_it_status++
	){

		var _ref_status =
			ds_list_find_value(
				_ref_beast._list_statuses,
				_it_status
			);

		if (!instance_exists(_ref_status)){
			continue;
		}

		//--------------------------------//
		//CHECK LIVE MINION REQUIREMENT//
		//--------------------------------//
		if (
			variable_instance_exists(
				_ref_status,
				"_flag_status_requires_live_source_minion"
			) &&
			_ref_status._flag_status_requires_live_source_minion
		){

			if (!instance_exists(_ref_status._ref_source_minion)){
				continue;
			}

			var _ref_source_host =
				_ref_status
					._ref_source_minion
					._ref_host;

			if (!instance_exists(_ref_source_host)){
				continue;
			}

			if (
				_ref_source_host._str_list != "ALIVE" ||
				_ref_source_host._val_cur_hp <= 0
			){
				continue;
			}
		}

		//---------------------//
		//CHECK MOVEMENT LOCK//
		//---------------------//
		if (
			variable_instance_exists(
				_ref_status,
				"_flag_status_prevent_reposition"
			) &&
			_ref_status._flag_status_prevent_reposition
		){
			return true;
		}
	}

	return false;
}