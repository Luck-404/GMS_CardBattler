//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_CAN_ADVANCE_TIME
// FUNCTION: Returns whether World Event gameplay timers may advance this frame.
//           Timers pause during battle, GUI pause, and room/battle transitions.
//
// RETURNS: True only during stable unpaused overworld gameplay.
//
//===============================================================================//

function scr_world_event_can_advance_time(){

	if (room == rm_battle){
		return false;
	}

	if (
		variable_global_exists(
			"flag_pause"
		) &&
		global.flag_pause
	){
		return false;
	}

	if (
		instance_exists(
			obj_transition
		) ||
		instance_exists(
			obj_transition_fader
		)
	){
		return false;
	}

	if (!instance_exists(obj_player)){
		return false;
	}

	return true;
}
