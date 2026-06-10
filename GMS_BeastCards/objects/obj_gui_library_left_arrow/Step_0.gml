//
//
// STEP: OBJ_library_GUI_LEFT_ARROW | HANDLE CLICKING ADN DESTROY ON GUI EXIT
//
//

#region DESTROY SELF ON GUI PANE DESTRUCTION
if (!instance_exists(obj_gui_library_pane)){
	instance_destroy();
}
#endregion

#region HOVER LOGIC AND CLICING
if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),self)){
	//HIGHLIGHT
	image_index = 1;	
	
	//LEFT CLICK
	if (mouse_check_button_pressed(mb_left) && _flag_clicked == false){
		_cooldown = 10;
		_flag_clicked = true;
		
		//ATTEMPT TO ITERATE TO PREVIOUS PAGE
		if (_ref_gui_pane._library_page > 0)
		{
		    _ref_gui_pane._library_page--;
		}
	}
} else {
	image_index = 0;	
}
#endregion

#region CLICK COOLDOWN
if (_flag_clicked == true){
	if (_cooldown > 0){
		_cooldown--;	
	} else {
		_cooldown = 0;
		_flag_clicked = false;
	}
}
#endregion