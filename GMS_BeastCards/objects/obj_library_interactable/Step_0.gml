//===============================================================================//
//
// STEP: OBJ_LIBRARY_INTERACTABLE
// FUNCTION: Highlights the Library interactable when the player is nearby.
//           Opens the Library GUI when the player presses E.
//           Logs the current Deck and Library collection counts.
//           Handles interaction cooldown to prevent repeated GUI spawning.
//
//===============================================================================//

//======================//
//PROXIMITY INTERACTION//
//======================//
#region PROXIMITY INTERACTION

if (
	instance_exists(obj_player) &&
	distance_to_object(obj_player) < 48 &&
	!global.flag_pause
){

	image_index = 1;

	if (
		!_flag_triggered &&
		_ct_cooldown == 0 &&
		keyboard_check_pressed(ord("E"))
	){

		audio_play_sound(
			snd_gui_open,
			0,
			false
		);

		_flag_triggered = true;
		_ct_cooldown = 60;

		//================//
		//GUI POSITION//
		//================//
		var _val_gui_center_x = display_get_gui_width() * 0.5;
		var _val_gui_center_y = display_get_gui_height() * 0.5;

		//================//
		//CLOSE ACTIVE GUI//
		//================//
		if (instance_exists(obj_gui_controller)){

			obj_gui_controller.hscr_gui_destroy_active();
			obj_gui_controller.hscr_gui_set_pause(true);
		}

		//================//
		//OPEN LIBRARY//
		//================//
		var _ref_library_gui = instance_create_layer(
			_val_gui_center_x,
			_val_gui_center_y,
			"ily_fx",
			obj_gui_library_pane
		);

		global.ref_active_gui = _ref_library_gui;

		//================//
		//DEBUG LIBRARY//
		//================//
		var _ct_deck = 0;
		var _ct_library = 0;

		if (
			variable_global_exists("list_player_deck") &&
			ds_exists(global.list_player_deck,ds_type_list)
		){
			_ct_deck = ds_list_size(global.list_player_deck);
		}

		if (
			variable_global_exists("list_player_library") &&
			ds_exists(global.list_player_library,ds_type_list)
		){
			_ct_library = ds_list_size(global.list_player_library);
		}

		scr_debug_log(
			"CARDS",
			"LIBRARY",
			self,
			"LIBRARY OPENED" +
			" | DECK: " +
			string(_ct_deck) +
			"/30" +
			" | LIBRARY: " +
			string(_ct_library),
			"INFO",
			"OBJ_LIBRARY_INTERACTABLE:STEP"
		);
	}
}
else{
	image_index = 0;
}

#endregion

//================//
//CLICK COOLDOWN//
//================//
#region CLICK COOLDOWN

if (_ct_cooldown > 0){

	_ct_cooldown--;

	if (_ct_cooldown <= 0){

		_ct_cooldown = 0;
		_flag_triggered = false;
	}
}

#endregion