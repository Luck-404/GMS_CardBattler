//===============================================================================//
//
// DRAW GUI: OBJ_POPUP_TRIGGER_BANNER
// FUNCTION: Draws the trigger banner in the lower-right screen corner.
//           Wraps trigger text inside the 150x50 banner area.
//           Destroys the banner after its lifespan expires.
//
//===============================================================================//

//----//
//DRAW//
//----//
draw_sprite(spr_popup_trigger_banner,_val_image_index,x,y);

//----//
//TEXT//
//----//
if (_str_text != "DEFAULT"){

	var _val_text_x = x - 145;
	var _val_text_y = y - 20;

	var _val_text_w = 135;

	draw_set_colour(c_white);
	draw_set_font(fnt_small_party_draw);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	draw_text_ext(
		_val_text_x,
		_val_text_y,
		_str_text,
		-1,
		_val_text_w
	);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

//---------//
//LIFESPAN//
//---------//
_ct_life--;

if (_ct_life <= 0){
	instance_destroy();
}