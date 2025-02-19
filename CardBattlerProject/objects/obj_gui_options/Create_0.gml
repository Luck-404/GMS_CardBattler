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

// UI Positions
_menu_x = window_get_width() / 2 - 150;
_menu_y = window_get_height() / 2 - 200;
_menu_width = 300;
_menu_height = 250;
_spacing = 40; // Spacing between elements

// Button states
_hover_apply = false;
_hover_quit = false;
_hover_resolution = false;
_hover_forfeit = false;
_hover_checkbox = false;

// Dragging states for sliders
_dragging_sound = false;
_dragging_music = false;

image_index	= 0;
image_speed = 0;

_mx = window_mouse_get_x();
_my = window_mouse_get_y();
