//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_CLEANUP_ROOM_INSTANCES
// FUNCTION: Destroys live overworld instances owned by one World Event UID and releases GUI/NPC runtime references tied to that event. Persistent event data is not modified.
//
//===============================================================================//

function scr_world_event_cleanup_room_instances(_uid_world_event){

	if (!is_real(_uid_world_event) || _uid_world_event < 0){
		return 0;
	}

	//================//
	//EVENT GUI / NPC INTERACTION//
	//================//
	// Release GUI references while the World Event NPC still exists so normal
	// pane Cleanup logic can finish before the owning instance is destroyed.
	if (
		variable_global_exists("ref_active_gui") &&
		instance_exists(global.ref_active_gui)
	){
		var _ref_active_gui = global.ref_active_gui;
		var _ref_gui_owner = undefined;

		if (
			variable_instance_exists(_ref_active_gui,"_ref_npc") &&
			instance_exists(_ref_active_gui._ref_npc)
		){
			_ref_gui_owner = _ref_active_gui._ref_npc;
		}
		else if (
			variable_instance_exists(_ref_active_gui,"_ref_market_owner") &&
			instance_exists(_ref_active_gui._ref_market_owner)
		){
			_ref_gui_owner = _ref_active_gui._ref_market_owner;
		}

		if (
			instance_exists(_ref_gui_owner) &&
			variable_instance_exists(_ref_gui_owner,"_flag_world_event_instance") &&
			_ref_gui_owner._flag_world_event_instance &&
			variable_instance_exists(_ref_gui_owner,"_uid_world_event") &&
			_ref_gui_owner._uid_world_event == _uid_world_event
		){
			if (instance_exists(obj_gui_controller)){
				obj_gui_controller.hscr_gui_destroy_active("WORLD EVENT CLEANUP");
				obj_gui_controller.hscr_gui_set_pause(false,"WORLD EVENT CLEANUP");
			}
			else{
				global.ref_active_gui = undefined;
				instance_destroy(_ref_active_gui);
				global.flag_pause = false;
				if (instance_exists(obj_player)){
					scr_player_set_movement_state("START");
				}
			}
		}
	}

	if (
		variable_global_exists("ref_interacting_npc") &&
		instance_exists(global.ref_interacting_npc) &&
		variable_instance_exists(global.ref_interacting_npc,"_flag_world_event_instance") &&
		global.ref_interacting_npc._flag_world_event_instance &&
		variable_instance_exists(global.ref_interacting_npc,"_uid_world_event") &&
		global.ref_interacting_npc._uid_world_event == _uid_world_event
	){
		if (variable_instance_exists(global.ref_interacting_npc,"hscr_npc_close_interaction")){
			global.ref_interacting_npc.hscr_npc_close_interaction();
		}
		else{
			global.ref_interacting_npc = undefined;
		}
	}

	var _ct_removed = 0;
	var _ct_beasts = instance_number(obj_overworld_beast);

	for (
		var _it_beast = _ct_beasts - 1;
		_it_beast >= 0;
		_it_beast--
	){

		var _ref_beast =
			instance_find(
				obj_overworld_beast,
				_it_beast
			);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (
			!variable_instance_exists(
				_ref_beast,
				"_flag_world_event_instance"
			) ||
			!_ref_beast._flag_world_event_instance
		){
			continue;
		}

		if (
			!variable_instance_exists(
				_ref_beast,
				"_uid_world_event"
			) ||
			_ref_beast._uid_world_event !=
				_uid_world_event
		){
			continue;
		}

		_ct_removed++;

		instance_destroy(
			_ref_beast
		);
	}

	var _ct_chests = instance_number(obj_overworld_treasure_chest);

	for (
		var _it_chest = _ct_chests - 1;
		_it_chest >= 0;
		_it_chest--
	){

		var _ref_chest =
			instance_find(
				obj_overworld_treasure_chest,
				_it_chest
			);

		if (!instance_exists(_ref_chest)){
			continue;
		}

		if (
			!variable_instance_exists(
				_ref_chest,
				"_flag_world_event_instance"
			) ||
			!_ref_chest._flag_world_event_instance
		){
			continue;
		}

		if (
			!variable_instance_exists(
				_ref_chest,
				"_uid_world_event"
			) ||
			_ref_chest._uid_world_event !=
				_uid_world_event
		){
			continue;
		}

		_ct_removed++;
		instance_destroy(_ref_chest);
	}

	var _ct_sparkles = instance_number(obj_overworld_treasure_sparkle);

	for (
		var _it_sparkle = _ct_sparkles - 1;
		_it_sparkle >= 0;
		_it_sparkle--
	){

		var _ref_sparkle =
			instance_find(
				obj_overworld_treasure_sparkle,
				_it_sparkle
			);

		if (!instance_exists(_ref_sparkle)){
			continue;
		}

		if (
			!variable_instance_exists(
				_ref_sparkle,
				"_flag_world_event_instance"
			) ||
			!_ref_sparkle._flag_world_event_instance
		){
			continue;
		}

		if (
			!variable_instance_exists(
				_ref_sparkle,
				"_uid_world_event"
			) ||
			_ref_sparkle._uid_world_event !=
				_uid_world_event
		){
			continue;
		}

		_ct_removed++;
		instance_destroy(_ref_sparkle);
	}


	var _ct_npcs = instance_number(obj_npc);

	for (
		var _it_npc = _ct_npcs - 1;
		_it_npc >= 0;
		_it_npc--
	){

		var _ref_npc =
			instance_find(
				obj_npc,
				_it_npc
			);

		if (!instance_exists(_ref_npc)){
			continue;
		}

		if (
			!variable_instance_exists(
				_ref_npc,
				"_flag_world_event_instance"
			) ||
			!_ref_npc._flag_world_event_instance
		){
			continue;
		}

		if (
			!variable_instance_exists(
				_ref_npc,
				"_uid_world_event"
			) ||
			_ref_npc._uid_world_event !=
				_uid_world_event
		){
			continue;
		}

		_ct_removed++;
		instance_destroy(_ref_npc);
	}

	//================//
	//STALE GLOBAL REFERENCES//
	//================//
	if (
		variable_global_exists("ref_interacting_npc") &&
		global.ref_interacting_npc != undefined &&
		!instance_exists(global.ref_interacting_npc)
	){
		global.ref_interacting_npc = undefined;
	}

	if (
		variable_global_exists("ref_active_gui") &&
		global.ref_active_gui != undefined &&
		!instance_exists(global.ref_active_gui)
	){
		global.ref_active_gui = undefined;
	}

	return _ct_removed;
}
