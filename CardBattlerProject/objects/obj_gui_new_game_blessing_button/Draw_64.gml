//////////////////////////////////////////////////////////////////////
//				OBJ_GUI_MNEW_GAME_BLESSING_BUTTON CREATE			//
//																	//
// > WHEN CLICKED (HANDLED IN NEW GAME OBJ), SPAWN CONFIRM BUTTON	//
//////////////////////////////////////////////////////////////////////
draw_self(); //BUTTON BG
if (_tar_sprite != undefined){ //BLESSING ICON
	draw_sprite(_tar_sprite,0,x,y);	
}


//hover and HIGHLIGHT AND RESET
if (!position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_gui_new_game_blessing_button)){
	 image_index = 0;
	 _hover = false;	 
}
//HOVER TOOLTIP
if (_hover == true){
	// TOOLTIPS
	draw_set_color(c_gray);
	draw_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0) - 30, device_mouse_x_to_gui(0) + string_width(_selection_blessing) + 10, device_mouse_y_to_gui(0), false);
	draw_set_color(c_white);
	draw_text(device_mouse_x_to_gui(0) + 5, device_mouse_y_to_gui(0) - 27, _selection_blessing);	
}



// SELECTED
if (_selected){
	//DRAW SELECTED ARROW
	draw_sprite(spr_selected_arrow, 0, x, y);
				
	//DRAW INFORMATION
	draw_set_color(c_white);
	draw_set_font(fnt_fanwood_sm);		
	var _desc = ds_map_find_value(_ref_to_blessing, "Description");	
	draw_text((room_width / 2) - 125, (room_height / 2)+120,string(_desc));	
	draw_set_color(c_black);	
}



//DESTROY WHEN NO GUI OPEN
if (!instance_exists(obj_gui_new_game)){
	instance_destroy();	
}