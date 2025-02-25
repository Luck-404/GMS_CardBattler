//////////////////////////////////////////////////////////////////////
//				OBJ_GUI_MNEW_GAME_PATRON_BUTTON DRAW GUI			//
//																	//
// > HANDLE VISUAL UPDATES, HANDLE CLICKNIG AND SPAWNING BLESSINGS	//
//////////////////////////////////////////////////////////////////////
draw_self(); //BUTTON BG
if (_tar_sprite != undefined){ //SIGIL OF PATRON
	draw_sprite(_tar_sprite,0,x,y);	
}



//HOVER HIGHLIGHT
if (!position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),self)){
	 image_index = 0;
	 _hover = false;
}
// TOOLTIPS
if (_hover == true){
	draw_set_color(c_gray);
	draw_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0) - 30, device_mouse_x_to_gui(0) + string_width(_selection_patron) + 10, device_mouse_y_to_gui(0), false);
	draw_set_color(c_white);
	draw_text(device_mouse_x_to_gui(0) + 5, device_mouse_y_to_gui(0) - 27, _selection_patron);	
}



//IF SELECTED, DISPLAY INFO AND SPAWN BLESSINGS
if (_flag_selected == true){	
	draw_sprite(spr_selected_arrow, 0, x, y);
		
	//DRAW THE TEXT INFORMATION
	draw_set_color(c_white);
	draw_set_font(fnt_fanwood_sm);
	var _desc = ds_map_find_value(_ref_to_patron, "Description");
	var _starter =ds_map_find_value(_ref_to_patron, "Starter");
	var _cards =ds_map_find_value(_ref_to_patron, "Cards");
	//var _gear = ds_map_find_value(_ref_to_patron, "Gear");
	var _gold =ds_map_find_value(_ref_to_patron, "Bonus Gold");
	var _blessings = ds_map_find_value(_ref_to_patron, "Blessings");		
	draw_text((room_width / 2) - 125, (room_height / 2)-150,string(_desc));
	draw_text((room_width / 2) - 125, (room_height / 2)-130,string(_starter));
	draw_text((room_width / 2) - 125, (room_height / 2)-110,string(_cards));
	//draw_text((room_width / 2) - 125, (room_height / 2)-40,string(_gear));
	draw_text((room_width / 2) - 125, (room_height / 2)-90,string(_gold));
	for (var _k = 0; _k < 3; _k++){
		var _ref_blessing = ds_map_find_value(_ref_to_patron[?"Blessings"][_k],"Name");
		draw_text((room_width / 2) - 125, (room_height / 2) - 70 + (20*_k),_ref_blessing);	
	}
	draw_set_color(c_black);		
	
	//SPAWN THE BLESSINGS
	if (_spawned_blessings == false && array_length(_ref_to_patron[?"Blessings"]) != 0){
		_spawned_blessings = true;
		//spawn the blessing buttons
		for (var _j = 0; _j < 3; _j++) {
				var _blessing = _ref_to_patron[?"Blessings"][_j];
				var _blessing_sprite = ds_map_find_value(_blessing, "Sprite");
				var _blessing_name = ds_map_find_value(_blessing, "Name");
				var _new_button = instance_create_layer(obj_gui_new_game.x-80+(80*_j),obj_gui_new_game.y+90,"GUI",obj_gui_new_game_blessing_button);//close
				_new_button._selection_blessing = _blessing_name;
				_new_button._tar_sprite = _blessing_sprite;
				_new_button._ref_to_blessing = _blessing;
		}
	}
}



//DESTROY ON GUI CLOSE
if (!instance_exists(obj_gui_new_game)){
	instance_destroy();	
}