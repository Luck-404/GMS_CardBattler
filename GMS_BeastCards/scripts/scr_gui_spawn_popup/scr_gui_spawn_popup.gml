//===============================================================================//
//
// SCRIPT: SCR_GUI_SPAWN_POPUP
// FUNCTION: Creates a standard GUI popup.
//           Assigns popup type, text, icon, and color.
//           Displays the popup at the specified GUI position.
//
// ARGUMENTS: _str_type is the popup display type. _str_text is popup text.
//            _spr_icon is the icon sprite. _c_popup is the popup color.
//            _val_x and _val_y are the GUI position.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_gui_spawn_popup(_str_type,_str_text,_spr_icon,_c_popup,_val_x,_val_y){

	//================//
	//CREATE POPUP//
	//================//
	var _ref_popup = instance_create_layer(_val_x,_val_y,"ily_fx",obj_gui_popup);

	//================//
	//SET POPUP DATA//
	//================//
	_ref_popup._str_type = _str_type;
	_ref_popup._str_text = _str_text;
	_ref_popup._spr_icon = _spr_icon;
	_ref_popup._c_popup = _c_popup;
}