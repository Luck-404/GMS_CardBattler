//===============================================================================//
//
// STEP: OBJ_GUI_INVENTORY_LEFT_ARROW
// FUNCTION: Handles left page navigation.
//           Highlights while hovered.
//           Destroys itself when the inventory pane closes.
//
//===============================================================================//

//------------//
//DESTROY SELF//
//------------//
if (!instance_exists(obj_gui_inventory_pane)){
	instance_destroy();
}

if (instance_exists(_ref_gui_pane) && _ref_gui_pane._flag_prompt_active){
	image_index = 0;
	exit;
}

//-----//
//HOVER//
//-----//
if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),self)){
	image_index = 1;

	if (mouse_check_button_pressed(mb_left) && !_flag_clicked){
		_ct_cooldown = 10;
		_flag_clicked = true;

		if (_ref_gui_pane._ct_inventory_page > 0){
			_ref_gui_pane._ct_inventory_page--;
		}
	}
} else {
	image_index = 0;
}

//--------//
//COOLDOWN//
//--------//
if (_flag_clicked){
	if (_ct_cooldown > 0){
		_ct_cooldown--;
	} else {
		_ct_cooldown = 0;
		_flag_clicked = false;
	}
}