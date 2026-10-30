//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_WANDERING_MERCHANT_GENERATE
// FUNCTION: Generates persistent Wandering Merchant data the first time the
//           player reaches the event room. Chooses one MERCHANT anchor and rolls
//           one stock list that remains stable for the entire World Event.
//
// RETURNS: True when persistent merchant data exists.
//
//===============================================================================//

function scr_world_event_wandering_merchant_generate(){

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
		variable_struct_exists(
			_stct_payload,
			"_flag_wandering_merchant_generated"
		) &&
		_stct_payload._flag_wandering_merchant_generated
	){
		return true;
	}

	scr_world_event_validate_spawn_points(room);

	var _arr_spawn_points =
		scr_world_event_select_spawn_points(
			room,
			"MERCHANT",
			1,
			1
		);

	if (array_length(_arr_spawn_points) <= 0){
		_stct_payload._str_wandering_merchant_error =
			"NO VALID MERCHANT SPAWN POINT";
		return false;
	}

	var _ref_spawn =
		_arr_spawn_points[0];

	if (!instance_exists(_ref_spawn)){
		return false;
	}

	var _arr_stock =
		scr_world_event_wandering_merchant_roll_stock();

	if (array_length(_arr_stock) <= 0){
		_stct_payload._str_wandering_merchant_error =
			"NO VALID MERCHANT STOCK";
		return false;
	}

	var _uid_entity =
		scr_world_event_allocate_entity_uid();

	if (_uid_entity < 0){
		return false;
	}

	var _uid_npc =
		1000000 + _uid_entity;

	var _stct_record =
		scr_world_event_entity_record_create(
			_stct_event._uid_world_event,
			_uid_entity,
			"MERCHANT_NPC",
			_ref_spawn._str_spawn_id,
			room,
			_ref_spawn.x,
			_ref_spawn.y,
			{
				_str_npc_id : "NPC_WANDERING_MERCHANT",
				_uid_npc : _uid_npc
			}
		);

	if (
		!scr_world_event_entity_record_add(
			_stct_event,
			_stct_record
		)
	){
		return false;
	}

	_stct_event._arr_selected_spawn_ids =
		[_ref_spawn._str_spawn_id];

	_stct_payload._flag_wandering_merchant_generated = true;
	_stct_payload._flag_wandering_merchant_sent_away = false;
	_stct_payload._str_wandering_merchant_error = "";
	_stct_payload._str_wandering_merchant_spawn_id =
		_ref_spawn._str_spawn_id;
	_stct_payload._uid_wandering_merchant_entity =
		_uid_entity;
	_stct_payload._uid_wandering_merchant_npc =
		_uid_npc;
	_stct_payload._arr_wandering_merchant_trade_stock =
		_arr_stock;

	_stct_event._flag_room_initialized = false;

	scr_debug_log(
		"WORLD_EVENT",
		"MERCHANT",
		_ref_controller,
		"WANDERING MERCHANT GENERATED" +
		" | EVENT UID: " + string(_stct_event._uid_world_event) +
		" | NPC UID: " + string(_uid_npc) +
		" | SPAWN: " + string_upper(_ref_spawn._str_spawn_id) +
		" | STOCK: " + string(array_length(_arr_stock)),
		"INFO",
		"SCR_WORLD_EVENT_WANDERING_MERCHANT_GENERATE"
	);

	return true;
}
