//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_RUNAWAY_TREASURE_SPAWN_DROPS
// FUNCTION: Creates exactly eight persistent sparkle drops around the caught
//           Runaway Treasure Beast: E, SE, S, SW, W, NW, N, NE.
//
//           Drop positions contract inward when needed so they are not placed
//           inside OBJ_OVERWORLD_WALL.
//
// ARGUMENTS: _stct_event - Active Runaway Treasure Beast event.
//            _stct_beast_record - Caught Beast entity record.
//            _val_x / _val_y - Catch position.
// RETURNS: True when the persistent sparkle burst exists.
//
//===============================================================================//

function scr_world_event_runaway_treasure_spawn_drops(
	_stct_event,
	_stct_beast_record,
	_val_x,
	_val_y
){

	if (
		!is_struct(_stct_event) ||
		!is_struct(_stct_beast_record) ||
		!is_struct(_stct_event._stct_payload)
	){
		return false;
	}

	var _stct_payload =
		_stct_event._stct_payload;

	if (
		variable_struct_exists(
			_stct_payload,
			"_flag_runaway_treasure_drops_generated"
		) &&
		_stct_payload._flag_runaway_treasure_drops_generated
	){
		return true;
	}

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	var _ct_sparkles = 8;
	var _arr_new_records = [];

	for (
		var _it_sparkle = 0;
		_it_sparkle < _ct_sparkles;
		_it_sparkle++
	){
		var _val_angle =
			_it_sparkle * 45;

		var _val_radius = 72;
		var _val_drop_x = _val_x;
		var _val_drop_y = _val_y;
		var _flag_valid_drop = false;

		while (_val_radius >= 24){
			_val_drop_x =
				clamp(
					_val_x +
					lengthdir_x(
						_val_radius,
						_val_angle
					),
					24,
					room_width - 24
				);

			_val_drop_y =
				clamp(
					_val_y +
					lengthdir_y(
						_val_radius,
						_val_angle
					),
					24,
					room_height - 24
				);

			if (
				!object_exists(obj_overworld_wall) ||
				collision_point(
					_val_drop_x,
					_val_drop_y,
					obj_overworld_wall,
					false,
					true
				) == noone
			){
				_flag_valid_drop = true;
				break;
			}

			_val_radius -= 8;
		}

		if (!_flag_valid_drop){
			_val_drop_x = _val_x;
			_val_drop_y = _val_y;
		}

		var _val_rarity_roll =
			irandom_range(1,10);

		var _str_rarity = "I";

		if (_val_rarity_roll >= 10){
			_str_rarity = "III";
		}
		else if (_val_rarity_roll >= 7){
			_str_rarity = "II";
		}

		var _uid_sparkle =
			scr_world_event_allocate_entity_uid();

		var _stct_record =
			scr_world_event_entity_record_create(
				_stct_event._uid_world_event,
				_uid_sparkle,
				"RUNAWAY_TREASURE_SPARKLE",
				_stct_beast_record._str_spawn_id,
				room,
				_val_drop_x,
				_val_drop_y,
				{
					_str_rarity : _str_rarity,
					_val_drop_angle : _val_angle
				}
			);

		array_push(
			_arr_new_records,
			_stct_record
		);
	}

	for (
		var _it_record = 0;
		_it_record < array_length(_arr_new_records);
		_it_record++
	){
		if (
			!scr_world_event_entity_record_add(
				_stct_event,
				_arr_new_records[_it_record]
			)
		){
			return false;
		}
	}

	_stct_payload._flag_runaway_treasure_drops_generated = true;
	_stct_payload._ct_runaway_treasure_sparkles_total = _ct_sparkles;
	_stct_payload._ct_runaway_treasure_sparkles_remaining = _ct_sparkles;

	for (
		var _it_spawn = 0;
		_it_spawn < array_length(_arr_new_records);
		_it_spawn++
	){
		scr_world_event_runaway_treasure_spawn_sparkle(
			_stct_event,
			_arr_new_records[_it_spawn]
		);
	}

	scr_debug_log(
		"WORLD_EVENT",
		"RUNAWAY_TREASURE",
		_ref_controller,
		"TREASURE BEAST EIGHT-DIRECTION SPARKLE BURST CREATED" +
		" | EVENT UID: " +
		string(_stct_event._uid_world_event) +
		" | SPARKLES: 8" +
		" | POSITION: (" +
		string(round(_val_x)) +
		"," +
		string(round(_val_y)) +
		")",
		"REWARD",
		"SCR_WORLD_EVENT_RUNAWAY_TREASURE_SPAWN_DROPS"
	);

	return true;
}
