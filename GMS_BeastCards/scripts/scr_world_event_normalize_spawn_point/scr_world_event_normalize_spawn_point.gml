//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_NORMALIZE_SPAWN_POINT
// FUNCTION: Normalizes one placed World Event spawn point after room-instance
//           overrides have been applied. Explicit spawn IDs are preferred.
//           Blank IDs receive a deterministic room/position fallback for testing.
//
// ARGUMENTS: _ref_spawn_point - OBJ_WORLD_EVENT_SPAWN_POINT instance.
// RETURNS: True when the point has usable configuration.
//
//===============================================================================//

function scr_world_event_normalize_spawn_point(_ref_spawn_point){

	if (!instance_exists(_ref_spawn_point)){
		return false;
	}

	//================//
	//DEFAULT FIELDS//
	//================//
	if (!variable_instance_exists(_ref_spawn_point,"_str_spawn_id")){
		_ref_spawn_point._str_spawn_id = "";
	}

	if (!variable_instance_exists(_ref_spawn_point,"_ct_spawn_capacity")){
		_ref_spawn_point._ct_spawn_capacity = 5;
	}

	if (!variable_instance_exists(_ref_spawn_point,"_val_spawn_radius")){
		_ref_spawn_point._val_spawn_radius = 96;
	}

	if (!variable_instance_exists(_ref_spawn_point,"_val_mob_leash_radius")){
		_ref_spawn_point._val_mob_leash_radius = 128;
	}

	if (!variable_instance_exists(_ref_spawn_point,"_flag_allow_mobs")){
		_ref_spawn_point._flag_allow_mobs = true;
	}

	if (!variable_instance_exists(_ref_spawn_point,"_flag_allow_treasure")){
		_ref_spawn_point._flag_allow_treasure = true;
	}

	if (!variable_instance_exists(_ref_spawn_point,"_flag_allow_merchant")){
		_ref_spawn_point._flag_allow_merchant = true;
	}

	if (!variable_instance_exists(_ref_spawn_point,"_flag_allow_elite")){
		_ref_spawn_point._flag_allow_elite = true;
	}

	//================//
	//ROOM IDENTITY//
	//================//
	_ref_spawn_point._rm_spawn_room =
		room;

	//================//
	//NORMALIZE VALUES//
	//================//
	_ref_spawn_point._ct_spawn_capacity =
		max(
			1,
			floor(
				real(
					_ref_spawn_point
						._ct_spawn_capacity
				)
			)
		);

	_ref_spawn_point._val_spawn_radius =
		max(
			0,
			real(
				_ref_spawn_point
					._val_spawn_radius
			)
		);

	_ref_spawn_point._val_mob_leash_radius =
		max(
			_ref_spawn_point
				._val_spawn_radius,
			real(
				_ref_spawn_point
					._val_mob_leash_radius
			)
		);

	_ref_spawn_point._str_spawn_id =
		string_upper(
			string(
				_ref_spawn_point
					._str_spawn_id
			)
		);

	//================//
	//FALLBACK ID//
	//================//
	_ref_spawn_point._flag_spawn_id_auto =
		false;

	if (_ref_spawn_point._str_spawn_id == ""){

		_ref_spawn_point._flag_spawn_id_auto =
			true;

		_ref_spawn_point._str_spawn_id =
			string_upper(
				room_get_name(
					room
				)
			) +
			"_SPAWN_" +
			string(
				round(
					_ref_spawn_point.x
				)
			) +
			"_" +
			string(
				round(
					_ref_spawn_point.y
				)
			);

		scr_debug_log(
			"WORLD_EVENT",
			"SPAWN_POINT",
			_ref_spawn_point,
			"WORLD EVENT SPAWN POINT USING AUTO ID" +
			" | ID: " +
			_ref_spawn_point._str_spawn_id +
			" | RECOMMENDATION: ASSIGN AN EXPLICIT STABLE _str_spawn_id",
			"WARNING",
			"SCR_WORLD_EVENT_NORMALIZE_SPAWN_POINT"
		);
	}

	//================//
	//CATEGORY CHECK//
	//================//
	var _flag_any_category =
		_ref_spawn_point._flag_allow_mobs ||
		_ref_spawn_point._flag_allow_treasure ||
		_ref_spawn_point._flag_allow_merchant ||
		_ref_spawn_point._flag_allow_elite;

	_ref_spawn_point._flag_world_event_spawn_point_valid =
		_flag_any_category;

	if (!_flag_any_category){

		scr_debug_log(
			"WORLD_EVENT",
			"SPAWN_POINT",
			_ref_spawn_point,
			"WORLD EVENT SPAWN POINT DISABLED" +
			" | ID: " +
			_ref_spawn_point._str_spawn_id +
			" | REASON: NO EVENT CATEGORIES ENABLED",
			"WARNING",
			"SCR_WORLD_EVENT_NORMALIZE_SPAWN_POINT"
		);
	}

	return
		_ref_spawn_point
			._flag_world_event_spawn_point_valid;
}
