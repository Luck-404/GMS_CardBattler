//
//
// STEP: OBJ_GUI_PARTY_LEFT_ARROW | HANDLE CLICKING ADN DESTROY ON GUI EXIT
//
//

#region DESTROY SELF ON GUI PANE DESTRUCTION
if (!instance_exists(obj_gui_party_pane)){
	instance_destroy();
}
#endregion

#region HOVER LOGIC AND CLICING
if (position_meeting(mouse_x,mouse_y,self)){
	image_index = 1;	
	if (mouse_check_button_pressed(mb_left) && _flag_clicked == false){
		_cooldown = 10;
		_flag_clicked = true;
		if (ds_list_find_value(global.player_party,_ref_gui_pane._pos-1) != undefined){
			_ref_gui_pane._pos--;	
			_ref_gui_pane._unit_selected = ds_list_find_value(global.player_party,_ref_gui_pane._pos);
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