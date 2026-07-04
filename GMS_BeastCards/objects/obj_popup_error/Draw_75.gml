//===============================================================================//
//
// DRAW GUI: OBJ_POPUP_ERROR
// FUNCTION: Draws a centered error message.
//           Counts down its lifespan.
//           Destroys itself when its timer expires.
//
//===============================================================================//

//----//
//TEXT//
//----//
if (_str_text != "DEFAULT"){
	draw_set_colour(c_red);
	draw_set_font(fnt_medium_gui);
	draw_text(room_width / 2 - (string_width(_str_text) / 2),room_height / 2,_str_text);
}

//---------//
//LIFESPAN//
//---------//
if (_ct_life > 0){
	_ct_life--;

	if (_ct_life <= 0){
		instance_destroy();
	}
}