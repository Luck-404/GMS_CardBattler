//===============================================================================//
//
// SCRIPT: SCR_GUI_SPAWN_POPUP_ERROR
// FUNCTION: Creates an error popup.
//           Assigns the popup text and lifespan.
//           Displays the popup at the center of the GUI.
//
// ARGUMENTS: _str_text is the error message to display.
//            _ct_life is the popup lifespan in frames.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_gui_spawn_popup_error(_str_text,_ct_life){

	//================//
	//CREATE POPUP//
	//================//
	var _val_gui_width = display_get_gui_width();
	var _val_gui_height = display_get_gui_height();

	var _ref_popup = instance_create_layer(
		_val_gui_width / 2,
		_val_gui_height / 2,
		"ily_fx",
		obj_gui_popup_error
	);

	//================//
	//SET POPUP DATA//
	//================//
	_ref_popup._str_text = _str_text;
	_ref_popup._ct_life = _ct_life;
}