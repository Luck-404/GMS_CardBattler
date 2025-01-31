if (global.gui_open == false){
	if (position_meeting(mouse_x,mouse_y,obj_button_new_game)){
		 _selected = true;
		 if (mouse_check_button_pressed(mb_left)){
			global.gui_open = true;
		 }
	} else {
		_selected = false;
	}
}