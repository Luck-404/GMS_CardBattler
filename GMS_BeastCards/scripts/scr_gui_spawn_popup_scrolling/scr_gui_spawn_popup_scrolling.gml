//===============================================================================//
//
// SCRIPT: SCR_GUI_SPAWN_POPUP_SCROLLING
// FUNCTION: Routes a scrolling temporary popup through the active printout
//           presentation mode.
//
//           RANDOM preserves the original scrolling popup behavior.
//           CLEAN routes the entry into the organized scrolling printout list.
//
// ARGUMENTS: _str_type is the popup display type.
//            _str_text is popup text.
//            _spr_icon is the icon sprite.
//            _c_popup is the popup color.
//            _val_x and _val_y are the original popup coordinates.
// RETURNS: Created or stacked popup instance.
//
//===============================================================================//

function scr_gui_spawn_popup_scrolling(_str_type,_str_text,_spr_icon,_c_popup,_val_x,_val_y){

	return scr_gui_spawn_printout(
		true,
		_str_type,
		_str_text,
		_spr_icon,
		_c_popup,
		_val_x,
		_val_y
	);
}