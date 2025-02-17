//////////////////////////////////////////////////////////////////////
//						OBJ_GUI_OPTIONS CREATE						//
//																	//
// > ESTABLISH VARIABLES											//
//////////////////////////////////////////////////////////////////////
draw_set_font(fnt_fanwood_sm);
// Resolution options
_resolutions = [
    [1280, 720], 
    [1600, 900], 
    [1920, 1080]
];
_res_index = 2; // Default to first resolution

// Volume sliders
_sound_volume = 1.0; // Ranges 0 to 1
_music_volume = 1.0;


// Checkbox toggle (for some global setting)
global.toggle_tutorials = true; 

// UI Positions
_menu_x = display_get_width() / 2 - 150;
_menu_y = display_get_height() / 2 - 200;
_menu_width = 300;
_menu_height = 250;
_spacing = 40; // Spacing between elements

// Button states
_hover_apply = false;
_hover_quit = false;
_hover_resolution = false;

// Dragging states for sliders
_dragging_sound = false;
_dragging_music = false;

image_index	= 0;
image_speed = 0;

_mx = device_mouse_x_to_gui(0);
_my = device_mouse_y_to_gui(0);

// Load settings from the file (if it exists)
if (file_exists("game_options.txt")) {
    _file = file_text_open_read("game_options.txt");

    _res_index = file_text_read_real(_file); // Read the resolution index
    _sound_volume = file_text_read_real(_file); // Read the sound volume
    _music_volume = file_text_read_real(_file); // Read the music volume
    global.toggle_tutorials = file_text_read_string(_file) == "true"; // Read the tutorials toggle

    file_text_close(_file); // Close the file after reading
}

 window_set_size(_resolutions[_res_index][0], _resolutions[_res_index][1]);