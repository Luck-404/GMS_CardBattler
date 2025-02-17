if (device_mouse_x_to_gui(0) < 1135 && device_mouse_x_to_gui(0) > 1114 && device_mouse_y_to_gui(0) < 308 && device_mouse_y_to_gui(0) > 289){
	image_index = 1;
	if (mouse_check_button(mb_left)){
		image_index = 2;
	}
	if (mouse_check_button_released(mb_left)){
		global.flag_gui_open = false;
		instance_destroy();
	}
} else {
	image_index = 0;
}