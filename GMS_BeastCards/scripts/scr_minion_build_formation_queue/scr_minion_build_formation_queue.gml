//===============================================================================//
//
// SCRIPT: SCR_MINION_BUILD_FORMATION_QUEUE
// FUNCTION: Builds a snapshot Minion activation queue for one active team.
//           Uses the team's current living-Beast formation order from front to back.
//           Keeps each host's Minions together in their existing list order.
//
// ARGUMENTS: _list_beasts_alive - Active team's living Beast list in formation order.
//
// RETURNS:  Array containing the Minions in activation order.
//
//===============================================================================//

function scr_minion_build_formation_queue(_list_beasts_alive){

	#region VARIABLES

	var _arr_return = [];

	#endregion

	#region VALIDATION

	//--------------------//
	//VALIDATE BEAST LIST//
	//--------------------//
	if (!ds_exists(_list_beasts_alive,ds_type_list)){
		return _arr_return;
	}

	#endregion

	#region MINION QUEUE

	//===========================//
	//BUILD FRONT-TO-BACK QUEUE//
	//===========================//
	/*
		The living-Beast list is the authoritative formation order.
		Index 0 is the front Beast and later indexes move toward the back.

		Minions remain grouped by host and preserve their existing order
		inside each host's Minion list.

		This queue is a snapshot created when the Minion phase begins.
	*/
	for (
		var _it_beast = 0;
		_it_beast < ds_list_size(_list_beasts_alive);
		_it_beast++
	){

		var _ref_host =
			ds_list_find_value(
				_list_beasts_alive,
				_it_beast
			);

		if (!instance_exists(_ref_host)){
			continue;
		}

		if (
			_ref_host._str_list != "ALIVE" ||
			_ref_host._val_cur_hp <= 0
		){
			continue;
		}

		if (!ds_exists(_ref_host._list_minions,ds_type_list)){
			continue;
		}

		for (
			var _it_minion = 0;
			_it_minion < ds_list_size(_ref_host._list_minions);
			_it_minion++
		){

			var _ref_minion =
				ds_list_find_value(
					_ref_host._list_minions,
					_it_minion
				);

			if (!instance_exists(_ref_minion)){
				continue;
			}

			array_push(
				_arr_return,
				_ref_minion
			);
		}
	}

	#endregion

	return _arr_return;
}
