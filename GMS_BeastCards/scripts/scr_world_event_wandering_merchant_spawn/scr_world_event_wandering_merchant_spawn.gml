//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_WANDERING_MERCHANT_SPAWN
// FUNCTION: Creates Merrick as a normal OBJ_NPC at the persistent World Event
//           MERCHANT anchor and applies the event's already-rolled finite stock.
//
// RETURNS: Spawned NPC instance or noone.
//
//===============================================================================//

function scr_world_event_wandering_merchant_spawn(_stct_event,_stct_record){

	if (
		!is_struct(_stct_event) ||
		!is_struct(_stct_record) ||
		_stct_record._flag_resolved ||
		!is_struct(_stct_event._stct_payload)
	){
		return noone;
	}

	var _stct_payload =
		_stct_event._stct_payload;

	if (
		!variable_struct_exists(
			_stct_payload,
			"_arr_wandering_merchant_trade_stock"
		) ||
		!is_array(
			_stct_payload._arr_wandering_merchant_trade_stock
		)
	){
		return noone;
	}

	var _ref_spawn =
		scr_world_event_get_spawn_point_by_id(
			_stct_record._str_spawn_id,
			room
		);

	if (!instance_exists(_ref_spawn)){
		return noone;
	}

	var _uid_npc =
		_stct_payload._uid_wandering_merchant_npc;

	var _ref_npc =
		instance_create_layer(
			_stct_record._val_x,
			_stct_record._val_y,
			"ily_npcs",
			obj_npc,
			{
				_str_npc_id : "NPC_WANDERING_MERCHANT",
				_uid_npc : _uid_npc
			}
		);

	if (!instance_exists(_ref_npc)){
		return noone;
	}

	_ref_npc._stct_npc._arr_trade_stock =
		_stct_payload._arr_wandering_merchant_trade_stock;

	_ref_npc._flag_world_event_instance = true;
	_ref_npc._uid_world_event = _stct_event._uid_world_event;
	_ref_npc._uid_world_event_entity = _stct_record._uid_world_event_entity;
	_ref_npc._str_world_event_id = "WANDERING_MERCHANT";
	_ref_npc._str_world_event_spawn_id = _stct_record._str_spawn_id;

	return _ref_npc;
}
