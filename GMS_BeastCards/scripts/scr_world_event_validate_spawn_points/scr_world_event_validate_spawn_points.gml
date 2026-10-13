//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_VALIDATE_SPAWN_POINTS
// FUNCTION: Validates all World Event spawn points in the current room.
//           Duplicate stable IDs invalidate every duplicate occurrence.
//
// ARGUMENTS: _rm_room - Room to validate. Only the current room has live points.
// RETURNS: Validation summary struct.
//
//===============================================================================//

function scr_world_event_validate_spawn_points(_rm_room=room){

	var _stct_result = {
		_rm_room : _rm_room,
		_ct_total : 0,
		_ct_valid : 0,
		_ct_invalid : 0,
		_ct_duplicates : 0
	};

	if (_rm_room != room){
		return _stct_result;
	}

	var _ct_points =
		instance_number(
			obj_world_event_spawn_point
		);

	_stct_result._ct_total =
		_ct_points;

	//================//
	//NORMALIZE POINTS//
	//================//
	for (
		var _it_point = 0;
		_it_point < _ct_points;
		_it_point++
	){

		var _ref_point =
			instance_find(
				obj_world_event_spawn_point,
				_it_point
			);

		if (!instance_exists(_ref_point)){
			continue;
		}

		scr_world_event_normalize_spawn_point(
			_ref_point
		);
	}

	//================//
	//DUPLICATE IDS//
	//================//
	for (
		var _it_a = 0;
		_it_a < _ct_points;
		_it_a++
	){

		var _ref_a =
			instance_find(
				obj_world_event_spawn_point,
				_it_a
			);

		if (!instance_exists(_ref_a)){
			continue;
		}

		for (
			var _it_b = _it_a + 1;
			_it_b < _ct_points;
			_it_b++
		){

			var _ref_b =
				instance_find(
					obj_world_event_spawn_point,
					_it_b
				);

			if (!instance_exists(_ref_b)){
				continue;
			}

			if (
				_ref_a._str_spawn_id ==
				_ref_b._str_spawn_id
			){

				_ref_a._flag_world_event_spawn_point_valid =
					false;

				_ref_b._flag_world_event_spawn_point_valid =
					false;

				_stct_result
					._ct_duplicates++;

				scr_debug_log(
					"WORLD_EVENT",
					"SPAWN_POINT",
					_ref_a,
					"DUPLICATE WORLD EVENT SPAWN ID" +
					" | ID: " +
					_ref_a._str_spawn_id +
					" | ROOM: " +
					string_upper(
						room_get_name(
							room
						)
					),
					"ERROR",
					"SCR_WORLD_EVENT_VALIDATE_SPAWN_POINTS"
				);
			}
		}
	}

	//================//
	//FINAL COUNTS//
	//================//
	for (
		var _it_point = 0;
		_it_point < _ct_points;
		_it_point++
	){

		var _ref_point =
			instance_find(
				obj_world_event_spawn_point,
				_it_point
			);

		if (!instance_exists(_ref_point)){
			continue;
		}

		if (
			_ref_point
				._flag_world_event_spawn_point_valid
		){
			_stct_result._ct_valid++;
		}
		else{
			_stct_result._ct_invalid++;
		}
	}

	return _stct_result;
}
