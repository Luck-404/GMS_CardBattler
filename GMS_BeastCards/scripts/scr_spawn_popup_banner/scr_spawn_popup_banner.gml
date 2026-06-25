//===============================================================================//
//
// SCRIPT: SCR_SPAWN_POPUP_BANNER
// FUNCTION: Creates a popup banner.
//           Assigns the banner display text.
//           Displays the banner near the top of the screen.
//
//===============================================================================//
function scr_spawn_popup_banner(_str_text){
	var _ref_banner = instance_create_layer(room_width / 2,room_height / 4,"ily_fx",obj_popup_banner);
	_ref_banner._str_text = _str_text;
}