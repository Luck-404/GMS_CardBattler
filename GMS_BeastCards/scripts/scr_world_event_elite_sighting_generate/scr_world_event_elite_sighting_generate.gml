//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_ELITE_SIGHTING_GENERATE
// FUNCTION: Generates one persistent Tier 2 Elite Sighting. Cheats may force the lead Elite species while ordinary allies remain room-valid random species.
//
//===============================================================================//

function scr_world_event_elite_sighting_generate(){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	var _stct_event =
		_ref_controller
			._stct_active_world_event;

	if (
		!is_struct(_stct_event) ||
		_stct_event._str_event_id !=
			"ELITE_SIGHTING" ||
		_stct_event._state_world_event !=
			ENUM_WORLD_EVENT_STATE.ACTIVE ||
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
			"_flag_elite_sighting_generated"
		) &&
		_stct_payload._flag_elite_sighting_generated
	){
		return true;
	}

	scr_world_event_validate_spawn_points(
		room
	);

	var _arr_spawn_points =
		scr_world_event_select_spawn_points(
			room,
			"ELITE",
			1,
			1
		);

	if (array_length(_arr_spawn_points) <= 0){

		_stct_payload._str_elite_sighting_error =
			"NO VALID ELITE SPAWN POINT";

		return false;
	}

	var _ref_spawn =
		_arr_spawn_points[0];

	if (!instance_exists(_ref_spawn)){
		return false;
	}

	var _arr_room_pool =
		scr_world_event_elite_sighting_get_room_pool(
			room
		);

	if (array_length(_arr_room_pool) <= 0){

		_stct_payload._str_elite_sighting_error =
			"NO VALID ROOM ENCOUNTER POOL";

		return false;
	}

	var _stct_scaling =
		scr_overworld_roll_encounter_scaling(
			room
		);

	if (!is_struct(_stct_scaling)){
		return false;
	}

	var _ct_roster_size =
		clamp(
			floor(
				_ref_controller
					._ct_elite_sighting_roster_size
			),
			1,
			5
		);

	var _val_risk_tier =
		max(
			2,
			floor(
				_ref_controller
					._ct_elite_sighting_risk_tier
			)
		);

	var _arr_roster = [];
	var _stct_elite_unit = undefined;
	var _str_elite_modifier = "";

	var _str_debug_forced_species = "";

	if (
		variable_struct_exists(
			_stct_payload,
			"_str_debug_forced_species"
		)
	){
		_str_debug_forced_species =
			string(_stct_payload._str_debug_forced_species);
	}

	for (
		var _it_roster = 0;
		_it_roster < _ct_roster_size;
		_it_roster++
	){

		var _str_species =
			(
				_it_roster == 0 &&
				_str_debug_forced_species != ""
			)
			? _str_debug_forced_species
			: _arr_room_pool[
				irandom(array_length(_arr_room_pool) - 1)
			];

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
						_stct_scaling._val_zone_level_min +
						_stct_scaling._val_zone_level_max
					) *
					0.5
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

		// Preserve the exact clean event baseline so a failed battle attempt can
		// reconstruct without carrying permanent battle-only stat mutations forward.
		_stct_unit._stct_elite_sighting_base_stats = {
			_val_beast_hp_stat : _stct_unit._val_beast_hp_stat,
			_val_beast_con_stat : _stct_unit._val_beast_con_stat,
			_val_beast_ppow_stat : _stct_unit._val_beast_ppow_stat,
			_val_beast_mpow_stat : _stct_unit._val_beast_mpow_stat,
			_val_beast_pdef_stat : _stct_unit._val_beast_pdef_stat,
			_val_beast_mdef_stat : _stct_unit._val_beast_mdef_stat,
			_val_beast_speed_stat : _stct_unit._val_beast_speed_stat,
			_val_beast_crit_stat : _stct_unit._val_beast_crit_stat,
			_val_beast_hp_max : _stct_unit._val_beast_hp_max
		};

		if (_it_roster == 0){

			_str_elite_modifier =
				scr_battle_elite_roll_modifier();

			if (
				scr_battle_elite_get_info(
					_str_elite_modifier
				) ==
				undefined
			){
				return false;
			}

			_stct_unit._val_elite_risk_tier =
				_val_risk_tier;

			_stct_unit._val_elite_chance_percent =
				100;

			_stct_unit._val_elite_roll =
				1;

			_stct_unit._str_elite_source_item_id =
				"WORLD_EVENT";

			if (
				!scr_battle_elite_apply(
					_stct_unit,
					_str_elite_modifier
				)
			){
				return false;
			}

			_stct_elite_unit =
				_stct_unit;
		}
		else{

			_stct_unit._flag_elite = false;
			_stct_unit._str_elite_modifier = "";
			_stct_unit._val_elite_risk_tier = 0;
			_stct_unit._flag_elite_stats_applied = false;
			_stct_unit._arr_elite_card_ids = [];
			_stct_unit._str_elite_primary_card_id = "";
		}

		array_push(
			_arr_roster,
			_stct_unit
		);
	}

	if (
		!is_struct(_stct_elite_unit) ||
		!scr_battle_validate_exact_enemy_roster(
			_arr_roster
		)
	){
		return false;
	}

	var _val_spawn_radius =
		min(
			32,
			max(
				0,
				_ref_spawn._val_spawn_radius *
					0.25
			)
		);

	var _val_angle =
		irandom_range(
			0,
			359
		);

	var _val_x =
		clamp(
			_ref_spawn.x +
				lengthdir_x(
					_val_spawn_radius,
					_val_angle
				),
			16,
			room_width - 16
		);

	var _val_y =
		clamp(
			_ref_spawn.y +
				lengthdir_y(
					_val_spawn_radius,
					_val_angle
				),
			16,
			room_height - 16
		);

	var _uid_entity =
		scr_world_event_allocate_entity_uid();

	var _stct_record =
		scr_world_event_entity_record_create(
			_stct_event._uid_world_event,
			_uid_entity,
			"ELITE_SIGHTING",
			_ref_spawn._str_spawn_id,
			room,
			_val_x,
			_val_y,
			{
				_stct_unit : _stct_elite_unit,
				_arr_enemy_units : _arr_roster
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

	_stct_event._arr_selected_spawn_ids = [
		_ref_spawn._str_spawn_id
	];

	_stct_event._ct_goal = 1;
	_stct_event._ct_progress = 0;

	_stct_payload._flag_elite_sighting_generated = true;
	_stct_payload._flag_elite_sighting_defeated = false;
	_stct_payload._uid_elite_sighting_entity = _uid_entity;
	_stct_payload._uid_elite_sighting_beast = _stct_elite_unit._uid_beast;
	_stct_payload._str_elite_sighting_species = _stct_elite_unit._str_beast_name;
	_stct_payload._str_elite_sighting_modifier = _str_elite_modifier;
	_stct_payload._val_elite_sighting_risk_tier = _val_risk_tier;
	_stct_payload._str_elite_sighting_spawn_id = _ref_spawn._str_spawn_id;
	_stct_payload._arr_elite_sighting_roster = _arr_roster;
	_stct_payload._stct_elite_sighting_scaling = _stct_scaling;

	scr_debug_log(
		"WORLD_EVENT",
		"ELITE_SIGHTING",
		_ref_controller,
		"ELITE SIGHTING GENERATED" +
		" | EVENT UID: " +
		string(_stct_event._uid_world_event) +
		" | ENTITY UID: " +
		string(_uid_entity) +
		" | BEAST: " +
		string_upper(_stct_elite_unit._str_beast_name) +
		" | MODIFIER: " +
		_str_elite_modifier +
		" | RISK TIER: " +
		string(_val_risk_tier) +
		" | ROSTER: " +
		string(array_length(_arr_roster)) +
		" | SPAWN: " +
		_ref_spawn._str_spawn_id,
		"INFO",
		"SCR_WORLD_EVENT_ELITE_SIGHTING_GENERATE"
	);

	return true;
}
