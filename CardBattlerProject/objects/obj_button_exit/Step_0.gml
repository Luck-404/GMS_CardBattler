if (position_meeting(mouse_x,mouse_y,obj_button_exit)){
	 _selected = true;
	 if (mouse_check_button_pressed(mb_left)){
		game_end();
	 }
} else {
	_selected = false;
}