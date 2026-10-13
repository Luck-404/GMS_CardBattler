//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_GET_STATE_NAME
// FUNCTION: Returns a debug/display string for a World Event lifecycle state.
//
// ARGUMENTS: _state_world_event - ENUM_WORLD_EVENT_STATE value.
// RETURNS: Uppercase lifecycle name.
//
//===============================================================================//

function scr_world_event_get_state_name(_state_world_event){

	switch (_state_world_event){

		case ENUM_WORLD_EVENT_STATE.NONE:
			return "NONE";

		case ENUM_WORLD_EVENT_STATE.ANNOUNCED:
			return "ANNOUNCED";

		case ENUM_WORLD_EVENT_STATE.ACTIVE:
			return "ACTIVE";

		case ENUM_WORLD_EVENT_STATE.COMPLETED:
			return "COMPLETED";

		case ENUM_WORLD_EVENT_STATE.EXPIRED:
			return "EXPIRED";

		case ENUM_WORLD_EVENT_STATE.CLEANUP:
			return "CLEANUP";
	}

	return "UNKNOWN";
}
