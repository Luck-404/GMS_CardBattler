//===============================================================================//
//
// STEP: OBJ_LIBRARY_INTERACTABLE
// FUNCTION: Highlights the library interactable when the player is nearby.
// Opens the library GUI when the player presses E.
// Handles interaction cooldown to prevent repeated GUI spawning.
//
//===============================================================================//

//
// PROXIMITY INTERACTION
//
#region PROXIMITY INTERACTION
if (distance_to_object(obj_player) < 48 && !global.pause){
	image_index = 1;

	if (!_flag_triggered && _val_cooldown == 0){
		if (keyboard_check(ord("E"))){
			_flag_triggered = true;
			_val_cooldown = 60;

			var _ref_library_gui = instance_create_layer(room_width * 0.5,room_height * 0.5,"ily_fx",obj_gui_library_pane);

			obj_gui_controller.hscr_destroy_gui_open();
			obj_gui_controller.hscr_toggle_gui_pause(true);

			global.active_gui = _ref_library_gui;
		}
	}
}
else{
	image_index = 0;
}
#endregion

//
// CLICK COOLDOWN
//
#region CLICK COOLDOWN
if (_val_cooldown > 0){
	_val_cooldown--;

	if (_val_cooldown <= 0){
		_val_cooldown = 0;
		_flag_triggered = false;
	}
}
#endregion