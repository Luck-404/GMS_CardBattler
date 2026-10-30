//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_GILDED_GAMBIT_SPAWN_CHEST
// FUNCTION: Reconstructs one unresolved Gilded Gambit chest from persistent data.
//
//===============================================================================//

function scr_world_event_gilded_gambit_spawn_chest(_stct_event,_stct_record){

	if (
		!is_struct(_stct_event) ||
		!is_struct(_stct_record) ||
		_stct_record._flag_resolved
	){
		return noone;
	}

	var _ref_chest =
		instance_create_layer(
			_stct_record._val_x,
			_stct_record._val_y,
			"ily_npcs",
			obj_overworld_treasure_chest
		);

	if (!instance_exists(_ref_chest)){
		return noone;
	}

	_ref_chest._flag_world_event_instance = true;
	_ref_chest._uid_world_event = _stct_event._uid_world_event;
	_ref_chest._uid_world_event_entity = _stct_record._uid_world_event_entity;
	_ref_chest._str_world_event_id = "CHOOSE_A_CHEST";
	_ref_chest._str_world_event_spawn_id = _stct_record._str_spawn_id;
	_ref_chest._str_chest_id = "GILDED_GAMBIT";
	_ref_chest._str_loot_type = "WORLD_EVENT";
	_ref_chest._flag_triggered = false;
	_ref_chest.image_index = 0;

	if (is_struct(_stct_record._stct_payload)){

		if (variable_struct_exists(_stct_record._stct_payload,"_c_cosmetic_tint")){
			_ref_chest._c_chest = _stct_record._stct_payload._c_cosmetic_tint;
		}

		if (variable_struct_exists(_stct_record._stct_payload,"_val_cosmetic_scale")){
			_ref_chest._val_world_event_chest_scale =
				_stct_record._stct_payload._val_cosmetic_scale;
		}

		_ref_chest._flag_world_event_choice_banner_owner =
			variable_struct_exists(_stct_record._stct_payload,"_it_choice_index") &&
			_stct_record._stct_payload._it_choice_index == 0;
	}

	return _ref_chest;
}
