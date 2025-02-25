//////////////////////////////////////////////////////////////////////
//						OBJ_GUI_OPTIONS CREATE						//
//																	//
// > ESTABLISH VARIABLES, CREATE BUTTONS							//
//////////////////////////////////////////////////////////////////////
depth = -100;
image_index	= 0;
image_speed = 0;

_mx = device_mouse_x_to_gui(0);
_my = device_mouse_y_to_gui(0);

// Resolution options
_resolutions = [
	[720, 480],
    [1280, 720], 
    [1600, 900], 
    [1920, 1080]
];



//create buttons
instance_create_layer(x+150,y-270,"GUI",obj_gui_options_close_button);//close
instance_create_layer(x-80,y-225+40,"GUI",obj_gui_options_resolution_button);//resolution
instance_create_layer(x-80,y-225+80,"GUI",obj_gui_options_sound_slider);//sound slider
instance_create_layer(x-80,y-225+120,"GUI",obj_gui_options_music_slider);//music slider
instance_create_layer(x-100,y-225+160,"GUI",obj_gui_options_tutorials_checkbox);//tutorials
instance_create_layer(x,y-225+160,"GUI",obj_gui_options_fullscreen_checkbox);//fullscreen
instance_create_layer(x-80,y-225+200,"GUI",obj_gui_options_apply_button);//apply 
instance_create_layer(x-80,y-225+240,"GUI",obj_gui_options_default_button);//reset
if (room != rm_main_menu && room != rm_encounter){
instance_create_layer(x-80,y-225+280,"GUI",obj_gui_options_savexit_button);//save and exit
}
if (room == rm_encounter){
instance_create_layer(x-80,y-225+280,"GUI",obj_gui_options_forfeit_button);//forfeit
}