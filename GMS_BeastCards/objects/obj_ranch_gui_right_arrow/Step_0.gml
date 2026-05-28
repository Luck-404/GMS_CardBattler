//
//
// STEP: OBJ_GUI_RANCH_RIGHT_ARROW | HANDLE CLICKING ADN DESTROY ON GUI EXIT
//
//
#region DESTROY SELF ON GUI PANE DESTRUCTION
if (!instance_exists(obj_ranch_gui_pane)){
	instance_destroy();
}
#endregion

#region HOVER LOGIC AND CLICING
if (position_meeting(mouse_x,mouse_y,self)){
	//HIGHLIGHT
	image_index = 1;	
	
	//LEFT CLICK
	if (mouse_check_button_pressed(mb_left) && _flag_clicked == false){
		_cooldown = 10;
		_flag_clicked = true;
		
		//ATTEMPT TO ITERATE TO NEXT PAGE
		var _total_pages = ceil(ds_list_size(global.player_ranch) / _ref_gui_pane._ranch_per_page);

		if (_ref_gui_pane._ranch_page < _total_pages - 1)
		{
		    _ref_gui_pane._ranch_page++;
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