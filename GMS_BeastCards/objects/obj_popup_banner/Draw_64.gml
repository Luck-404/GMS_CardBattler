//===============================================================================//
//
// DRAW GUI: OBJ_POPUP_BANNER
// FUNCTION: Draws the popup banner.
//           Animates the banner opening sequence.
//           Displays banner text and destroys itself after its lifespan.
//
//===============================================================================//

//----//
//DRAW//
//----//
draw_sprite(spr_popup_banner,_val_image_index,x,y);

//-------------//
//OPEN ANIMATION//
//-------------//
if (!_flag_opened){
	_val_image_index++;

	if (_val_image_index >= 3){
		_val_image_index = 3;
		_flag_opened = true;
	}
}

//----//
//TEXT//
//----//
if (_str_text != "DEFAULT"){
	draw_set_colour(c_black);
	draw_set_font(fnt_large_gui);
	draw_text(x - (string_width(_str_text) / 2),y,_str_text);
}

//---------//
//LIFESPAN//
//---------//
if (_ct_life <= 60){
	_ct_life++;

	if (_ct_life > 60){
		instance_destroy();
	}
}