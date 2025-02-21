//////////////////////////////////////////////////////////////////////
//					OBJ_MENU_CONTROLLER CREATE						//
//																	//
// > ESTABLISH VARIABLE DEFINITIONS FOR MENUS THROUGHOUT THE GAME.	//
//   USED IN OPTIONS MENU AND SUCH.									//
//////////////////////////////////////////////////////////////////////

depth = -99;

global.game_folder = "C:/CardBattler/";
global.default_settings_file = "C:/CardBattler/Default_Settings.ini";
global.settings_file = "C:/CardBattler/Settings.ini"
global.save_folder = "C:/CardBattler/Saves/"

if (!directory_exists(global.game_folder)) {
	directory_create(global.game_folder);
}

if (!directory_exists(global.save_folder)) {
	directory_create(global.save_folder);
}

//set up default settings file
if (!file_exists(global.default_settings_file)) {
	ini_open(global.default_settings_file);
	ini_write_string("Settings", "fullscreen", false);	
	ini_write_string("Settings", "tutorials", true);	
	ini_write_real("Settings", "music_volume", 1);	
	ini_write_real("Settings", "sound_volume", 1);	
	ini_write_real("Settings", "res_index", 3);	
	ini_write_real("Settings", "res_y", 1080);	
	ini_write_real("Settings", "res_x", 1920);
	ini_close();
}

// Default values in case the file doesn't exist
global.res_x = 1920;
global.res_y = 1080;
global.res_index = 3;
global.sound_vol = 1.0;
global.music_vol = 1.0;
global.flag_tutorials = true; 
global.flag_fullscreen = false; 

// Check if the file exists before opening
if (file_exists(global.settings_file)) {
    ini_open(global.settings_file);

    // Read from the "Settings" section
    global.res_x = ini_read_real("Settings", "res_x", global.res_x);
    global.res_y = ini_read_real("Settings", "res_y", global.res_y);
    global.res_index = ini_read_real("Settings", "res_index", global.res_index);
    global.sound_vol = ini_read_real("Settings", "sound_volume", global.sound_vol);
    global.music_vol = ini_read_real("Settings", "music_volume", global.music_vol);
    global.flag_tutorials = ini_read_string("Settings", "tutorials", "true") == "true";
	global.flag_fullscreen = ini_read_string("Settings", "fullscreen", "true") == "true";

    ini_close();
}

// Apply the settings

window_set_size(global.res_x, global.res_y);
audio_master_gain(global.sound_vol);

//window fulscreen
window_set_fullscreen(global.flag_fullscreen);

global.flag_gui_open = false; //tracks if there is a menu gui open
_clicked = false;