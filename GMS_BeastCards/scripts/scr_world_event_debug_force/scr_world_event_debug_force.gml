//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_DEBUG
// FUNCTION: Developer-only World Event forcing, clearing, and Merchant-stock reroll
//           helpers used by the Cheats Menu. Normal event RNG is unchanged.
//
//===============================================================================//

function scr_world_event_debug_force_event(_str_event_id,_rm_target,_str_forced_species=""){

	var _ref_controller = scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	_str_event_id = string_upper(string(_str_event_id));
	_str_forced_species = string(_str_forced_species);

	//================//
	//CLEAR CURRENT EVENT//
	//================//
	if (
		is_struct(_ref_controller._stct_active_world_event) &&
		_ref_controller._stct_active_world_event._state_world_event !=
			ENUM_WORLD_EVENT_STATE.NONE
	){
		scr_world_event_clear(false);
	}

	//================//
	//DEBUG PAYLOAD//
	//================//
	var _stct_payload = {
		_flag_debug_forced_event : true,
		_str_debug_forced_species : ""
	};

	if (
		_str_event_id == "MIGRATION" ||
		_str_event_id == "ELITE_SIGHTING" ||
		_str_event_id == "RUNAWAY_TREASURE_BEAST"
	){
		_stct_payload._str_debug_forced_species = _str_forced_species;
	}

	//================//
	//CREATE EVENT//
	//================//
	var _stct_event = scr_world_event_create(
		_str_event_id,
		_rm_target,
		_stct_payload,
		true
	);

	if (!is_struct(_stct_event)){
		return false;
	}

	// Cheats intentionally skips the travel/announcement state so the event is
	// immediately testable in the selected room.
	_stct_event._state_world_event = ENUM_WORLD_EVENT_STATE.ACTIVE;
	_stct_event._val_announcement_time_remaining = 0;
	_stct_event._flag_announcement_pending = false;
	_stct_event._flag_room_initialized = false;

	var _flag_sync = true;

	//================//
	//SYNC CURRENT ROOM//
	//================//
	if (_rm_target == room){

		switch (_str_event_id){

			case "MIGRATION":
				_flag_sync = scr_world_event_migration_sync_room();
			break;

			case "CHOOSE_A_CHEST":
				_flag_sync = scr_world_event_gilded_gambit_sync_room();
			break;

			case "RUNAWAY_TREASURE_BEAST":
				_flag_sync = scr_world_event_runaway_treasure_sync_room();
			break;

			case "WANDERING_MERCHANT":
				_flag_sync = scr_world_event_wandering_merchant_sync_room();
			break;

			case "ELITE_SIGHTING":
				_flag_sync = scr_world_event_elite_sighting_sync_room();
			break;
		}
	}

	if (!_flag_sync){
		scr_world_event_clear(false);
		return false;
	}

	scr_world_event_show_banner(
		"DEBUG WORLD EVENT",
		_stct_event._str_display_name,
		_stct_event._str_target_room_name
	);

	scr_debug_log(
		"WORLD_EVENT",
		"CHEATS",
		_ref_controller,
		"DEBUG WORLD EVENT FORCED" +
		" | EVENT: " + _str_event_id +
		" | ROOM: " + _stct_event._str_target_room_name +
		((_str_forced_species != "") ? " | BEAST: " + string_upper(_str_forced_species) : ""),
		"INFO",
		"SCR_WORLD_EVENT_DEBUG_FORCE_EVENT"
	);

	return true;
}

function scr_world_event_debug_clear_active(){

	var _ref_controller = scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	if (
		!is_struct(_ref_controller._stct_active_world_event) ||
		_ref_controller._stct_active_world_event._state_world_event ==
			ENUM_WORLD_EVENT_STATE.NONE
	){
		return false;
	}

	return scr_world_event_clear(true);
}

function scr_world_event_debug_reroll_merchant_stock(){

	var _ref_controller = scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	var _stct_event = _ref_controller._stct_active_world_event;

	if (
		!is_struct(_stct_event) ||
		_stct_event._str_event_id != "WANDERING_MERCHANT" ||
		_stct_event._state_world_event != ENUM_WORLD_EVENT_STATE.ACTIVE ||
		!is_struct(_stct_event._stct_payload)
	){
		return false;
	}

	var _stct_payload = _stct_event._stct_payload;

	if (
		!variable_struct_exists(_stct_payload,"_flag_wandering_merchant_generated") ||
		!_stct_payload._flag_wandering_merchant_generated ||
		!variable_struct_exists(_stct_payload,"_uid_wandering_merchant_npc")
	){
		return false;
	}

	var _arr_stock = scr_world_event_wandering_merchant_roll_stock();

	if (!is_array(_arr_stock) || array_length(_arr_stock) <= 0){
		return false;
	}

	_stct_payload._arr_wandering_merchant_trade_stock = _arr_stock;

	var _uid_npc = _stct_payload._uid_wandering_merchant_npc;
	var _str_market_uid = "NPC_VENDOR_" + string(_uid_npc);

	// Remove the converted Market-offer cache so the next Trade open rebuilds from
	// the freshly rolled event stock.
	if (
		variable_global_exists("map_market_stock") &&
		ds_exists(global.map_market_stock,ds_type_map) &&
		ds_map_exists(global.map_market_stock,_str_market_uid)
	){
		ds_map_delete(global.map_market_stock,_str_market_uid);
	}

	// Update the live Merchant NPC immediately when it exists in the current room.
	var _ct_npcs = instance_number(obj_npc);

	for (var _it_npc = 0;_it_npc < _ct_npcs;_it_npc++){

		var _ref_npc = instance_find(obj_npc,_it_npc);

		if (
			instance_exists(_ref_npc) &&
			variable_instance_exists(_ref_npc,"_uid_npc") &&
			_ref_npc._uid_npc == _uid_npc &&
			is_struct(_ref_npc._stct_npc)
		){
			_ref_npc._stct_npc._arr_trade_stock = _arr_stock;
			break;
		}
	}

	scr_debug_log(
		"WORLD_EVENT",
		"CHEATS",
		_ref_controller,
		"WANDERING MERCHANT STOCK REROLLED" +
		" | EVENT UID: " + string(_stct_event._uid_world_event) +
		" | NPC UID: " + string(_uid_npc) +
		" | OFFERS: " + string(array_length(_arr_stock)),
		"INFO",
		"SCR_WORLD_EVENT_DEBUG_REROLL_MERCHANT_STOCK"
	);

	return true;
}
