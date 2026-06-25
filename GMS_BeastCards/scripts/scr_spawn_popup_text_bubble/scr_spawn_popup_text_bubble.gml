//===============================================================================//
//
// SCRIPT: SCR_SPAWN_POPUP_TEXT_BUBBLE
// FUNCTION: Creates a text bubble popup.
//           Assigns the display text.
//           Displays the bubble at the specified position.
//
//===============================================================================//

function scr_spawn_popup_text_bubble(_val_x,_val_y,_str_text){
	var _ref_bubble = instance_create_layer(_val_x,_val_y,"ily_fx",obj_popup_text_bubble);
	_ref_bubble._str_text = _str_text;
}