//////////////////////////////////////////////////////////////////////
//					OBJ_BUTTON_EXIT STEP							//
//																	//
// > HOVERING OVER THE BUTTON WILL HIGHLIGHT IT, CLOSE GAME			//
//	 IF CLICKED														//
//////////////////////////////////////////////////////////////////////
//BUTTON DOES NOT FUNCTION IF THE GUI IS NOT OPEN
if (global.flag_gui_open == false){
	//CHECK MOUSE POSITION
	if (position_meeting(mouse_x,mouse_y,obj_button_exit)){
	 _flag_selected = true;
		 //CLICK TO KILL GAME
		 if (mouse_check_button_pressed(mb_left)){
			game_end();
		 }
	}
	else {
		_flag_selected = false;
	}
}