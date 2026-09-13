//===============================================================================//
//
// SCRIPT: SCR_GUI_SPAWN_POPUP_BANNER
// FUNCTION: Creates a popup banner.
//           Assigns the banner display text.
//           Displays the banner near the top-center of the GUI.
//
// ARGUMENTS: _str_text is the text displayed by the popup banner.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_gui_spawn_popup_banner(_str_text){

	//================//
	//CREATE BANNER//
	//================//
	var _val_gui_width = display_get_gui_width();
	var _val_gui_height = display_get_gui_height();

	var _ref_banner = instance_create_layer(
		_val_gui_width / 2,
		_val_gui_height / 4,
		"ily_fx",
		obj_gui_popup_banner
	);

	//================//
	//SET BANNER TEXT//
	//================//
	_ref_banner._str_text = _str_text;
}