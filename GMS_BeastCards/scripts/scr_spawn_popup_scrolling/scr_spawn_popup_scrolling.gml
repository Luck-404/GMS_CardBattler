//===============================================================================//
//
// SCRIPT: SCR_SPAWN_POPUP_SCROLLING
// FUNCTION: Creates a scrolling popup.
//           Assigns popup type, text, icon, and color.
//           Displays the popup at the specified position.
//
//===============================================================================//

function scr_spawn_popup_scrolling(_str_type,_str_text,_spr_icon,_c_popup,_val_x,_val_y){
	var _ref_popup = instance_create_layer(_val_x,_val_y,"ily_fx",obj_popup_scrolling);

	_ref_popup._str_type = _str_type;
	_ref_popup._str_text = _str_text;
	_ref_popup._spr_icon = _spr_icon;
	_ref_popup._c_popup = _c_popup;
}