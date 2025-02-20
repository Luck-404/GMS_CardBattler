//////////////////////////////////////////////////////////////////////
//						OBJ_GUI_OPTIONS LEFT PRESS					//
//																	//
// > HANDLE LEFT PRESS INPUT									    //
//////////////////////////////////////////////////////////////////////
show_debug_message("Mouse Position: " + string(_mx) + ", " + string(_my));

// Adjust mouse position based on the current window size
_mx = mouse_x;
_my = mouse_y;



///////////////////////
//  LEFT CLICK LOGIC //
///////////////////////
// Resolution Change
if (_hover_resolution) {
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
if (_hover_checkbox) {
    global.flag_tutorials = !(global.flag_tutorials);
}

// Apply Button
if (_hover_apply) {
    var _settings_path = "C:/CardBattler/Settings.ini";

    ini_open(_settings_path);
    ini_write_real("Settings", "res_x", global.res_x);
    ini_write_real("Settings", "res_y", global.res_y);
    ini_write_real("Settings", "res_index", global.res_index);
    ini_write_real("Settings", "sound_volume", global.sound_vol);
    ini_write_real("Settings", "music_volume", global.music_vol);
    ini_write_string("Settings", "tutorials", scr_bool_to_string(global.flag_tutorials));
    ini_close();
	// Set the updated window size
	window_set_size(global.res_x, global.res_y);
	if (instance_exists(obj_music_timer)){
		audio_stop_all();
		instance_destroy(obj_music_timer);
	}
	audio_master_gain(global.sound_vol);
}

if (_hover_reset){
	//delete old file
	var _settings_path = "C:/CardBattler/Settings.ini";
	file_delete(_settings_path);
	
	// Define the original INI file path and the new file path
	var _original_file_path = "C:/Games/CardBattler/Default_Settings.ini"; // Replace with your actual path
	var _new_file_path = "C:/Games/CardBattler/Settings.ini"; // The new file name
	ini_open(_new_file_path);
	ini_close();
	
	// Check if the original file exists
	if (file_exists(_original_file_path)) {
		
	    // Copy the original INI file to the new location
	    var _result = file_copy(_original_file_path, _new_file_path);
    
	    // Check if the copy was successful
	    if (_result) {
	        show_debug_message("File copied successfully!");
	    } else {
	        show_debug_message("Failed to copy the file.");
	    }
	} else {
	    show_debug_message("Original file does not exist.");
	}
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