//===============================================================================//
//
// CLEAN UP: OBJ_WORLD_EVENT_CONTROLLER
// FUNCTION: Releases the cached global controller reference when this persistent
//           singleton is actually destroyed.
//
//===============================================================================//

if (
	variable_global_exists(
		"ref_world_event_controller"
	) &&
	global.ref_world_event_controller ==
	id
){
	global.ref_world_event_controller =
		undefined;
}
