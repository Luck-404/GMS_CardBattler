//===============================================================================//
//
// SCRIPT: SCR_GUI_DRAW_HOVER_TOOLTIP
// FUNCTION: Draws the currently registered shared hover tooltip.
//           Uses the same formatting as the Cheats Menu tooltip.
//
//===============================================================================//

function scr_gui_draw_hover_tooltip(){

	//================//
	//VALIDATE TOOLTIP//
	//================//
	if (
		!variable_global_exists("flag_gui_hover_tooltip") ||
		!global.flag_gui_hover_tooltip
	){
		return false;
	}

	if (
		global.str_gui_hover_tooltip_title == ""
	){
		return false;
	}

	//================//
	//CHEATS GUARD//
	//================//
	if (scr_gui_check_cheats_active()){
		return false;
	}

	var _str_title =
		global.str_gui_hover_tooltip_title;

	var _str_body =
		global.str_gui_hover_tooltip_body;

	var _flag_has_body =
		(_str_body != "");

	//================//
	//MOUSE//
	//================//
	var _mx =
		device_mouse_x_to_gui(0);

	var _my =
		device_mouse_y_to_gui(0);

	//================//
	//GUI SIZE//
	//================//
	var _val_gui_w =
		display_get_gui_width();

	var _val_gui_h =
		display_get_gui_height();

	//================//
	//FONT//
	//================//
	draw_set_font(
		fnt_gui_party_small
	);

	//================//
	//PANEL WIDTH//
	//================//
	var _val_pad = 10;

	var _val_panel_w = 0;

	if (_flag_has_body){

		_val_panel_w =
			min(
				420,
				_val_gui_w - 24
			);
	}
	else{

		_val_panel_w =
			min(
				max(
					80,
					string_width(_str_title) +
					(_val_pad * 2)
				),
				_val_gui_w - 24
			);
	}

	var _val_body_w =
		_val_panel_w -
		(_val_pad * 2);

	//================//
	//HEIGHT//
	//================//
	var _val_title_h =
		string_height(_str_title);

	var _val_body_h = 0;

	if (_flag_has_body){

		_val_body_h =
			string_height_ext(
				_str_body,
				4,
				_val_body_w
			);
	}

	var _val_panel_h =
		_val_pad +
		_val_title_h +
		_val_pad;

	if (_flag_has_body){

		_val_panel_h +=
			7 +
			_val_body_h;
	}

	//================//
	//POSITION//
	//================//
	var _val_x =
		_mx + 18;

	var _val_y =
		_my + 18;

	//----------------//
	//RIGHT EDGE//
	//----------------//
	if (
		_val_x +
		_val_panel_w >
		_val_gui_w - 8
	){

		_val_x =
			_mx -
			_val_panel_w -
			18;
	}

	//----------------//
	//BOTTOM EDGE//
	//----------------//
	if (
		_val_y +
		_val_panel_h >
		_val_gui_h - 8
	){

		_val_y =
			_my -
			_val_panel_h -
			18;
	}

	//----------------//
	//CLAMP//
	//----------------//
	_val_x =
		clamp(
			_val_x,
			8,
			_val_gui_w -
			_val_panel_w -
			8
		);

	_val_y =
		clamp(
			_val_y,
			8,
			_val_gui_h -
			_val_panel_h -
			8
		);

	//================//
	//PANEL//
	//================//
	draw_set_alpha(0.96);
	draw_set_colour(c_black);

	draw_rectangle(
		_val_x,
		_val_y,
		_val_x + _val_panel_w,
		_val_y + _val_panel_h,
		false
	);

	draw_set_alpha(1);
	draw_set_colour(c_white);

	draw_rectangle(
		_val_x,
		_val_y,
		_val_x + _val_panel_w,
		_val_y + _val_panel_h,
		true
	);

	//================//
	//TITLE//
	//================//
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	draw_set_colour(c_yellow);

	draw_text(
		_val_x + _val_pad,
		_val_y + _val_pad,
		_str_title
	);

	//================//
	//BODY//
	//================//
	if (_flag_has_body){

		draw_set_colour(c_white);

		draw_text_ext(
			_val_x + _val_pad,
			_val_y +
			_val_pad +
			_val_title_h +
			7,
			_str_body,
			4,
			_val_body_w
		);
	}

	//================//
	//RESET//
	//================//
	draw_set_alpha(1);
	draw_set_colour(c_white);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	return true;
}