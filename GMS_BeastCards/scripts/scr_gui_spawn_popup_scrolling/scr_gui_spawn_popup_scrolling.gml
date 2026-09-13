//===============================================================================//
//
// SCRIPT: SCR_GUI_SPAWN_POPUP_SCROLLING
// FUNCTION: Spawns a scrolling GUI popup.
//           Assigns popup type, text, optional icon, and display color.
//
// ARGUMENTS: Popup type, text, icon, color, and spawn x/y coordinates.
// RETURNS: Reference to the created scrolling popup instance.
//
//===============================================================================//

function scr_gui_spawn_popup_scrolling(_str_type,_str_text,_spr_icon,_c_popup,_val_x,_val_y){

	//================//
	//CREATE POPUP//
	//================//
	var _ref_popup = instance_create_layer(
		_val_x,
		_val_y,
		"ily_fx",
		obj_gui_popup_scrolling
	);

	//================//
	//ASSIGN DATA//
	//================//
	_ref_popup._str_type = _str_type;
	_ref_popup._str_text = _str_text;

	_ref_popup._spr_icon = _spr_icon;
	_ref_popup._c_popup = _c_popup;

	return _ref_popup;
}