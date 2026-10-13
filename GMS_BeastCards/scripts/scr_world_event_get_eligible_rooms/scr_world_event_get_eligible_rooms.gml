//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_GET_ELIGIBLE_ROOMS
// FUNCTION: Returns the V1 room assets eligible to receive World Events.
//
// RETURNS: Array of eligible overworld room assets.
//
//===============================================================================//

function scr_world_event_get_eligible_rooms(){

	return [
		rm_ow_center,
		rm_ow_northwest,
		rm_ow_north,
		rm_ow_northeast,
		rm_ow_west,
		rm_ow_east,
		rm_ow_southwest,
		rm_ow_south,
		rm_ow_southeast,
		rm_ow_lakeside
	];
}
