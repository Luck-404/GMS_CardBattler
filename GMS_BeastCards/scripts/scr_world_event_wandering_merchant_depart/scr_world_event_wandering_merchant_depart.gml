//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_WANDERING_MERCHANT_DEPART
// FUNCTION: Ends the Wandering Merchant event early only when the player
//           explicitly chooses SEND AWAY. No premium completion reward is granted;
//           access to the merchant's special shop is the event reward.
//
// RETURNS: True when the active merchant event enters cleanup.
//
//===============================================================================//

function scr_world_event_wandering_merchant_depart(){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	var _stct_event =
		_ref_controller._stct_active_world_event;

	if (
		!is_struct(_stct_event) ||
		_stct_event._str_event_id != "WANDERING_MERCHANT" ||
		_stct_event._state_world_event != ENUM_WORLD_EVENT_STATE.ACTIVE
	){
		return false;
	}

	if (!is_struct(_stct_event._stct_payload)){
		_stct_event._stct_payload = {};
	}

	_stct_event._stct_payload._flag_wandering_merchant_sent_away = true;
	_stct_event._val_active_time_remaining = 0;
	_stct_event._val_cleanup_time_remaining = 0;
	_stct_event._state_world_event = ENUM_WORLD_EVENT_STATE.CLEANUP;

	scr_world_event_show_banner(
		"WANDERING MERCHANT DEPARTED",
		"MERRICK PACKS UP HIS WARES",
		"SAFE TRAVELS"
	);

	scr_debug_log(
		"WORLD_EVENT",
		"MERCHANT",
		_ref_controller,
		"WANDERING MERCHANT SENT AWAY" +
		" | EVENT UID: " + string(_stct_event._uid_world_event) +
		" | ROOM: " + _stct_event._str_target_room_name,
		"INFO",
		"SCR_WORLD_EVENT_WANDERING_MERCHANT_DEPART"
	);

	return true;
}
