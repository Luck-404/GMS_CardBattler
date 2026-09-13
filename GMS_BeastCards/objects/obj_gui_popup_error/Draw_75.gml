//===============================================================================//
//
// DRAW GUI: OBJ_GUI_POPUP_ERROR
// FUNCTION: Draws a centered GUI error message.
//           Counts down its lifespan.
//           Destroys itself when its timer expires.
//
//===============================================================================//

//================//
//TEXT//
//================//
if (_str_text != "DEFAULT"){

	var _val_gui_width = display_get_gui_width();
	var _val_gui_height = display_get_gui_height();

	draw_set_colour(c_red);
	draw_set_font(fnt_gui_medium);
	draw_text((_val_gui_width / 2) - (string_width(_str_text) / 2),_val_gui_height / 2,_str_text);
}

//================//
//LIFESPAN//
//================//
if (_ct_life > 0){

	_ct_life--;

	if (_ct_life <= 0){
		instance_destroy();
	}
}