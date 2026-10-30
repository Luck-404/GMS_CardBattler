//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_MIGRATION_GENERATE
// FUNCTION: Generates persistent Migration data. Normal events use the room pool; Cheats may provide _str_debug_forced_species in the event payload.
//
//===============================================================================//

function scr_world_event_migration_generate(){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	var _stct_world_event =
		_ref_controller
			._stct_active_world_event;

	if (
		!is_struct(
			_stct_world_event
		) ||
		_stct_world_event._str_event_id !=
			"MIGRATION" ||
		_stct_world_event._state_world_event !=
			ENUM_WORLD_EVENT_STATE.ACTIVE ||
		room !=
			_stct_world_event._rm_target
	){
		return false;
	}

	if (!is_struct(_stct_world_event._stct_payload)){
		_stct_world_event._stct_payload = {};
	}

	var _stct_payload =
		_stct_world_event
			._stct_payload;

	if (
		variable_struct_exists(
			_stct_payload,
			"_flag_migration_generated"
		) &&
		_stct_payload._flag_migration_generated
	){
		return true;
	}

	//================//
	//VALIDATE ANCHORS//
	//================//
	scr_world_event_validate_spawn_points(
		room
	);

	var _arr_spawn_points =
		scr_world_event_get_spawn_points(
			room,
			"MOB",
			_ref_controller
				._ct_migration_pod_size_min
		);

	if (
		array_length(
			_arr_spawn_points
		) <
		2
	){

		_stct_payload._str_migration_error =
			"NOT ENOUGH MOB SPAWN POINTS";

		return false;
	}

	//================//
	//ROOM SPECIES POOL//
	//================//
	var _arr_room_pool =
		scr_world_event_migration_get_room_pool(
			room
		);

	if (
		array_length(
			_arr_room_pool
		) <=
		0
	){

		_stct_payload._str_migration_error =
			"NO VALID ROOM ENCOUNTER POOL";

		return false;
	}

	var _str_species = "";

	if (
		variable_struct_exists(
			_stct_payload,
			"_str_debug_forced_species"
		) &&
		string(_stct_payload._str_debug_forced_species) != ""
	){
		_str_species = string(_stct_payload._str_debug_forced_species);
	}
	else{
		_str_species =
			_arr_room_pool[
				irandom(
					array_length(_arr_room_pool) - 1
				)
			];
	}

	//================//
	//POPULATION / POD PLAN//
	//================//
	var _ct_population_requested =
		irandom_range(
			_ref_controller
				._ct_migration_population_min,
			_ref_controller
				._ct_migration_population_max
		);

	var _stct_plan =
		scr_world_event_migration_build_pod_plan(
			_ct_population_requested,
			_arr_spawn_points,
			_ref_controller
				._ct_migration_population_min,
			_ref_controller
				._ct_migration_pod_size_min,
			_ref_controller
				._ct_migration_pod_size_max
		);

	if (
		!is_struct(
			_stct_plan
		) ||
		!_stct_plan._flag_valid
	){

		_stct_payload._str_migration_error =
			"ROOM MOB ANCHORS CANNOT SUPPORT MIGRATION";

		return false;
	}

	//================//
	//LEVEL SCALING//
	//================//
	var _stct_scaling =
		scr_overworld_roll_encounter_scaling(
			room
		);

	if (!is_struct(_stct_scaling)){

		_stct_payload._str_migration_error =
			"ENCOUNTER SCALING FAILED";

		return false;
	}

	var _ct_population =
		_stct_plan
			._ct_population;

	var _it_leader_global =
		irandom(
			_ct_population -
			1
		);

	var _uid_leader_beast = -1;

	// Build everything locally first. If any Beast initialization fails, the active
	// event is not left with a partially committed Migration.
	var _arr_pods = [];
	var _arr_records = [];
	var _arr_spawn_ids = [];

	var _it_global_member = 0;

	for (
		var _it_pod = 0;
		_it_pod <
			array_length(
				_stct_plan._arr_pods
			);
		_it_pod++
	){

		var _stct_pod_plan =
			_stct_plan
				._arr_pods[
					_it_pod
				];

		var _ref_spawn =
			_stct_pod_plan
				._ref_spawn_point;

		if (!instance_exists(_ref_spawn)){
			return false;
		}

		var _uid_pod =
			scr_world_event_allocate_entity_uid();

		var _str_spawn_id =
			_ref_spawn
				._str_spawn_id;

		var _ct_pod_size =
			_stct_pod_plan
				._ct_pod_size;

		var _arr_member_units = [];
		var _arr_member_entity_uids = [];

		var _val_angle_offset =
			irandom_range(
				0,
				359
			);

		var _val_member_radius =
			min(
				48,
				max(
					0,
					_ref_spawn
						._val_spawn_radius *
					0.55
				)
			);

		for (
			var _it_member = 0;
			_it_member < _ct_pod_size;
			_it_member++
		){

			var _stct_unit =
				scr_beast_init_random(
					_str_species
				);

			if (!is_struct(_stct_unit)){
				return false;
			}

			var _val_level =
				scr_encounter_roll_enemy_level(
					_stct_scaling
				);

			if (
				_val_level == undefined ||
				!is_real(_val_level)
			){
				_val_level =
					round(
						(
							_stct_scaling
								._val_zone_level_min +
							_stct_scaling
								._val_zone_level_max
						) *
						0.5
					);
			}

			var _flag_leader =
				_it_global_member ==
				_it_leader_global;

			if (_flag_leader){

				_val_level +=
					irandom_range(
						_ref_controller
							._val_migration_leader_level_bonus_min,
						_ref_controller
							._val_migration_leader_level_bonus_max
					);
			}

			if (
				!scr_beast_set_level(
					_stct_unit,
					_val_level,
					true
				)
			){
				return false;
			}

			// Migration Leaders are intentionally NOT Elites.
			_stct_unit._flag_elite = false;
			_stct_unit._str_elite_modifier = "";
			_stct_unit._val_elite_risk_tier = 0;
			_stct_unit._flag_elite_stats_applied = false;
			_stct_unit._arr_elite_card_ids = [];
			_stct_unit._str_elite_primary_card_id = "";

			if (_flag_leader){
				_uid_leader_beast =
					_stct_unit
						._uid_beast;
			}

			var _uid_entity =
				scr_world_event_allocate_entity_uid();

			var _val_angle =
				_val_angle_offset +
				(
					360 /
					_ct_pod_size
				) *
				_it_member;

			var _val_member_x =
				_ref_spawn.x +
				lengthdir_x(
					_val_member_radius,
					_val_angle
				);

			var _val_member_y =
				_ref_spawn.y +
				lengthdir_y(
					_val_member_radius,
					_val_angle
				);

			var _stct_record =
				scr_world_event_entity_record_create(
					_stct_world_event
						._uid_world_event,
					_uid_entity,
					"MIGRATION_MEMBER",
					_str_spawn_id,
					room,
					_val_member_x,
					_val_member_y,
					{
						_uid_migration_pod :
							_uid_pod,

						_uid_beast :
							_stct_unit
								._uid_beast,

						_flag_migration_leader :
							_flag_leader
					}
				);

			array_push(
				_arr_records,
				_stct_record
			);

			array_push(
				_arr_member_units,
				_stct_unit
			);

			array_push(
				_arr_member_entity_uids,
				_uid_entity
			);

			_it_global_member++;
		}

		array_push(
			_arr_pods,
			{
				_uid_pod :
					_uid_pod,

				_str_spawn_id :
					_str_spawn_id,

				_ct_member_total :
					_ct_pod_size,

				_arr_member_units :
					_arr_member_units,

				_arr_member_entity_uids :
					_arr_member_entity_uids,

				_flag_resolved :
					false,

				_str_state :
					"UNRESOLVED"
			}
		);

		array_push(
			_arr_spawn_ids,
			_str_spawn_id
		);
	}

	//================//
	//COMMIT MIGRATION//
	//================//
	_stct_world_event._arr_entity_records =
		_arr_records;

	_stct_world_event._arr_selected_spawn_ids =
		_arr_spawn_ids;

	_stct_world_event._ct_progress = 0;
	_stct_world_event._ct_goal =
		array_length(
			_arr_pods
		);

	_stct_payload._flag_migration_generated = true;
	_stct_payload._str_migration_error = "";

	_stct_payload._str_migration_species =
		_str_species;

	_stct_payload._ct_migration_population_total =
		_ct_population;

	_stct_payload._ct_migration_population_remaining =
		_ct_population;

	_stct_payload._uid_migration_leader_beast =
		_uid_leader_beast;

	_stct_payload._arr_migration_pods =
		_arr_pods;

	_stct_payload._ct_migration_pods_total =
		array_length(
			_arr_pods
		);

	_stct_payload._ct_migration_pods_remaining =
		array_length(
			_arr_pods
		);

	_stct_payload._stct_migration_scaling =
		_stct_scaling;

	_stct_payload._ct_last_spawn_room_revision =
		-1;

	_stct_world_event._flag_room_initialized =
		false;

	scr_debug_log(
		"WORLD_EVENT",
		"MIGRATION",
		_ref_controller,
		"MIGRATION GENERATED" +
		" | EVENT UID: " +
		string(
			_stct_world_event
				._uid_world_event
		) +
		" | ROOM: " +
		_stct_world_event
			._str_target_room_name +
		" | SPECIES: " +
		_str_species +
		" | POPULATION: " +
		string(
			_ct_population
		) +
		" | PODS: " +
		string(
			array_length(
				_arr_pods
			)
		) +
		" | LEADER BEAST UID: " +
		string(
			_uid_leader_beast
		),
		"INFO",
		"SCR_WORLD_EVENT_MIGRATION_GENERATE"
	);

	return true;
}
