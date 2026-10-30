//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_ELITE_SIGHTING_SPAWN_BEAST
// FUNCTION: Reconstructs the visible Tier 2 Elite Sighting Beast and attaches the
//           persistent exact encounter roster plus World Event battle context.
//
// RETURNS: Spawned overworld Beast instance or noone.
//
//===============================================================================//

function scr_world_event_elite_sighting_spawn_beast(
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
		) ||
		!variable_struct_exists(
			_stct_record._stct_payload,
			"_arr_enemy_units"
		) ||
		!is_array(
			_stct_record._stct_payload._arr_enemy_units
		) ||
		!scr_battle_validate_exact_enemy_roster(
			_stct_record._stct_payload._arr_enemy_units
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

	var _stct_unit =
		_stct_record
			._stct_payload
			._stct_unit;

	var _arr_roster =
		_stct_record
			._stct_payload
			._arr_enemy_units;

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

	_ref_beast._str_disposition = "ANGRY";

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
		min(
			160,
			max(
				96,
				_ref_beast._val_home_radius
			)
		);

	_ref_beast._val_move_speed = 1.0;
	_ref_beast._val_target_x = _stct_record._val_x;
	_ref_beast._val_target_y = _stct_record._val_y;
	_ref_beast._ct_battle_cooldown = 30;
	_ref_beast._flag_battle_triggered = false;

	_ref_beast._flag_world_event_instance = true;
	_ref_beast._uid_world_event = _stct_event._uid_world_event;
	_ref_beast._uid_world_event_entity = _stct_record._uid_world_event_entity;
	_ref_beast._uid_world_event_pod = -1;
	_ref_beast._str_world_event_id = "ELITE_SIGHTING";
	_ref_beast._str_world_event_spawn_id = _stct_record._str_spawn_id;
	_ref_beast._flag_elite_sighting_target = true;

	var _ref_zone =
		scr_world_event_elite_sighting_get_nearest_zone(
			_ref_spawn.x,
			_ref_spawn.y
		);

	if (instance_exists(_ref_zone)){

		if (
			variable_instance_exists(
				_ref_zone,
				"_arr_encounter_beasts"
			) &&
			is_array(
				_ref_zone._arr_encounter_beasts
			)
		){
			_ref_beast._arr_encounter_pool =
				_ref_zone._arr_encounter_beasts;
		}

		if (
			variable_instance_exists(
				_ref_zone,
				"_str_loot_zone_id"
			) &&
			is_string(
				_ref_zone._str_loot_zone_id
			)
		){
			_ref_beast._str_loot_zone_id =
				string_upper(
					_ref_zone._str_loot_zone_id
				);
		}
	}

	var _stct_context =
		scr_world_event_create_battle_context(
			_stct_event._uid_world_event,
			"ELITE_SIGHTING",
			_stct_record._uid_world_event_entity,
			-1,
			"ELITE_SIGHTING",
			true
		);

	if (
		!scr_overworld_assign_exact_enemy_roster(
			_ref_beast,
			_arr_roster,
			_stct_context
		)
	){
		instance_destroy(_ref_beast);
		return noone;
	}

	return _ref_beast;
}
