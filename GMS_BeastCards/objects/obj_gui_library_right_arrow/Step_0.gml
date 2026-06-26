//===============================================================================//
//
// STEP: OBJ_GUI_LIBRARY_RIGHT_ARROW
// FUNCTION: Handles page navigation to the next library page.
// Destroys itself when the library pane closes.
// Updates click cooldown and hover highlighting.
//
//===============================================================================//

//
// DESTROY SELF
//
#region DESTROY SELF
if (!instance_exists(obj_gui_library_pane)){
	instance_destroy();
	exit;
}
#endregion

//
// HOVER AND CLICK
//
#region HOVER AND CLICK
if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),self)){
	image_index = 1;

	if (mouse_check_button_pressed(mb_left) && !_flag_clicked){
		_flag_clicked = true;
		_val_cooldown = 10;

		var _ct_total_pages = max(1,ceil(ds_list_size(global.list_player_library) / _ref_gui_pane._ct_library_per_page));

		if (_ref_gui_pane._val_library_page < _ct_total_pages - 1){
			_ref_gui_pane._val_library_page++;
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
#region CLICK COOLDOWN
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