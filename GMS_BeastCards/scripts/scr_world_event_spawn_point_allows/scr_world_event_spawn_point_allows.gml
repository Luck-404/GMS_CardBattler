//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_SPAWN_POINT_ALLOWS
// FUNCTION: Returns whether a World Event spawn point permits a category.
//
// ARGUMENTS: _ref_spawn_point - Spawn point instance.
//            _str_category - GENERAL, MOB, TREASURE, MERCHANT, or ELITE.
// RETURNS: True when the point is valid and supports the category.
//
//===============================================================================//

function scr_world_event_spawn_point_allows(_ref_spawn_point,_str_category){

	if (!instance_exists(_ref_spawn_point)){
		return false;
	}

	if (
		!variable_instance_exists(
			_ref_spawn_point,
			"_flag_world_event_spawn_point_valid"
		) ||
		!_ref_spawn_point
			._flag_world_event_spawn_point_valid
	){
		return false;
	}

	_str_category =
		string_upper(
			string(
				_str_category
			)
		);

	switch (_str_category){

		case "GENERAL":
			return
				_ref_spawn_point._flag_allow_mobs ||
				_ref_spawn_point._flag_allow_treasure ||
				_ref_spawn_point._flag_allow_merchant ||
				_ref_spawn_point._flag_allow_elite;

		case "MOB":
			return
				_ref_spawn_point
					._flag_allow_mobs;

		case "TREASURE":
			return
				_ref_spawn_point
					._flag_allow_treasure;

		case "MERCHANT":
			return
				_ref_spawn_point
					._flag_allow_merchant;

		case "ELITE":
			return
				_ref_spawn_point
					._flag_allow_elite;
	}

	return false;
}
