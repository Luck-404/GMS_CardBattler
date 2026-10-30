//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_WANDERING_MERCHANT_SYNC_ROOM
// FUNCTION: Generates or reconstructs the Wandering Merchant from stable persistent event data after clearing stale same-event live room state on a fresh reconstruction.
//
//===============================================================================//

function scr_world_event_wandering_merchant_sync_room(){

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
		_stct_event._state_world_event != ENUM_WORLD_EVENT_STATE.ACTIVE ||
		room != _stct_event._rm_target
	){
		return false;
	}

	if (!is_struct(_stct_event._stct_payload)){
		_stct_event._stct_payload = {};
	}

	var _stct_payload =
		_stct_event._stct_payload;

	if (
		!variable_struct_exists(
			_stct_payload,
			"_flag_wandering_merchant_generated"
		) ||
		!_stct_payload._flag_wandering_merchant_generated
	){
		if (!scr_world_event_wandering_merchant_generate()){
			return false;
		}
	}

	if (
		variable_struct_exists(
			_stct_payload,
			"_flag_wandering_merchant_sent_away"
		) &&
		_stct_payload._flag_wandering_merchant_sent_away
	){
		return true;
	}

	//========================//
	//RECONSTRUCTION RESET//
	//========================//
	if (!_stct_event._flag_room_initialized){
		scr_world_event_cleanup_room_instances(_stct_event._uid_world_event);
	}

	var _uid_entity =
		_stct_payload._uid_wandering_merchant_entity;

	var _stct_record =
		scr_world_event_entity_record_get(
			_stct_event,
			_uid_entity
		);

	if (!is_struct(_stct_record)){
		return false;
	}

	var _flag_live = false;
	var _ct_npcs = instance_number(obj_npc);

	for (var _it_npc = 0;_it_npc < _ct_npcs;_it_npc++){

		var _ref_npc = instance_find(obj_npc,_it_npc);

		if (
			instance_exists(_ref_npc) &&
			variable_instance_exists(_ref_npc,"_flag_world_event_instance") &&
			_ref_npc._flag_world_event_instance &&
			variable_instance_exists(_ref_npc,"_uid_world_event_entity") &&
			_ref_npc._uid_world_event_entity == _uid_entity
		){
			_flag_live = true;
			break;
		}
	}

	if (!_flag_live){
		if (
			!instance_exists(
				scr_world_event_wandering_merchant_spawn(
					_stct_event,
					_stct_record
				)
			)
		){
			return false;
		}
	}

	_stct_event._flag_room_initialized = true;
	return true;
}
