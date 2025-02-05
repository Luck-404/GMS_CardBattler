if (mouse_x < 1135 && mouse_x > 1114 && mouse_y < 308 && mouse_y > 289){
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