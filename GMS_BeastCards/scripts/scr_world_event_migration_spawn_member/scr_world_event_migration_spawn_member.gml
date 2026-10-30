//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_MIGRATION_SPAWN_MEMBER
// FUNCTION: Reconstructs one unresolved Migration member as OBJ_OVERWORLD_BEAST
//           and attaches the pod's exact roster + Phase III battle context.
//
// ARGUMENTS: _stct_world_event - Active Migration event.
//            _stct_pod - Owning persistent pod.
//            _it_member - Member index within aligned pod arrays.
//            _arr_exact_roster - Current unresolved exact pod roster.
// RETURNS: Spawned overworld Beast instance or noone.
//
//===============================================================================//

function scr_world_event_migration_spawn_member(
	_stct_world_event,
	_stct_pod,
	_it_member,
	_arr_exact_roster
){

	if (
		!is_struct(
			_stct_world_event
		) ||
		!is_struct(
			_stct_pod
		) ||
		!is_array(
			_arr_exact_roster
		) ||
		array_length(
			_arr_exact_roster
		) <=
		0
	){
		return noone;
	}

	if (
		_it_member < 0 ||
		_it_member >=
			array_length(
				_stct_pod
					._arr_member_units
			) ||
		_it_member >=
			array_length(
				_stct_pod
					._arr_member_entity_uids
			)
	){
		return noone;
	}

	var _stct_unit =
		_stct_pod
			._arr_member_units[
				_it_member
			];

	var _uid_entity =
		_stct_pod
			._arr_member_entity_uids[
				_it_member
			];

	var _stct_record =
		scr_world_event_entity_record_get(
			_stct_world_event,
			_uid_entity
		);

	if (
		!is_struct(
			_stct_unit
		) ||
		!is_struct(
			_stct_record
		) ||
		_stct_record._flag_resolved
	){
		return noone;
	}

	var _ref_spawn =
		scr_world_event_get_spawn_point_by_id(
			_stct_pod
				._str_spawn_id,
			room
		);

	if (!instance_exists(_ref_spawn)){
		return noone;
	}

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

	//================//
	//BASE BEAST STATE//
	//================//
	_ref_beast._str_team = "WILD";
	_ref_beast._stct_unit = _stct_unit;

	_ref_beast._spr_beast =
		_stct_unit
			._spr_beast;

	_ref_beast._spr_shadow =
		scr_beast_get_type_shadow(
			_stct_unit
				._str_beast_color_type
		);

	// Migration pods stay near their authored MOB anchor and do not inherit
	// normal encounter-zone chase/flee behavior.
	_ref_beast._str_disposition = "CHILL";

	_ref_beast._val_home_x =
		_ref_spawn.x;

	_ref_beast._val_home_y =
		_ref_spawn.y;

	_ref_beast._val_home_radius =
		max(
			_ref_spawn
				._val_spawn_radius,
			_ref_spawn
				._val_mob_leash_radius
		);

	_ref_beast._val_target_x =
		_stct_record._val_x;

	_ref_beast._val_target_y =
		_stct_record._val_y;

	_ref_beast._ct_battle_cooldown = 30;

	//================//
	//EVENT OWNERSHIP//
	//================//
	_ref_beast._flag_world_event_instance = true;

	_ref_beast._uid_world_event =
		_stct_world_event
			._uid_world_event;

	_ref_beast._uid_world_event_entity =
		_uid_entity;

	_ref_beast._uid_world_event_pod =
		_stct_pod
			._uid_pod;

	_ref_beast._str_world_event_id =
		"MIGRATION";

	_ref_beast._str_world_event_spawn_id =
		_stct_pod
			._str_spawn_id;

	_ref_beast._flag_migration_leader =
		is_struct(
			_stct_record
				._stct_payload
		) &&
		variable_struct_exists(
			_stct_record
				._stct_payload,
			"_flag_migration_leader"
		) &&
		_stct_record
			._stct_payload
			._flag_migration_leader;

	//================//
	//NORMAL LOOT METADATA//
	//================//
	var _ref_zone =
		scr_world_event_migration_get_nearest_zone(
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
				_ref_zone
					._arr_encounter_beasts
			)
		){
			_ref_beast._arr_encounter_pool =
				_ref_zone
					._arr_encounter_beasts;
		}

		if (
			variable_instance_exists(
				_ref_zone,
				"_str_loot_zone_id"
			) &&
			is_string(
				_ref_zone
					._str_loot_zone_id
			)
		){
			_ref_beast._str_loot_zone_id =
				string_upper(
					_ref_zone
						._str_loot_zone_id
				);
		}
	}

	//================//
	//EXACT POD BATTLE//
	//================//
	var _stct_context =
		scr_world_event_create_battle_context(
			_stct_world_event
				._uid_world_event,
			"MIGRATION",
			_uid_entity,
			_stct_pod
				._uid_pod,
			"MIGRATION_POD",
			true
		);

	if (
		!scr_overworld_assign_exact_enemy_roster(
			_ref_beast,
			_arr_exact_roster,
			_stct_context
		)
	){

		instance_destroy(
			_ref_beast
		);

		return noone;
	}

	return _ref_beast;
}
