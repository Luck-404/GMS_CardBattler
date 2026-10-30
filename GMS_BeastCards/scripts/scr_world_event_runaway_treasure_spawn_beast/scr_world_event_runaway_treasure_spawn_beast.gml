//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_RUNAWAY_TREASURE_SPAWN_BEAST
// FUNCTION: Reconstructs the unresolved Runaway Treasure Beast from persistent
//           event data. The Beast flees within its authored MOB anchor leash and
//           never enters battle.
//
//===============================================================================//

function scr_world_event_runaway_treasure_spawn_beast(
	_stct_event,
	_stct_record
){

	if (
		!is_struct(_stct_event) ||
		!is_struct(_stct_record) ||
		_stct_record._flag_resolved ||
		!is_struct(_stct_record._stct_payload) ||
		!variable_struct_exists(
			_stct_record._stct_payload,
			"_stct_unit"
		) ||
		!is_struct(
			_stct_record._stct_payload._stct_unit
		)
	){
		return noone;
	}

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
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

	var _stct_unit =
		_stct_record
			._stct_payload
			._stct_unit;

	var _ref_beast =
		instance_create_layer(
			_stct_record._val_x,
			_stct_record._val_y,
			"ily_npcs",
			obj_overworld_beast
		);

	if (!instance_exists(_ref_beast)){
		return noone;
	}

	_ref_beast._str_team = "WILD";
	_ref_beast._stct_unit = _stct_unit;

	_ref_beast._spr_beast =
		_stct_unit._spr_beast;

	_ref_beast._spr_shadow =
		scr_beast_get_type_shadow(
			_stct_unit._str_beast_color_type
		);

	_ref_beast._str_disposition = "SCARED";

	_ref_beast._val_home_x =
		_ref_spawn.x;

	_ref_beast._val_home_y =
		_ref_spawn.y;

	_ref_beast._val_home_radius =
		max(
			_ref_spawn._val_spawn_radius,
			_ref_spawn._val_mob_leash_radius
		);

	_ref_beast._val_detect_radius =
		_ref_controller
			._val_runaway_treasure_detect_radius;

	_ref_beast._val_move_speed = 1.15;

	_ref_beast._val_runaway_treasure_flee_speed =
		_ref_controller
			._val_runaway_treasure_flee_speed;

	_ref_beast._val_target_x =
		_stct_record._val_x;

	_ref_beast._val_target_y =
		_stct_record._val_y;

	_ref_beast._ct_battle_cooldown = 999999;
	_ref_beast._flag_battle_triggered = false;

	_ref_beast._arr_exact_enemy_roster = [];
	_ref_beast._stct_world_event_battle_context = undefined;

	_ref_beast._flag_world_event_instance = true;
	_ref_beast._uid_world_event = _stct_event._uid_world_event;
	_ref_beast._uid_world_event_entity =
		_stct_record._uid_world_event_entity;
	_ref_beast._uid_world_event_pod = -1;

	_ref_beast._str_world_event_id =
		"RUNAWAY_TREASURE_BEAST";

	_ref_beast._str_world_event_spawn_id =
		_stct_record._str_spawn_id;

	_ref_beast._flag_runaway_treasure_beast = true;

	return _ref_beast;
}
