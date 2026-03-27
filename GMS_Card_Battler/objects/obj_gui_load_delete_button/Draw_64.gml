//////////////////////////////////////////////////////////////////////
//					OBJ_GUI_LOAD_DELETE	DRAW GUI					//
//																	//
// > When pressed deletes the associated savefile					//																//
//////////////////////////////////////////////////////////////////////
draw_self();
if (!instance_exists(obj_gui_load_game)){
	instance_destroy();	
}

if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),self)){
	image_index = 1;
	// TOOLTIP
	draw_set_font(fnt_fanwood_sm);
	draw_set_color(c_gray);
	draw_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0) - 30, device_mouse_x_to_gui(0) + string_width("DELETE") + 10, device_mouse_y_to_gui(0), false);
	draw_set_color(c_white);
	draw_text(device_mouse_x_to_gui(0) + 5, device_mouse_y_to_gui(0) - 27, "DELETE");	
	
	if (mouse_check_button_pressed(mb_left) && global._clicked == false){
			//delete ref button
			instance_destroy(_ref_save_button);
			//delete file
			file_delete(string(global.save_folder + _ref_file));
			//delete self
			instance_destroy();
	}
} else {
	image_index = 0;	
}

