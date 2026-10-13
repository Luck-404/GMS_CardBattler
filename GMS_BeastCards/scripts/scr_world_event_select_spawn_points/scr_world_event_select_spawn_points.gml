//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_SELECT_SPAWN_POINTS
// FUNCTION: Randomly selects unique compatible spawn points from the current
//           room. Selection is transient; callers should persist only each
//           point's _str_spawn_id.
//
// ARGUMENTS: _rm_room - Current target room.
//            _str_category - Required spawn category.
//            _ct_requested - Maximum unique points requested.
//            _ct_min_capacity - Minimum point capacity.
// RETURNS: Array of unique spawn-point instances.
//
//===============================================================================//

function scr_world_event_select_spawn_points(
	_rm_room=room,
	_str_category="GENERAL",
	_ct_requested=1,
	_ct_min_capacity=1
){

	var _arr_selected = [];

	if (_rm_room != room){
		return _arr_selected;
	}

	_ct_requested =
		max(
			0,
			floor(
				_ct_requested
			)
		);

	if (_ct_requested <= 0){
		return _arr_selected;
	}

	var _arr_candidates =
		scr_world_event_get_spawn_points(
			_rm_room,
			_str_category,
			_ct_min_capacity
		);

	var _list_candidates =
		ds_list_create();

	for (
		var _it_candidate = 0;
		_it_candidate <
			array_length(
				_arr_candidates
			);
		_it_candidate++
	){

		ds_list_add(
			_list_candidates,
			_arr_candidates[
				_it_candidate
			]
		);
	}

	while (
		ds_list_size(
			_list_candidates
		) > 0 &&
		array_length(
			_arr_selected
		) < _ct_requested
	){

		var _it_pick =
			irandom(
				ds_list_size(
					_list_candidates
				) - 1
			);

		var _ref_pick =
			ds_list_find_value(
				_list_candidates,
				_it_pick
			);

		ds_list_delete(
			_list_candidates,
			_it_pick
		);

		if (!instance_exists(_ref_pick)){
			continue;
		}

		array_push(
			_arr_selected,
			_ref_pick
		);
	}

	ds_list_destroy(
		_list_candidates
	);

	return _arr_selected;
}
