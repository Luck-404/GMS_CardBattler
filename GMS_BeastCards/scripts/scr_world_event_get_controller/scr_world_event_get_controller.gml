//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_GET_CONTROLLER
// FUNCTION: Returns the persistent World Event controller and repairs the global
//           reference when the instance exists but the cached reference is stale.
//
// RETURNS: OBJ_WORLD_EVENT_CONTROLLER instance or noone.
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
	//FIND CONTROLLER//
	//================//
	if (instance_exists(obj_world_event_controller)){

		global.ref_world_event_controller =
			instance_find(
				obj_world_event_controller,
				0
			);

		return global.ref_world_event_controller;
	}

	return noone;
}
