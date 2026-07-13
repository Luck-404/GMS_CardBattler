//===============================================================================//
//
// SCRIPT: SCR_SPAWN_POPUP_TRIGGER_BANNER
// FUNCTION: Creates a trigger popup banner.
//           Assigns the supplied trigger text.
//           Positions the banner against the lower-right side of the screen.
//
//===============================================================================//

function scr_spawn_popup_trigger_banner(_str_text){

	var _ref_banner = instance_create_layer(room_width,room_height - 75,"ily_fx",obj_popup_trigger_banner);
	_ref_banner._str_text = _str_text;
}