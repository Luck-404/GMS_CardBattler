//===============================================================================//
//
// SCRIPT: SCR_SPAWN_POPUP_ERROR
// FUNCTION: Creates an error popup.
//           Assigns the popup text and lifespan.
//           Displays the popup near the center of the screen.
//
//===============================================================================//

function scr_spawn_popup_error(_str_text,_ct_life){
	var _ref_popup = instance_create_layer(room_width / 2,room_height / 2 + 200,"ily_fx",obj_popup_error);
	_ref_popup._str_text = _str_text;
	_ref_popup._ct_life = _ct_life;
}