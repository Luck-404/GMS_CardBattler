//===============================================================================//
//
// STEP: OBJ_GUI_PARTY_LEFT_ARROW
// FUNCTION: Handles left navigation through the Party GUI.
//
//===============================================================================//

//==================//
//VALIDATE GUI PANE//
//==================//
if (!instance_exists(_ref_gui_pane)){
	instance_destroy();
	exit;
}

//================//
//HANDLE HOVER//
//================//
if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),self)){

	image_index = 1;

	//--------------------//
	//HANDLE LEFT CLICK//
	//--------------------//
	if (mouse_check_button_pressed(mb_left) && !_flag_clicked){

		audio_play_sound(snd_gui_press,0,false);

		_flag_clicked = true;
		_ct_cooldown = 10;

		//-------------------//
		//NAVIGATE LEFT//
		//-------------------//
		if (
			ds_exists(global.list_player_party,ds_type_list) &&
			_ref_gui_pane._val_pos > 0
		){
			_ref_gui_pane._val_pos--;
			_ref_gui_pane._stct_unit_selected = ds_list_find_value(global.list_player_party,_ref_gui_pane._val_pos);
		}
	}
}
else{
	image_index = 0;
}

//================//
//CLICK COOLDOWN//
//================//
if (_flag_clicked){

	if (_ct_cooldown > 0){
		_ct_cooldown--;
	}
	else{
		_ct_cooldown = 0;
		_flag_clicked = false;
	}
}