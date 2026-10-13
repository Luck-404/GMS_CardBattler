//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_GET_SPAWN_POINT_BY_ID
// FUNCTION: Resolves a persisted logical spawn-point ID back to the matching
//           valid spawn-point instance in the current room.
//
// ARGUMENTS: _str_spawn_id - Stable logical spawn ID.
//            _rm_room - Expected room.
// RETURNS: Matching current-room instance or noone.
//
//===============================================================================//

function scr_world_event_get_spawn_point_by_id(
	_str_spawn_id,
	_rm_room=room
){

	if (_rm_room != room){
		return noone;
	}

	_str_spawn_id =
		string_upper(
			string(
				_str_spawn_id
			)
		);

	if (_str_spawn_id == ""){
		return noone;
	}

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
			_ref_point._rm_spawn_room ==
			_rm_room &&
			_ref_point._str_spawn_id ==
			_str_spawn_id &&
			_ref_point
				._flag_world_event_spawn_point_valid
		){
			return _ref_point;
		}
	}

	return noone;
}
