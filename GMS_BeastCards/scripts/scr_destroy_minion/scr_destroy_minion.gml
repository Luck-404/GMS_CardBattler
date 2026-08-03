//===============================================================================//
//
// SCRIPT: SCR_DESTROY_MINION
// FUNCTION: Removes a battle minion.
//           Removes statuses sourced by that exact minion.
//           Removes the minion from its host list and destroys the instance.
//
//===============================================================================//

function scr_destroy_minion(_ref_minion){

	if (!instance_exists(_ref_minion)){
		return;
	}

	var _ref_host = _ref_minion._ref_host;

	//--------------------------------//
	//REMOVE SOURCE-LINKED STATUSES//
	//--------------------------------//
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

			if (_ref_status._ref_source_minion != _ref_minion){
				continue;
			}

			if (_ref_status._scr_status != undefined){
				_ref_status._scr_status("DEATH",_ref_status);
			}
			else{
				scr_destroy_status(_ref_status);
			}
		}

		//----------------------//
		//REMOVE FROM HOST LIST//
		//----------------------//
		var _it_minion =
			ds_list_find_index(
				_ref_host._list_minions,
				_ref_minion
			);

		if (_it_minion != -1){
			ds_list_delete(_ref_host._list_minions,_it_minion);
		}

		scr_reposition_minions(_ref_host);
		scr_reposition_statuses(_ref_host);
	}

	//---------------//
	//DESTROY MINION//
	//---------------//
	instance_destroy(_ref_minion);
}