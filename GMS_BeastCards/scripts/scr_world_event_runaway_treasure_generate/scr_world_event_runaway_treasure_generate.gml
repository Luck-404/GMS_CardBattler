//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_RUNAWAY_TREASURE_GENERATE
// FUNCTION: Generates the persistent Runaway Treasure Beast. Normal events use the room pool; Cheats may provide _str_debug_forced_species.
//
//===============================================================================//

function scr_world_event_runaway_treasure_generate(){

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
			"RUNAWAY_TREASURE_BEAST" ||
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
			"_flag_runaway_treasure_generated"
		) &&
		_stct_payload._flag_runaway_treasure_generated
	){
		return true;
	}

	scr_world_event_validate_spawn_points(
		room
	);

	var _arr_spawn_points =
		scr_world_event_select_spawn_points(
			room,
			"MOB",
			1,
			1
		);

	if (array_length(_arr_spawn_points) <= 0){

		_stct_payload._str_runaway_treasure_error =
			"NO VALID MOB SPAWN POINT";

		return false;
	}

	var _ref_spawn =
		_arr_spawn_points[0];

	if (!instance_exists(_ref_spawn)){
		return false;
	}

	var _arr_room_pool =
		scr_world_event_runaway_treasure_get_room_pool(
			room
		);

	if (array_length(_arr_room_pool) <= 0){

		_stct_payload._str_runaway_treasure_error =
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
				irandom(array_length(_arr_room_pool) - 1)
			];
	}

	var _stct_unit =
		scr_beast_init_random(
			_str_species
		);

	if (!is_struct(_stct_unit)){
		return false;
	}

	// This event Beast is a normal Beast, never an Elite.
	_stct_unit._flag_elite = false;
	_stct_unit._str_elite_modifier = "";
	_stct_unit._val_elite_risk_tier = 0;
	_stct_unit._flag_elite_stats_applied = false;
	_stct_unit._arr_elite_card_ids = [];
	_stct_unit._str_elite_primary_card_id = "";

	var _stct_scaling =
		scr_overworld_roll_encounter_scaling(
			room
		);

	if (is_struct(_stct_scaling)){

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

		scr_beast_set_level(
			_stct_unit,
			_val_level,
			true
		);
	}

	var _val_spawn_radius =
		min(
			48,
			max(
				0,
				_ref_spawn._val_spawn_radius *
				0.35
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
			"RUNAWAY_TREASURE_BEAST",
			_ref_spawn._str_spawn_id,
			room,
			_val_x,
			_val_y,
			{
				_stct_unit : _stct_unit
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

	_stct_payload._flag_runaway_treasure_generated = true;
	_stct_payload._flag_runaway_treasure_caught = false;
	_stct_payload._flag_runaway_treasure_drops_generated = false;

	_stct_payload._uid_runaway_treasure_beast =
		_uid_entity;

	_stct_payload._str_runaway_treasure_species =
		_str_species;

	_stct_payload._str_runaway_treasure_spawn_id =
		_ref_spawn._str_spawn_id;

	_stct_payload._stct_runaway_treasure_scaling =
		_stct_scaling;

	_stct_payload._ct_runaway_treasure_sparkles_total = 0;
	_stct_payload._ct_runaway_treasure_sparkles_remaining = 0;

	scr_debug_log(
		"WORLD_EVENT",
		"RUNAWAY_TREASURE",
		_ref_controller,
		"RUNAWAY TREASURE BEAST GENERATED" +
		" | EVENT UID: " +
		string(_stct_event._uid_world_event) +
		" | ENTITY UID: " +
		string(_uid_entity) +
		" | SPECIES: " +
		_str_species +
		" | SPAWN: " +
		_ref_spawn._str_spawn_id,
		"INFO",
		"SCR_WORLD_EVENT_RUNAWAY_TREASURE_GENERATE"
	);

	return true;
}
