//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_GILDED_GAMBIT_GENERATE
// FUNCTION: Generates five persistent cosmetic chest records around one TREASURE
//           World Event anchor. Tint and size are cosmetic only and never encode
//           reward quality.
//
// RETURNS: True when Gilded Gambit state exists.
//
//===============================================================================//

function scr_world_event_gilded_gambit_generate(){

	var _ref_controller = scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	var _stct_event = _ref_controller._stct_active_world_event;

	if (
		!is_struct(_stct_event) ||
		_stct_event._state_world_event != ENUM_WORLD_EVENT_STATE.ACTIVE ||
		_stct_event._str_event_id != "CHOOSE_A_CHEST" ||
		room != _stct_event._rm_target
	){
		return false;
	}

	if (!is_struct(_stct_event._stct_payload)){
		_stct_event._stct_payload = {};
	}

	var _stct_payload = _stct_event._stct_payload;

	if (
		variable_struct_exists(_stct_payload,"_flag_gilded_gambit_generated") &&
		_stct_payload._flag_gilded_gambit_generated
	){
		return true;
	}

	var _arr_points =
		scr_world_event_select_spawn_points(
			room,
			"TREASURE",
			1,
			5
		);

	if (!is_array(_arr_points) || array_length(_arr_points) <= 0){
		return false;
	}

	var _ref_anchor = _arr_points[0];

	if (!instance_exists(_ref_anchor)){
		return false;
	}

	var _val_radius =
		clamp(
			_ref_anchor._val_spawn_radius * 0.65,
			56,
			80
		);

	var _list_tints = ds_list_create();
	ds_list_add(
		_list_tints,
		make_colour_rgb(255,235,225),
		make_colour_rgb(225,245,255),
		make_colour_rgb(240,230,255),
		make_colour_rgb(230,255,235),
		make_colour_rgb(255,245,210)
	);
	ds_list_shuffle(_list_tints);

	var _list_scales = ds_list_create();
	ds_list_add(
		_list_scales,
		0.92,
		0.96,
		1.00,
		1.04,
		1.08
	);
	ds_list_shuffle(_list_scales);

	var _arr_choice_uids = [];

	for (var _it_chest = 0;_it_chest < 5;_it_chest++){

		var _val_angle = -90 + (_it_chest * 72);
		var _val_x = _ref_anchor.x + lengthdir_x(_val_radius,_val_angle);
		var _val_y = _ref_anchor.y + lengthdir_y(_val_radius,_val_angle);

		var _uid_entity = scr_world_event_allocate_entity_uid();

		var _stct_record =
			scr_world_event_entity_record_create(
				_stct_event._uid_world_event,
				_uid_entity,
				"GILDED_GAMBIT_CHEST",
				_ref_anchor._str_spawn_id,
				room,
				_val_x,
				_val_y,
				{
					_it_choice_index : _it_chest,
					_c_cosmetic_tint : ds_list_find_value(_list_tints,_it_chest),
					_val_cosmetic_scale : ds_list_find_value(_list_scales,_it_chest),
					_flag_selected : false
				}
			);

		if (!scr_world_event_entity_record_add(_stct_event,_stct_record)){
			ds_list_destroy(_list_tints);
			ds_list_destroy(_list_scales);
			return false;
		}

		array_push(_arr_choice_uids,_uid_entity);
	}

	ds_list_destroy(_list_tints);
	ds_list_destroy(_list_scales);

	_stct_event._arr_selected_spawn_ids = [_ref_anchor._str_spawn_id];
	_stct_event._ct_goal = 1;
	_stct_event._ct_progress = 0;

	_stct_payload._flag_gilded_gambit_generated = true;
	_stct_payload._flag_gilded_gambit_choice_made = false;
	_stct_payload._uid_gilded_gambit_choice = -1;
	_stct_payload._arr_gilded_gambit_chest_uids = _arr_choice_uids;
	_stct_payload._str_gilded_gambit_spawn_id = _ref_anchor._str_spawn_id;
	_stct_payload._val_gilded_gambit_center_x = _ref_anchor.x;
	_stct_payload._val_gilded_gambit_center_y = _ref_anchor.y;

	scr_debug_log(
		"WORLD_EVENT",
		"GILDED_GAMBIT",
		_ref_controller,
		"GILDED GAMBIT GENERATED" +
		" | UID: " + string(_stct_event._uid_world_event) +
		" | SPAWN: " + _ref_anchor._str_spawn_id +
		" | CHESTS: 5",
		"INFO",
		"SCR_WORLD_EVENT_GILDED_GAMBIT_GENERATE"
	);

	return true;
}
