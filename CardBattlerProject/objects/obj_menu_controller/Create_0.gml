//////////////////////////////////////////////////////////////////////
//					OBJ_MENU_CONTROLLER CREATE						//
//																	//
// > ESTABLISH VARIABLE DEFINITIONS FOR MENUS THROUGHOUT THE GAME.	//
//   USED IN OPTIONS MENU AND SUCH.									//
//////////////////////////////////////////////////////////////////////
global.flag_gui_open = false; //tracks if there is a menu gui open
global.res_x=1920; //tracks the x size of the resolution
global.res_y=1080; //tracks the y size of the resolution
global.res_index = 2; //
global.sound_vol = 1;
global.music_vol = 1;
global.flag_tutorials = true; //tracks the tutorials checkbox
_clicked = false;

// Load settings from the file (if it exists)
if (file_exists("saved_options.txt")) {
		var _filepath = working_directory + "saved_options.txt";
		show_debug_message("read filepath: "+ string(_filepath));		
		if (file_exists(_filepath)) {
		    _file = file_text_open_read(_filepath);
	        global.res_x = file_text_read_real(_file);
	        show_debug_message("Res X: " + string(global.res_x));
        
	        global.res_y = file_text_read_real(_file);
	        show_debug_message("Res Y: " + string(global.res_y));
        
	        global.res_index = file_text_read_real(_file);
	        show_debug_message("Res Index: " + string(global.res_index));
        
	        global.sound_vol = file_text_read_real(_file);
	        show_debug_message("Sound Vol: " + string(global.sound_vol));
        
	        global.music_vol = file_text_read_real(_file);
	        show_debug_message("Music Vol: " + string(global.music_vol));
        
			////load global.flag_tutorials value from next line (it is either "true" or "false")
			//// Read the boolean value from file
			//var _tutorials_str = file_text_read_string(_file);
			//global.flag_tutorials = (_tutorials_str == "true");
			//show_debug_message("Tutorials Enabled: " + string(global.flag_tutorials));

	        file_text_close(_file);
	}
}

window_set_size(global.res_x, global.res_y);
audio_master_gain(global.sound_vol);