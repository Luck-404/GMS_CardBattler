//===============================================================================//
//
// STEP: OBJ_GUI_RANCH_RIGHT_ARROW
// FUNCTION: Handles right page navigation and destroys itself when the
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

		_flag_clicked = true;
		_val_cooldown = 10;

		var _ct_total_pages = ceil(ds_list_size(global.list_player_ranch) / _ref_gui_pane._ct_ranch_per_page);

		if (_ref_gui_pane._val_ranch_page < _ct_total_pages - 1){
			_ref_gui_pane._val_ranch_page++;
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