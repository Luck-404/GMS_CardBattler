//===============================================================================//
//
// STEP: OBJ_GUI_RANCH_LEFT_ARROW
// FUNCTION: Handles left page navigation and destroys itself when the
//           ranch GUI is closed.
//
//===============================================================================//

//
// DESTROY WITH GUI
//
#region DESTROY
if (!instance_exists(obj_gui_ranch_pane)){
	instance_destroy();
}
#endregion

//
// HOVER / CLICK
//
#region HOVER
if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),self)){

	image_index = 1;

	if (mouse_check_button_pressed(mb_left) && !_flag_clicked){
		audio_play_sound(snd_gui_press,0,false);
		_flag_clicked = true;
		_val_cooldown = 10;

		if (_ref_gui_pane._val_ranch_page > 0){
			_ref_gui_pane._val_ranch_page--;
		}
	}
}
else{
	image_index = 0;
}
#endregion

//
// CLICK COOLDOWN
//
#region COOLDOWN
if (_flag_clicked){

	if (_val_cooldown > 0){
		_val_cooldown--;
	}
	else{
		_val_cooldown = 0;
		_flag_clicked = false;
	}
}
#endregion