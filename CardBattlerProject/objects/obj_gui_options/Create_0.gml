//////////////////////////////////////////////////////////////////////
//						OBJ_GUI_OPTIONS CREATE						//
//																	//
// > ESTABLISH VARIABLES											//
//////////////////////////////////////////////////////////////////////
draw_set_font(fnt_fanwood_sm);

// Resolution options
_resolutions = [
	[720, 480],
    [1280, 720], 
    [1600, 900], 
    [1920, 1080]
];

// UI Positions
_menu_x = window_get_width() / 2 - (240*global.ui_scalar);
_menu_y = window_get_height() / 2 - (150*global.ui_scalar);
_menu_width = 300*global.ui_scalar;
_menu_height = 250*global.ui_scalar;
_spacing = 40*global.ui_scalar; // Spacing between elements

// Button states
_hover_apply = false;
_hover_quit = false;
_hover_resolution = false;
_hover_forfeit = false;
_hover_checkbox = false;
_hover_reset = false;

// Dragging states for sliders
_dragging_sound = false;
_dragging_music = false;

image_index	= 0;
image_speed = 0;

_mx = mouse_x;
_my = mouse_y;
