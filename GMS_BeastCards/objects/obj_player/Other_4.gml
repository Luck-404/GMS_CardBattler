//===============================================================================//
//
// ROOM START: OBJ_PLAYER
// FUNCTION: Initializes overworld room state.
//           Forces a complete gameplay resume whenever the player enters the
//           overworld, resolves pending Cheat room-center teleportation,
//           and prevents encounters for the first 180 frames.
//
//===============================================================================//

if (room != rm_battle){

	//===============================================================================//
	// OVERWORLD RESUME
	//===============================================================================//

	//================//
	//CLEAR STALE GUI//
	//================//
	if (
		variable_global_exists(
			"ref_active_gui"
		) &&
		!instance_exists(
			global.ref_active_gui
		)
	){
		global.ref_active_gui =
			undefined;
	}

	//================//
	//CLOSE CHEATS//
	//================//
	if (
		variable_global_exists(
			"ref_active_gui"
		) &&
		instance_exists(
			global.ref_active_gui
		) &&
		variable_instance_exists(
			global.ref_active_gui,
			"_str_type"
		) &&
		global.ref_active_gui._str_type ==
			"CHEATS"
	){

		if (
			instance_exists(
				obj_gui_controller
			)
		){

			obj_gui_controller
				.hscr_gui_destroy_active(
					"OVERWORLD ROOM START"
				);
		}
		else{

			var _ref_cheats =
				global.ref_active_gui;

			global.ref_active_gui =
				undefined;

			instance_destroy(
				_ref_cheats
			);
		}
	}

	//================//
	//RESUME PLAYER//
	//================//
	if (
		instance_exists(
			obj_gui_controller
		)
	){

		obj_gui_controller
			.hscr_gui_set_pause(
				false,
				"OVERWORLD ROOM START"
			);
	}
	else{

		global.flag_pause =
			false;

		scr_player_set_movement_state(
			"START"
		);
	}

	//===============================================================================//
	// CHEAT ROOM TELEPORT
	//===============================================================================//

	//================//
	//CENTER PLAYER//
	//================//
	/*
		TELEPORT RANCH sets this before changing rooms.

		Resolve it here so room_width / room_height belong to the
		destination room and the companion/camera initialize around
		the player's new location.
	*/
	if (
		variable_global_exists(
			"flag_cheat_center_player_on_room_start"
		) &&
		global.flag_cheat_center_player_on_room_start
	){

		global.flag_cheat_center_player_on_room_start =
			false;

		x =
			room_width *
			0.5;

		y =
			room_height *
			0.5;

		scr_debug_log(
			"GUI",
			"CHEATS",
			self,
			"PLAYER ROOM TELEPORT COMPLETE" +
			" | ROOM: " +
			string_upper(
				room_get_name(room)
			) +
			" | POSITION: (" +
			string(
				round(x)
			) +
			"," +
			string(
				round(y)
			) +
			")",
			"INFO",
			"OBJ_PLAYER:ROOM_START"
		);
	}

	//===============================================================================//
	// OVERWORLD SETUP
	//===============================================================================//

	//================//
	//RESET CAMERA//
	//================//
	_flag_camera_created =
		false;

	//================//
	//SPAWN COMPANION//
	//================//
	scr_overworld_spawn_companion_beast();

	//================//
	//INITIAL GAME START//
	//================//
	if (
		global.flag_game_just_started ==
		true
	){

		global.flag_game_just_started =
			false;

		exit;
	}

	//===============================================================================//
	// ROOM ENTRY BATTLE LOCK
	//===============================================================================//

	if (
		!instance_exists(
			obj_battle_wait
		)
	){

		var _ref_encounter_wait =
			instance_create_layer(
				x,
				y,
				"ily_fx",
				obj_battle_wait
			);

		_ref_encounter_wait._ct_life =
			180;
	}
}