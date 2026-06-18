//
// STEP: OBJ_library_GUI_RIGHT_ARROW | HANDLE CLICKING AND DESTROY ON GUI EXIT
//

#region DESTROY SELF ON GUI PANE DESTRUCTION
if (!instance_exists(obj_gui_inventory_pane)){
	instance_destroy();
}
#endregion

#region HOVER LOGIC AND CLICKING
if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),self)){
	
	//HIGHLIGHT
	image_index = 1;

	//LEFT CLICK
	if (mouse_check_button_pressed(mb_left) && !_flag_clicked){
		_cooldown = 10;
		_flag_clicked = true;

		var _total_pages = max(
		    1,
		    ceil(ds_list_size(global.player_inventory) / _ref_gui_pane._inventory_per_page)
		);

		if (_ref_gui_pane._inventory_page < _total_pages - 1){
			_ref_gui_pane._inventory_page++;
		}
	}
}
else {
	image_index = 0;
}
#endregion

#region CLICK COOLDOWN
if (_flag_clicked){
	if (_cooldown > 0){
		_cooldown--;
	}
	else{
		_cooldown = 0;
		_flag_clicked = false;
	}
}
#endregion