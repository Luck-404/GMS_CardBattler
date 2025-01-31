if (global.gui_open == false){
	if (position_meeting(mouse_x,mouse_y,obj_button_options)){
		 _selected = true;
		 if (mouse_check_button_pressed(mb_left)){
			global.gui_open = true;
			instance_create_layer(display_get_gui_width()/2,display_get_gui_height()/2,"GUI",obj_gui_options);
		 }
	} else {
		_selected = false;
	}
}