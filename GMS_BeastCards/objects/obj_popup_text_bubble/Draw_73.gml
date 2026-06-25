//===============================================================================//
//
// DRAW GUI: OBJ_POPUP_TEXT_BUBBLE
// FUNCTION: Draws a padded text bubble.
//           Counts down lifespan and destroys itself when expired.
//           Destroys itself early if player moves too far away.
//
//===============================================================================//

//----------------//
//TEXT BUBBLE DRAW//
//----------------//
if (_str_text != "DEFAULT"){
	draw_set_font(fnt_small_gui);

	var _val_text_w = string_width(_str_text);
	var _val_text_h = string_height(_str_text);

	var _val_left = x - (_val_text_w / 2) - _val_pad;
	var _val_right = x + (_val_text_w / 2) + _val_pad;
	var _val_top = y - _val_pad;
	var _val_bottom = y + _val_text_h + _val_pad;

	draw_set_colour(c_white);
	draw_rectangle(_val_left,_val_top,_val_right,_val_bottom,false);

	draw_set_colour(c_black);
	draw_text(x - (_val_text_w / 2),y,_str_text);
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

//------------//
//DISTANCE KILL//
//------------//
if (distance_to_object(obj_player) > 256){
	instance_destroy();
}