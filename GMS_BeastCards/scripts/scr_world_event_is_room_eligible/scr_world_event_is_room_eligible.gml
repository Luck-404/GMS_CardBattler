//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_IS_ROOM_ELIGIBLE
// FUNCTION: Returns whether a room is registered for V1 World Events.
//
// ARGUMENTS: _rm_room - Room asset to inspect.
// RETURNS: True when World Events may target the room.
//
//===============================================================================//

function scr_world_event_is_room_eligible(_rm_room){

	var _stct_room_info =
		scr_world_event_get_room_info(
			_rm_room
		);

	return
		is_struct(
			_stct_room_info
		) &&
		_stct_room_info
			._flag_world_event_eligible;
}
