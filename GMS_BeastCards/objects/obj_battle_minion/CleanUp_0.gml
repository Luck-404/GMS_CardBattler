//===============================================================================//
//
// CLEANUP: OBJ_BATTLE_MINION
// FUNCTION: Cleans up effects linked to this minion.
//           Triggers the death behavior of statuses sourced by this minion.
//
//===============================================================================//

if (instance_exists(_ref_host)){

	for (
		var _it_status = ds_list_size(_ref_host._list_statuses) - 1;
		_it_status >= 0;
		_it_status--
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
			_ref_status._ref_source_minion !=
			self
		){
			continue;
		}

		if (_ref_status._scr_status != undefined){

			_ref_status._scr_status(
				"DEATH",
				_ref_status
			);
		}
		else{

			scr_destroy_status(
				_ref_status
			);
		}
	}
}