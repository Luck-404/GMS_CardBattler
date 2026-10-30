//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_CREATE
// FUNCTION: Creates one persistent World Event. Normal callers require an eligible room; the optional debug flag permits Cheats to target the explicitly selected room.
//
//===============================================================================//

function scr_world_event_create(
	_str_event_id,
	_rm_target,
	_stct_payload=undefined,
	_flag_debug_force_room=false
){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return undefined;
	}

	//================//
//AVAILABLE SLOT//
//================//
	if (
		is_struct(
			_ref_controller
				._stct_active_world_event
		) &&
		_ref_controller
			._stct_active_world_event
			._state_world_event !=
		ENUM_WORLD_EVENT_STATE.NONE
	){
		return undefined;
	}

	//================//
//EVENT INFO//
//================//
	var _stct_event_info =
		scr_world_event_get_info(
			_str_event_id
		);

	if (!is_struct(_stct_event_info)){
		return undefined;
	}

	//================//
//ROOM INFO//
//================//
	var _stct_room_info =
		scr_world_event_get_room_info(
			_rm_target
		);

	if (!is_struct(_stct_room_info)){

		if (!_flag_debug_force_room){
			return undefined;
		}

		_stct_room_info = {
			_rm_room : _rm_target,
			_str_room_id : string_upper(room_get_name(_rm_target)),
			_str_display_name : string_upper(room_get_name(_rm_target)),
			_str_banner : string_upper(room_get_name(_rm_target)),
			_flag_world_event_eligible : true
		};
	}
	else if (
		!_stct_room_info._flag_world_event_eligible &&
		!_flag_debug_force_room
	){
		return undefined;
	}

	//================//
//PAYLOAD//
//================//
	if (!is_struct(_stct_payload)){
		_stct_payload = {};
	}

	//================//
//CREATE STATE//
//================//
	var _stct_world_event =
		scr_world_event_create_empty();

	_stct_world_event._uid_world_event =
		scr_world_event_allocate_event_uid();

	_stct_world_event._str_event_id =
		_stct_event_info
			._str_event_id;

	_stct_world_event._str_display_name =
		_stct_event_info
			._str_display_name;

	_stct_world_event._rm_target =
		_stct_room_info
			._rm_room;

	_stct_world_event._str_target_room_name =
		_stct_room_info
			._str_display_name;

	_stct_world_event._state_world_event =
		ENUM_WORLD_EVENT_STATE.ANNOUNCED;

	_stct_world_event._val_announcement_time_remaining =
		_ref_controller
			._val_travel_duration_seconds;

	_stct_world_event._val_active_time_remaining =
		_ref_controller
			._val_active_duration_seconds;

	_stct_world_event._val_cleanup_time_remaining =
		0;

	_stct_world_event._flag_room_initialized =
		false;

	_stct_world_event._flag_announcement_pending =
		true;

	_stct_world_event._flag_event_battle_active =
		false;

	_stct_world_event._stct_payload =
		_stct_payload;

	_ref_controller._stct_active_world_event =
		_stct_world_event;

	//================//
//DEBUG//
//================//
	scr_debug_log(
		"WORLD_EVENT",
		"CREATE",
		_ref_controller,
		"WORLD EVENT CREATED" +
		" | UID: " +
		string(
			_stct_world_event
				._uid_world_event
		) +
		" | EVENT: " +
		_stct_world_event
			._str_event_id +
		" | TARGET: " +
		_stct_world_event
			._str_target_room_name +
		" | TRAVEL: " +
		string(
			_stct_world_event
				._val_announcement_time_remaining
		) +
		" SEC",
		"INFO",
		"SCR_WORLD_EVENT_CREATE"
	);

	return _stct_world_event;
}
