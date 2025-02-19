//////////////////////////////////////////////////////////////////////
//						OBJ_GUI_OPTIONS LEFT PRESS					//
//																	//
// > HANDLE LEFT PRESS INPUT									    //
//////////////////////////////////////////////////////////////////////
show_debug_message("Mouse Position: " + string(_mx) + ", " + string(_my));

// Adjust mouse position based on the current window size
_mx = window_mouse_get_x();
_my = window_mouse_get_y();

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
// Resolution Change
if (point_in_rectangle(_mx, _my, _menu_x + 200, _menu_y + _spacing, _menu_x + 270, _menu_y + _spacing + 20)) {
    global.res_index = (global.res_index + 1) mod array_length(_resolutions);
	global.res_x = _resolutions[global.res_index][0];
	global.res_y = _resolutions[global.res_index][1];
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
    global.flag_tutorials = !(global.flag_tutorials);
}

// Apply Button
if (_hover_apply) {
var _filepath = working_directory + "saved_options.txt";
show_debug_message("delete filepath: "+ string(_filepath));		
file_delete(_filepath); // Delete the old file

var _exitfile = file_text_open_write(_filepath); // Create a new file
_filepath = working_directory + "saved_options.txt";
show_debug_message("write filepath: "+ string(_filepath));	
// Check if the file opened successfully
if (_exitfile != -1) {
    file_text_write_real(_exitfile, global.res_x);
    file_text_writeln(_exitfile);
    file_text_write_real(_exitfile, global.res_y);
    file_text_writeln(_exitfile);
    file_text_write_real(_exitfile, global.res_index);
    file_text_writeln(_exitfile);
    file_text_write_real(_exitfile, global.sound_vol);
    file_text_writeln(_exitfile);
    file_text_write_real(_exitfile, global.music_vol);
    file_text_writeln(_exitfile);
	//write either "true" or "false" to file based on global.flag_tutorials
	// Write boolean value for global.flag_tutorials
	//file_text_write_string(_exitfile, string(global.flag_tutorials));
    //file_text_writeln(_exitfile);
		
    show_debug_message("New Res X: " + string(global.res_x));
    show_debug_message("New Res Y: " + string(global.res_y));
    show_debug_message("New Res Index: " + string(global.res_index));
    show_debug_message("New Sound Vol: " + string(global.sound_vol));
    show_debug_message("New Music Vol: " + string(global.music_vol));
		
	////print out the value (true or false) of global.flag_tutorials
    //show_debug_message("New Tutorials: " + string(global.flag_tutorials));
		
    // Close the file after writing
    file_text_close(_exitfile);
} else {
    show_message("Error: Could not create or write to saved_options.txt!");
}

// Set the updated window size
window_set_size(global.res_x, global.res_y);
if (instance_exists(obj_music_timer)){
	audio_stop_all();
	instance_destroy(obj_music_timer);
}
audio_master_gain(global.sound_vol);
}

// Quit Button
if (_hover_quit) {
	//save script
		
    //start transition to main menu
		
}
	

// Forfeit Button
if (_hover_forfeit) {
    //save
		
	//take 25% hp from all units
		
	//start transition to overworld
		
}	