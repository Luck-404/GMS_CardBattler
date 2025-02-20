//////////////////////////////////////////////////////////////////////
//					OBJ_MENU_CONTROLLER CREATE						//
//																	//
// > ESTABLISH VARIABLE DEFINITIONS FOR MENUS THROUGHOUT THE GAME.	//
//   USED IN OPTIONS MENU AND SUCH.									//
//////////////////////////////////////////////////////////////////////

_save_folder = "C:/CardBattler/";

if (!directory_exists(_save_folder)) {
	    directory_create(_save_folder);
}
	
// Define the file path
_file_path = _save_folder + "/Settings.ini";

// Default values in case the file doesn't exist
global.res_x = 1920;
global.res_y = 1080;
global.res_index = 3;
global.sound_vol = 1.0;
global.music_vol = 1.0;
global.flag_tutorials = true; 

// Check if the file exists before opening
if (file_exists(_file_path)) {
    ini_open(_file_path);

    // Read from the "Settings" section
    global.res_x = ini_read_real("Settings", "res_x", global.res_x);
    global.res_y = ini_read_real("Settings", "res_y", global.res_y);
    global.res_index = ini_read_real("Settings", "res_index", global.res_index);
    global.sound_vol = ini_read_real("Settings", "sound_volume", global.sound_vol);
    global.music_vol = ini_read_real("Settings", "music_volume", global.music_vol);
    global.flag_tutorials = ini_read_string("Settings", "tutorials", "true") == "true";

    ini_close();
}

// Apply the settings
window_set_size(global.res_x, global.res_y);
audio_master_gain(global.sound_vol);
global.ui_scalar = scr_get_ui_scalar();


global.flag_gui_open = false; //tracks if there is a menu gui open
_clicked = false;