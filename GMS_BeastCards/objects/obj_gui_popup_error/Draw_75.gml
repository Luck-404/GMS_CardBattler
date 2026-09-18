//===============================================================================//
//
// DRAW GUI: OBJ_GUI_POPUP_ERROR
// FUNCTION: Draws a bottom-center GUI error/instruction banner.
//           Uses a dark gray background with centered red text.
//           Counts down its lifespan and destroys itself when expired.
//
//===============================================================================//

//================//
//BANNER//
//================//
if (_str_text != "DEFAULT"){

	//----------------//
	//BANNER POSITION//
	//----------------//
	var _val_gui_width = display_get_gui_width();

	var _val_banner_center_x = _val_gui_width * 0.5;
	var _val_banner_bottom = 736;

	var _val_banner_height = 40;
	var _val_banner_padding_x = 20;

	//----------------//
	//TEXT SETTINGS//
	//----------------//
	draw_set_font(fnt_gui_medium);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	var _val_text_width = string_width(_str_text);

	var _val_banner_width = max(
		220,
		_val_text_width + (_val_banner_padding_x * 2)
	);

	var _val_banner_left =
		_val_banner_center_x -
		(_val_banner_width * 0.5);

	var _val_banner_right =
		_val_banner_center_x +
		(_val_banner_width * 0.5);

	var _val_banner_top =
		_val_banner_bottom -
		_val_banner_height;

	//================//
	//BACKGROUND//
	//================//
	draw_set_colour(global.c_dk_gray);

	draw_rectangle(
		_val_banner_left,
		_val_banner_top,
		_val_banner_right,
		_val_banner_bottom,
		false
	);

	//================//
	//BORDER//
	//================//
	draw_set_colour(c_black);

	draw_rectangle(
		_val_banner_left,
		_val_banner_top,
		_val_banner_right,
		_val_banner_bottom,
		true
	);

	//================//
	//TEXT//
	//================//
	draw_set_colour(c_red);

	draw_text(
		_val_banner_center_x,
		_val_banner_top + (_val_banner_height * 0.5),
		_str_text
	);

	//----------------//
	//RESET DRAW STATE//
	//----------------//
	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
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