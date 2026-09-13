//===============================================================================//
//
// SCRIPT: SCR_GUI_SPAWN_POPUP_TRIGGER_BANNER
// FUNCTION: Creates a trigger popup banner.
//           Assigns the supplied trigger text.
//           Positions the banner against the lower-right side of the GUI.
//
// ARGUMENTS: _str_text is the trigger text displayed by the banner.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_gui_spawn_popup_trigger_banner(_str_text){

	//================//
	//CREATE BANNER//
	//================//
	var _val_gui_width = display_get_gui_width();
	var _val_gui_height = display_get_gui_height();

	var _ref_banner = instance_create_layer(
		_val_gui_width,
		_val_gui_height - 75,
		"ily_fx",
		obj_gui_popup_trigger_banner
	);

	//================//
	//SET BANNER TEXT//
	//================//
	_ref_banner._str_text = _str_text;
}