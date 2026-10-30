//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_CREATE_EMPTY_BATTLE_CONTEXT
// FUNCTION: Creates the canonical inactive battle-context record.
//
// RETURNS: New inactive battle-context struct.
//
//===============================================================================//

function scr_world_event_create_empty_battle_context(){

	return {
		_flag_active : false,

		_uid_world_event : -1,
		_str_event_id : "",

		_uid_world_event_entity : -1,
		_uid_world_event_pod : -1,

		_str_encounter_type : "",

		_rm_source : undefined,
		_str_source_room_name : "",

		_val_source_x : 0,
		_val_source_y : 0,

		_arr_enemy_uids : [],
		_arr_captured_enemy_uids : [],

		_flag_suppress_world_event_roll : false,

		_str_result : "",
		_flag_result_resolved : false
	};
}
