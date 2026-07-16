//===============================================================================//
//
// STEP: OBJ_GUI_PARTY_LEFT_ARROW
// FUNCTION: Handles left navigation through the party.
//
//===============================================================================//

//
// DESTROY WITH GUI
//
#region DESTROY
if (!instance_exists(obj_gui_party_pane)){
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
		audio_play_sound(snd_gui_press,0,false);
		_flag_clicked = true;
		_val_cooldown = 10;

		if (ds_list_find_value(global.list_player_party,_ref_gui_pane._val_pos - 1) != undefined){

			_ref_gui_pane._val_pos--;
			_ref_gui_pane._stct_unit_selected = ds_list_find_value(global.list_player_party,_ref_gui_pane._val_pos);
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