//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_RUNAWAY_TREASURE_SPAWN_SPARKLE
// FUNCTION: Reconstructs one unresolved one-shot treasure sparkle dropped by the
//           caught Runaway Treasure Beast.
//
//===============================================================================//

function scr_world_event_runaway_treasure_spawn_sparkle(
	_stct_event,
	_stct_record
){

	if (
		!is_struct(_stct_event) ||
		!is_struct(_stct_record) ||
		_stct_record._flag_resolved
	){
		return noone;
	}

	var _ref_sparkle =
		instance_create_layer(
			_stct_record._val_x,
			_stct_record._val_y,
			"ily_npcs",
			obj_overworld_treasure_sparkle
		);

	if (!instance_exists(_ref_sparkle)){
		return noone;
	}

	// CREATE rolls normal roaming sparkle state. Event reconstruction immediately
	// overrides those transient values with its persistent one-shot data.
	_ref_sparkle.x = _stct_record._val_x;
	_ref_sparkle.y = _stct_record._val_y;

	_ref_sparkle.visible = true;
	_ref_sparkle._flag_triggered = false;

	_ref_sparkle._flag_world_event_instance = true;
	_ref_sparkle._flag_world_event_one_shot = true;

	_ref_sparkle._uid_world_event =
		_stct_event._uid_world_event;

	_ref_sparkle._uid_world_event_entity =
		_stct_record._uid_world_event_entity;

	_ref_sparkle._str_world_event_id =
		"RUNAWAY_TREASURE_BEAST";

	_ref_sparkle._str_world_event_spawn_id =
		_stct_record._str_spawn_id;

	var _str_rarity = "I";

	if (
		is_struct(_stct_record._stct_payload) &&
		variable_struct_exists(
			_stct_record._stct_payload,
			"_str_rarity"
		)
	){
		_str_rarity =
			string_upper(
				string(
					_stct_record._stct_payload._str_rarity
				)
			);
	}

	_ref_sparkle._str_rarity =
		_str_rarity;

	switch (_str_rarity){

		case "III":
			_ref_sparkle._c_sparkle = c_aqua;
		break;

		case "II":
			_ref_sparkle._c_sparkle = c_lime;
		break;

		case "I":
		default:
			_ref_sparkle._c_sparkle = c_white;
		break;
	}

	return _ref_sparkle;
}
