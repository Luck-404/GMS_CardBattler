//////////////////////////////////////////////////////////////////////
//					OBJ_BUTTON_OPTIONS STEP							//
//																	//
// > HOVERING OVER THE BUTTON WILL HIGHLIGHT IT						//
//////////////////////////////////////////////////////////////////////
//BUTTON DOES NOT FUNCTION IF THE GUI IS NOT OPEN
if (global.flag_gui_open == false){
	//CHECK MOUSE POSITION
	if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_button_options)){
		 _flag_selected = true;
	} else {
		_flag_selected = false;
	}
}