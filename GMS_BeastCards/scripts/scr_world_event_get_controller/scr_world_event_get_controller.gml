//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_GET_CONTROLLER
// FUNCTION: Returns the persistent World Event controller.
//           Repairs the cached global reference when stale and self-creates the
//           singleton when no controller currently exists.
//
//           This removes any production dependency on OBJ_PLAYER Game Start.
//           Normal post-battle World Event rolls can therefore always obtain the
//           controller before performing their 1-in-50 roll.
//
// RETURNS: OBJ_WORLD_EVENT_CONTROLLER instance or noone on creation failure.
//
//===============================================================================//

function scr_world_event_get_controller(){

	//================//
	//CACHED REFERENCE//
	//================//
	if (
		variable_global_exists(
			"ref_world_event_controller"
		) &&
		instance_exists(
			global.ref_world_event_controller
		)
	){
		return global.ref_world_event_controller;
	}

	//================//
	//FIND SINGLETON//
	//================//
	if (instance_exists(obj_world_event_controller)){

		global.ref_world_event_controller =
			instance_find(
				obj_world_event_controller,
				0
			);

		return global.ref_world_event_controller;
	}

	//================//
	//SELF-CREATE//
	//================//
	// Use depth creation instead of a named room layer so this recovery path works
	// from either overworld rooms or rm_battle. The controller is persistent and its
	// Create event owns singleton protection and all normal initialization.
	var _ref_controller =
		instance_create_depth(
			0,
			0,
			0,
			obj_world_event_controller
		);

	if (!instance_exists(_ref_controller)){

		if (!variable_global_exists("ref_world_event_controller")){
			global.ref_world_event_controller = undefined;
		}

		scr_debug_log(
			"WORLD_EVENT",
			"CONTROLLER",
			undefined,
			"WORLD EVENT CONTROLLER CREATE FAILED" +
			" | ROOM: " +
			string_upper(room_get_name(room)),
			"ERROR",
			"SCR_WORLD_EVENT_GET_CONTROLLER"
		);

		return noone;
	}

	global.ref_world_event_controller =
		_ref_controller;

	scr_debug_log(
		"WORLD_EVENT",
		"CONTROLLER",
		_ref_controller,
		"WORLD EVENT CONTROLLER SELF-CREATED" +
		" | ROOM: " +
		string_upper(room_get_name(room)),
		"INFO",
		"SCR_WORLD_EVENT_GET_CONTROLLER"
	);

	return _ref_controller;
}