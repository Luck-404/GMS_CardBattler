/// Left Pressed Event (inside obj_save_menu)
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

if (position_meeting(_mx,_my,obj_gui_load_close_button)){
	obj_gui_load_close_button.image_index = 1;
	if (mouse_check_button_pressed(mb_left) && global._clicked == false){
		obj_gui_load_close_button.image_index = 2;
		global.flag_gui_open = false;
		instance_destroy(_ref_passer);
		instance_destroy();
	}
} else {
	obj_gui_load_close_button.image_index = 0;
}