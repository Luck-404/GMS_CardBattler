//===============================================================================//
//
// STEP: OBJ_GUI_SCROLLING_TEXTBOX
// FUNCTION: Reveals textbox characters over time.
//           The first left click completes the text immediately.
//           A subsequent left click closes the textbox and returns control
//           to the parent GUI.
//
//===============================================================================//

//================//
//TEXT REVEAL//
//================//
if (_it_char < string_length(_str_text)){

	_it_char += _ct_text_speed;
	_it_char = min(_it_char,string_length(_str_text));
}

_str_visible_text = string_copy(_str_text,1,_it_char);

//================//
//INPUT DELAY//
//================//
if (_ct_input_delay > 0){
	_ct_input_delay--;
	exit;
}

//================//
//CLICK INPUT//
//================//
if (mouse_check_button_pressed(mb_left)){

	audio_play_sound(snd_gui_press,0,false);

	//----------------//
	//COMPLETE TEXT//
	//----------------//
	if (_it_char < string_length(_str_text)){

		_it_char = string_length(_str_text);
		_str_visible_text = _str_text;

		return;
	}

	//----------------//
	//RETURN CONTROL//
	//----------------//
	if (instance_exists(_ref_parent_gui)){
		_ref_parent_gui._flag_prompt_active = false;
		_ref_parent_gui.hscr_gui_inventory_start_input_lockout();
	}

	instance_destroy();
}