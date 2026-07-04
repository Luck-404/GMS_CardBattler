//===============================================================================//
//
// STEP: OBJ_GUI_SCROLLING_TEXTBOX
// FUNCTION: Reveals textbox characters over time.
//           First left click completes the text.
//           Second left click closes the textbox and reactivates inventory.
//
//===============================================================================//

//----------//
//TEXT PRINT//
//----------//
if (_ct_char < string_length(_str_text)){
	_ct_char += _ct_text_speed;
	_ct_char = min(_ct_char,string_length(_str_text));
}

_str_visible_text = string_copy(_str_text,1,_ct_char);

//------------//
//INPUT DELAY//
//------------//
if (_ct_input_delay > 0){
	_ct_input_delay--;
	exit;
}

//-----//
//CLICK//
//-----//
if (mouse_check_button_pressed(mb_left)){

	if (_ct_char < string_length(_str_text)){
		_ct_char = string_length(_str_text);
		_str_visible_text = _str_text;
	}
	else{
		if (instance_exists(_ref_parent_gui)){
			_ref_parent_gui._flag_prompt_active = false;
			_ref_parent_gui.hscr_start_input_lockout();
		}

		instance_destroy();
	}
}