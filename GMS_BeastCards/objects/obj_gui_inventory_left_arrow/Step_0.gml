//===============================================================================//
//
// STEP: OBJ_GUI_INVENTORY_LEFT_ARROW
// FUNCTION: Handles left inventory page navigation.
//           Highlights while hovered and respects inventory input lockout.
//           Destroys itself when its owning inventory pane closes.
//
//===============================================================================//

//================//
//DESTROY SELF//
//================//
if (!instance_exists(_ref_gui_pane)){
	instance_destroy();
	exit;
}

//================//
//INPUT LOCKOUT//
//================//
if (!_ref_gui_pane.hscr_gui_inventory_can_accept_input()){
	image_index = 0;
	exit;
}

//================//
//HOVER//
//================//
if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),self)){

	image_index = 1;

	if (mouse_check_button_pressed(mb_left) && !_flag_clicked){

		audio_play_sound(snd_gui_press,0,false);

		_ct_cooldown = 10;
		_flag_clicked = true;

		if (_ref_gui_pane._it_inventory_page > 0){
			_ref_gui_pane._it_inventory_page--;
		}
	}
}
else{
	image_index = 0;
}

//================//
//COOLDOWN//
//================//
if (_flag_clicked){

	if (_ct_cooldown > 0){
		_ct_cooldown--;
	}
	else{
		_ct_cooldown = 0;
		_flag_clicked = false;
	}
}