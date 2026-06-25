//===============================================================================//
//
// SCRIPT: SCR_SPAWN_POPUP
// FUNCTION: Creates a standard popup.
//           Assigns popup type, text, icon, and color.
//           Displays the popup at the specified position.
//
//===============================================================================//

function scr_spawn_popup(_str_type,_str_text,_spr_icon,_c_popup,_val_x,_val_y){
	var _ref_popup = instance_create_layer(_val_x,_val_y,"ily_fx",obj_popup);

	_ref_popup._str_type = _str_type;
	_ref_popup._str_text = _str_text;
	_ref_popup._spr_icon = _spr_icon;
	_ref_popup._c_popup = _c_popup;
}