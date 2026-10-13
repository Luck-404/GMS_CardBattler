//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_GET_SPAWN_POINTS
// FUNCTION: Returns compatible live World Event spawn-point instances from the
//           current room. The returned instance references are transient and are
//           never stored as persistent event identity.
//
// ARGUMENTS: _rm_room - Room whose points are requested.
//            _str_category - GENERAL, MOB, TREASURE, MERCHANT, or ELITE.
//            _ct_min_capacity - Minimum point capacity.
// RETURNS: Array of compatible current-room instances.
//
//===============================================================================//

function scr_world_event_get_spawn_points(
	_rm_room=room,
	_str_category="GENERAL",
	_ct_min_capacity=1
){

	var _arr_points = [];

	if (_rm_room != room){
		return _arr_points;
	}

	_ct_min_capacity =
		max(
			1,
			floor(
				_ct_min_capacity
			)
		);

	var _ct_points =
		instance_number(
			obj_world_event_spawn_point
		);

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
			_ref_point._rm_spawn_room !=
			_rm_room
		){
			continue;
		}

		if (
			_ref_point._ct_spawn_capacity <
			_ct_min_capacity
		){
			continue;
		}

		if (
			!scr_world_event_spawn_point_allows(
				_ref_point,
				_str_category
			)
		){
			continue;
		}

		array_push(
			_arr_points,
			_ref_point
		);
	}

	return _arr_points;
}
