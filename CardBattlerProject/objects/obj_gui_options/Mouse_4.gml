//////////////////////////////////////////////////////////////////////
//						OBJ_GUI_OPTIONS LEFT PRESS					//
//																	//
// > HANDLE LEFT PRESS INPUT									    //
//////////////////////////////////////////////////////////////////////
// Adjust mouse position based on the current window size
_mx = device_mouse_x_to_gui(0);
_my = device_mouse_y_to_gui(0);

//////////////////
// CLOSE BUTTON //
//////////////////
	if (_mx < 1135 && _mx > 1114 && _my < 308 && _my > 289){
		image_index = 2;
		global.flag_gui_open = false;
		obj_menu_controller._clicked = false;
		instance_destroy();
	}

///////////////////////
//  LEFT CLICK LOGIC //
///////////////////////
///////////////////////
//  LEFT CLICK LOGIC //
///////////////////////
if (mouse_check_button_pressed(mb_left)) {

    // Resolution Change
    if (point_in_rectangle(_mx, _my, _menu_x + 200, _menu_y + _spacing, _menu_x + 270, _menu_y + _spacing + 20)) {
        _res_index = (_res_index + 1) mod array_length(_resolutions);
    }

    // Sound Slider
    if (point_in_rectangle(_mx, _my, _menu_x + 100, _menu_y + _spacing + 30, _menu_x + 200, _menu_y + _spacing + 50)) {
        _dragging_sound = true;
    }

    // Music Slider
    if (point_in_rectangle(_mx, _my, _menu_x + 100, _menu_y + _spacing + 60, _menu_x + 200, _menu_y + _spacing + 80)) {
        _dragging_music = true;
    }

    // Checkbox Toggle
    if (point_in_rectangle(_mx, _my, _menu_x + 150, _menu_y + _spacing + 90, _menu_x + 170, _menu_y + _spacing + 110)) {
        global.toggle_tutorials = !global.toggle_tutorials;
    }

    // Apply Button (Only in rm_main_menu)
    if (_hover_apply) {
        if (room == rm_main_menu) {
            window_set_size(_resolutions[_res_index][0], _resolutions[_res_index][1]);
            global.sound_gain = _sound_volume;
            global.music_gain = _music_volume;
            global.flag_gui_open = false;
            obj_menu_controller._clicked = false;
            instance_destroy();

			// Clear and write new values to the file
			var _exitfile = file_text_open_write("game_options.txt");

			// Ensure file is empty by clearing it first
			file_text_close(_exitfile); // Close the file before reopening to clear its contents

			_exitfile = file_text_open_write("game_options.txt");  // Open the file again for writing
			file_text_write_real(_exitfile, _res_index);
			file_text_write_real(_exitfile, _sound_volume);
			file_text_write_real(_exitfile, _music_volume);
			file_text_write_string(_exitfile, string(global.toggle_tutorials));

			file_text_close(_exitfile); // Close the file after writing
        }
    }

    // Quit Button
    if (_hover_quit) {
        game_end();
    }
}