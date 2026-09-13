//===============================================================================//
//
// STEP: OBJ_GUI_RANCH_LEFT_ARROW
// FUNCTION: Handles left page navigation through the Ranch GUI.
//           Destroys itself when the Ranch GUI pane no longer exists.
//
//===============================================================================//

//==================//
//VALIDATE GUI PANE//
//==================//
if (!instance_exists(_ref_gui_pane)){
	instance_destroy();
	exit;
}

//================//
//HANDLE HOVER//
//================//
if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),self)){

	image_index = 1;

	//------------------//
	//HANDLE LEFT CLICK//
	//------------------//
	if (mouse_check_button_pressed(mb_left) && !_flag_clicked){

		audio_play_sound(snd_gui_press,0,false);

		_flag_clicked = true;
		_ct_cooldown = 10;

		//----------------//
		//NAVIGATE LEFT//
		//----------------//
		if (_ref_gui_pane._val_ranch_page > 0){
			_ref_gui_pane._val_ranch_page--;
		}
	}
}
else{
	image_index = 0;
}

//================//
//CLICK COOLDOWN//
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