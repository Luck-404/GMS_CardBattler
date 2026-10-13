//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_CREATE_EMPTY
// FUNCTION: Creates the canonical empty persistent World Event record.
//
// RETURNS: New World Event state struct.
//
//===============================================================================//

function scr_world_event_create_empty(){

	return {
		_uid_world_event : -1,
		_str_event_id : "",
		_str_display_name : "",

		_rm_target : undefined,
		_str_target_room_name : "",

		_state_world_event : ENUM_WORLD_EVENT_STATE.NONE,

		_val_announcement_time_remaining : 0,
		_val_active_time_remaining : 0,
		_val_cleanup_time_remaining : 0,

		_flag_room_initialized : false,
		_flag_announcement_pending : false,
		_flag_event_battle_active : false,

		_stct_payload : {},
		_arr_selected_spawn_ids : [],
		_arr_entity_records : [],

		_ct_progress : 0,
		_ct_goal : 0,

		_flag_completed : false,
		_flag_reward_claimed : false
	};
}
