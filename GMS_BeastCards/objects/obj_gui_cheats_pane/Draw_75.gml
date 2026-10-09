//===============================================================================//
//
// DRAW GUI END: OBJ_GUI_CHEATS_PANE
// FUNCTION: Draws the complete developer Cheats Menu using pane-relative
//           coordinates sized for the reduced 100 px inset window.
//
//===============================================================================//

//================//
//RESET DRAW STATE//
//================//
// Reset inherited GUI draw state before drawing the Cheats pane.
draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

//================//
//RESET HOVER TOOLTIP//
//================//
// Every button may replace this while drawing. The tooltip is rendered once,
// after all controls, so the topmost/currently hovered control wins.
_str_hover_tooltip_title = "";
_str_hover_tooltip_body = "";

//================//
//LOCAL LAYOUT//
//================//
var _val_left =
	_val_content_x1;

var _val_right =
	_val_content_x2;

var _val_top =
	_val_content_y1;

var _val_bottom =
	_val_content_y2;

var _val_footer_y =
	_val_pane_y2 -
	_val_footer_h +
	7;

var _c_party_background =
	make_colour_rgb(
		18,
		32,
		58
	);

var _val_hover_mouse_x =
	device_mouse_x_to_gui(0);

var _val_hover_mouse_y =
	device_mouse_y_to_gui(0);

//===============================================================================//
// TOOL MODE
//===============================================================================//
if (_str_state == "TOOL"){

	var _mx =
		device_mouse_x_to_gui(0);

	var _my =
		device_mouse_y_to_gui(0);

	draw_set_font(
		fnt_gui_party_small
	);

	var _val_tool_w =
		string_width(
			_str_tool_label
		) + 20;

	draw_set_colour(c_black);

	draw_rectangle(
		_mx + 12,
		_my + 12,
		_mx + 12 + _val_tool_w,
		_my + 40,
		false
	);

	draw_set_colour(c_white);

	draw_rectangle(
		_mx + 12,
		_my + 12,
		_mx + 12 + _val_tool_w,
		_my + 40,
		true
	);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	draw_text(
		_mx + 20,
		_my + 19,
		_str_tool_label
	);

	draw_set_colour(c_ltgray);

	var _str_tool_input =
		(
			_str_tool == "SWAP_BEASTS" ||
			_str_tool == "SIMULATED_CAST"
		)
		? "LMB: SELECT   RMB: RETURN"
		: "LMB: APPLY   RMB: RETURN";

	draw_text(
		_mx + 20,
		_my + 45,
		_str_tool_input
	);
	draw_set_colour(c_white);

	exit;
}

//===============================================================================//
// PANE
//===============================================================================//

//================//
//BACKGROUND//
//================//
draw_set_colour(c_black);

draw_rectangle(
	_val_pane_x1,
	_val_pane_y1,
	_val_pane_x2,
	_val_pane_y2,
	false
);

draw_set_colour(c_white);

draw_rectangle(
	_val_pane_x1,
	_val_pane_y1,
	_val_pane_x2,
	_val_pane_y2,
	true
);

//================//
//HEADER//
//================//
draw_set_font(fnt_gui_medium);
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(
	_val_pane_x1 +
	(_val_pane_w * 0.5),
	_val_pane_y1 +
	(_val_header_h * 0.5),
	"CHEATS - " +
	_str_mode
);

//===============================================================================//
// PASSWORD
//===============================================================================//
if (_flag_password_entry){

	var _str_hidden = "";

	for (
		var _i = 0;
		_i < string_length(
			_str_password
		);
		_i++
	){
		_str_hidden += "*";
	}

	var _val_password_x =
		_val_pane_x1 +
		(_val_pane_w * 0.5);

	var _val_password_y =
		_val_pane_y1 +
		(_val_pane_h * 0.5);

	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_set_font(fnt_gui_medium);
	draw_set_colour(c_white);

	draw_text(
		_val_password_x,
		_val_password_y - 55,
		"TESTER PASSWORD"
	);

	draw_set_colour(
		global.c_dk_gray
	);

	draw_rectangle(
		_val_password_x - 145,
		_val_password_y - 18,
		_val_password_x + 145,
		_val_password_y + 20,
		false
	);

	draw_set_colour(c_white);

	draw_rectangle(
		_val_password_x - 145,
		_val_password_y - 18,
		_val_password_x + 145,
		_val_password_y + 20,
		true
	);

	draw_text(
		_val_password_x,
		_val_password_y + 1,
		_str_hidden
	);

	draw_set_font(
		fnt_gui_party_small
	);

	draw_text(
		_val_password_x,
		_val_password_y + 48,
		"ENTER TO CONFIRM"
	);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	exit;
}

//===============================================================================//
// TABS
//===============================================================================//

var _ct_tabs =
	array_length(
		_arr_tabs
	);

var _val_tab_w =
	_val_pane_w /
	_ct_tabs;

var _val_tab_mouse_x =
	device_mouse_x_to_gui(0);

var _val_tab_mouse_y =
	device_mouse_y_to_gui(0);

for (
	var _t = 0;
	_t < _ct_tabs;
	_t++
){

	var _x1 =
		_val_pane_x1 +
		(_t * _val_tab_w);

	var _x2 =
		_x1 +
		_val_tab_w;

	var _flag_tab_hover =
		hscr_cheats_point_in_rect(
			_val_tab_mouse_x,
			_val_tab_mouse_y,
			_x1,
			_val_tab_y1,
			_x2,
			_val_tab_y2
		);

	if (
		_flag_tab_hover &&
		_t != _it_tab &&
		hscr_cheats_take_left_click()
	){

		hscr_cheats_change_tab(
			_t - _it_tab
		);
	}

	//================//
	//TAB CTRL INFO//
	//================//
	if (_flag_tab_hover){

		hscr_cheats_set_hover_tooltip(
			_arr_tabs[_t],
			hscr_cheats_get_tab_tooltip(
				_arr_tabs[_t]
			)
		);
	}

	if (_t == _it_tab){
		draw_set_colour(c_gray);
	}
	else if (_flag_tab_hover){
		draw_set_colour(c_ltgray);
	}
	else{
		draw_set_colour(global.c_dk_gray);
	}

	draw_rectangle(
		_x1,
		_val_tab_y1,
		_x2,
		_val_tab_y2,
		false
	);

	draw_set_colour(c_white);

	draw_rectangle(
		_x1,
		_val_tab_y1,
		_x2,
		_val_tab_y2,
		true
	);

	draw_set_font(fnt_gui_party_small);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_set_colour(
		(_t == _it_tab)
		? c_white
		: c_black
	);

	draw_text(
		(_x1 + _x2) * 0.5,
		(_val_tab_y1 + _val_tab_y2) * 0.5,
		_arr_tabs[_t]
	);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
//===============================================================================//
// OVERWORLD
//===============================================================================//
if (_str_mode == "OVERWORLD"){

//===============================================================================//
// BEASTS
//===============================================================================//
if (_it_tab == 0){

	var _list_beasts =
		global.list_logbook_beasts;

	var _ct_catalog =
		ds_list_size(
			_list_beasts
		);

	var _it_max_page =
		hscr_cheats_get_max_page(
			_ct_catalog,
			_ct_rows_per_page
		);

	_it_page =
		clamp(
			_it_page,
			0,
			_it_max_page
		);

//================//
//COLUMN LAYOUT//
//================//
	var _val_gap = 18;

	var _val_catalog_w =
		floor(
			_val_content_w * 0.56
		);

	var _val_catalog_x1 =
		_val_left;

	var _val_catalog_x2 =
		_val_catalog_x1 +
		_val_catalog_w;

	var _val_party_x1 =
		_val_catalog_x2 +
		_val_gap;

	var _val_party_x2 =
		_val_right;

//================//
//HEADERS//
//================//
	draw_set_font(
		fnt_gui_party_small
	);

	draw_set_colour(c_white);
	draw_set_halign(fa_left);

	draw_text(
		_val_catalog_x1,
		_val_top,
		"BEAST CATALOG"
	);

	draw_text(
		_val_party_x1,
		_val_top,
		"CURRENT PARTY"
	);

//================//
//BEAST CATALOG//
//================//
	for (
		var _r = 0;
		_r < _ct_rows_per_page;
		_r++
	){

		var _index =
			(_it_page *
			_ct_rows_per_page) +
			_r;

		if (_index >= _ct_catalog){
			break;
		}

		var _entry =
			ds_list_find_value(
				_list_beasts,
				_index
			);

		if (!is_struct(_entry)){
			continue;
		}

		var _y =
			_val_top +
			26 +
			(_r * _val_row_step);

		var _str_beast_color =
			hscr_cheats_get_entry_color(
				_entry
			);

		var _c_beast =
			hscr_cheats_get_color(
				_str_beast_color
			);

//----------------//
//COLORED BEAST PANEL//
//----------------//
draw_set_colour(
	_c_beast
);

draw_rectangle(
	_val_catalog_x1,
	_y,
	_val_catalog_x2,
	_y + _val_row_h,
	false
);

draw_set_colour(c_white);

draw_rectangle(
	_val_catalog_x1,
	_y,
	_val_catalog_x2,
	_y + _val_row_h,
	true
);

//----------------//
//BEAST CTRL INFO//
//----------------//
		if (
			hscr_cheats_point_in_rect(
				_val_hover_mouse_x,
				_val_hover_mouse_y,
				_val_catalog_x1,
				_y,
				_val_catalog_x2,
				_y + _val_row_h
			)
		){
			var _str_beast_tooltip = "BASE STATS UNAVAILABLE";
			if (variable_struct_exists(_entry,"_stct_beast_info") && is_struct(_entry._stct_beast_info)){
				var _stct_beast_tooltip = _entry._stct_beast_info;
				_str_beast_tooltip =
					"BASE STATS" +
					"\nHP: " + string(_stct_beast_tooltip._val_beast_hp_stat) +
					" | CON: " + string(_stct_beast_tooltip._val_beast_con_stat) +
					" | PPOW: " + string(_stct_beast_tooltip._val_beast_ppow_stat) +
					" | MPOW: " + string(_stct_beast_tooltip._val_beast_mpow_stat) +
					"\nPDEF: " + string(_stct_beast_tooltip._val_beast_pdef_stat) +
					" | MDEF: " + string(_stct_beast_tooltip._val_beast_mdef_stat) +
					" | SPEED: " + string(_stct_beast_tooltip._val_beast_speed_stat) +
					"\nCRIT: " + string(_stct_beast_tooltip._val_beast_crit_stat) +
					" | CRIT DMG: " + string(_stct_beast_tooltip._val_beast_crit_dmg_stat) +
					" | DODGE: " + string(_stct_beast_tooltip._val_beast_dod_stat) +
					" | MIN: " + string(_stct_beast_tooltip._val_beast_min_stat);
			}
			hscr_cheats_set_hover_tooltip(_entry._str_beast_name,_str_beast_tooltip);
		}

//----------------//
//BUTTON LAYOUT//
//----------------//
		var _val_button_gap = 5;

		var _val_button_w =
			min(
				105,
				floor(
					_val_catalog_w *
					0.25
				)
			);

		var _val_ranch_x2 =
			_val_catalog_x2 - 4;

		var _val_ranch_x1 =
			_val_ranch_x2 -
			_val_button_w;

		var _val_party_button_x2 =
			_val_ranch_x1 -
			_val_button_gap;

		var _val_party_button_x1 =
			_val_party_button_x2 -
			_val_button_w;

//----------------//
//NAME//
//----------------//
		draw_set_colour(c_black);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);

		draw_text(
			_val_catalog_x1 + 8,
			_y +
			(_val_row_h * 0.5),
			_entry._str_beast_name
		);

		draw_set_valign(fa_top);

//----------------//
//ADD PARTY//
//----------------//
		if (
			hscr_cheats_button(
				"PARTY",
				_val_party_button_x1,
				_y + 3,
				_val_party_button_x2,
				_y + _val_row_h - 3
			)
		){

			hscr_cheats_add_beast(
				_entry._str_beast_id,
				"PARTY"
			);
		}

//----------------//
//ADD RANCH//
//----------------//
		if (
			hscr_cheats_button(
				"RANCH",
				_val_ranch_x1,
				_y + 3,
				_val_ranch_x2,
				_y + _val_row_h - 3
			)
		){

			hscr_cheats_add_beast(
				_entry._str_beast_id,
				"RANCH"
			);
		}
	}

//================//
//CURRENT PARTY//
//================//
	if (
		ds_exists(
			global.list_player_party,
			ds_type_list
		)
	){

		var _ct_party =
			ds_list_size(
				global.list_player_party
			);

		var _val_party_panel_h =
			70;

		var _val_party_panel_gap =
			7;

		for (
			var _p = 0;
			_p < _ct_party;
			_p++
		){

			var _beast =
				ds_list_find_value(
					global.list_player_party,
					_p
				);

			if (!is_struct(_beast)){
				continue;
			}

			var _py =
				_val_top +
				26 +
				(
					_p *
					(
						_val_party_panel_h +
						_val_party_panel_gap
					)
				);

			if (
				_py +
				_val_party_panel_h >
				_val_bottom
			){
				break;
			}

			var _str_party_color =
				"UNCOLORED";

			if (
				variable_struct_exists(
					_beast,
					"_arr_beast_colors"
				) &&
				is_array(
					_beast._arr_beast_colors
				) &&
				array_length(
					_beast._arr_beast_colors
				) > 0 &&
				_beast._arr_beast_colors[0]
					!= undefined
			){
				_str_party_color =
					_beast._arr_beast_colors[0];
			}

			var _c_party_border =
				hscr_cheats_get_color(
					_str_party_color
				);

//----------------//
//PANEL//
//----------------//
			draw_set_colour(
				_c_party_background
			);

			draw_rectangle(
				_val_party_x1,
				_py,
				_val_party_x2,
				_py +
				_val_party_panel_h,
				false
			);

			draw_set_colour(
				_c_party_border
			);

			draw_rectangle(
				_val_party_x1,
				_py,
				_val_party_x2,
				_py +
				_val_party_panel_h,
				true
			);

//----------------//
//PARTY CTRL INFO//
//----------------//
			if (hscr_cheats_point_in_rect(_val_hover_mouse_x,_val_hover_mouse_y,_val_party_x1,_py,_val_party_x2,_py + _val_party_panel_h)){
				var _str_party_tooltip =
					"CURRENT STATS" +
					"\nLEVEL: " + string(_beast._val_beast_level) +
					" | HP: " + string(_beast._val_beast_hp_cur) + "/" + string(_beast._val_beast_hp_max) +
					"\nHP STAT: " + string(_beast._val_beast_hp_stat) +
					" | CON: " + string(_beast._val_beast_con_stat) +
					" | PPOW: " + string(_beast._val_beast_ppow_stat) +
					" | MPOW: " + string(_beast._val_beast_mpow_stat) +
					"\nPDEF: " + string(_beast._val_beast_pdef_stat) +
					" | MDEF: " + string(_beast._val_beast_mdef_stat) +
					" | SPEED: " + string(_beast._val_beast_speed_stat) +
					"\nCRIT: " + string(_beast._val_beast_crit_stat) +
					" | CRIT DMG: " + string(_beast._val_beast_crit_dmg_stat) +
					" | DODGE: " + string(_beast._val_beast_dod_stat) +
					" | MIN: " + string(_beast._val_beast_min_stat);
				hscr_cheats_set_hover_tooltip(_beast._str_beast_name,_str_party_tooltip);
			}

//----------------//
//NAME / LEVEL//
//----------------//
			draw_set_colour(c_white);
			draw_set_font(
				fnt_gui_party_small
			);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);

			var _val_send_ranch_x1 = _val_party_x1 + 7;
			var _val_send_ranch_x2 = _val_send_ranch_x1 + 112;
			var _flag_can_send_ranch = (_ct_party > 1);

			if (
				hscr_cheats_button(
					"SEND TO RANCH",
					_val_send_ranch_x1,
					_py + 4,
					_val_send_ranch_x2,
					_py + 28,
					_flag_can_send_ranch
				)
			){
				hscr_cheats_send_party_beast_to_ranch(_beast);
			}

			draw_set_colour(c_white);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);

			draw_text(
				_val_send_ranch_x2 + 7,
				_py + 7,
				_beast._str_beast_name +
				"  LV." +
				string(
					_beast._val_beast_level
				)
			);

//----------------//
//PARTY BUTTONS//
//----------------//
			var _val_inner_x1 =
				_val_party_x1 + 7;

			var _val_inner_x2 =
				_val_party_x2 - 7;

			var _val_button_gap = 4;

			var _val_available =
				_val_inner_x2 -
				_val_inner_x1 -
				(_val_button_gap * 3);

			var _val_button_w =
				_val_available / 4;

			var _val_button_y1 =
				_py + 34;

			var _val_button_y2 =
				_py +
				_val_party_panel_h -
				6;

			var _bx1 =
				_val_inner_x1;

			var _bx2 =
				_bx1 +
				_val_button_w;

			if (
				hscr_cheats_button(
					"+LV",
					_bx1,
					_val_button_y1,
					_bx2,
					_val_button_y2
				)
			){
				hscr_cheats_party_level(
					_beast,
					1
				);
			}

			_bx1 =
				_bx2 +
				_val_button_gap;

			_bx2 =
				_bx1 +
				_val_button_w;

			if (
				hscr_cheats_button(
					"-LV",
					_bx1,
					_val_button_y1,
					_bx2,
					_val_button_y2
				)
			){
				hscr_cheats_party_level(
					_beast,
					-1
				);
			}

			_bx1 =
				_bx2 +
				_val_button_gap;

			_bx2 =
				_bx1 +
				_val_button_w;

			if (
				hscr_cheats_button(
					"HEAL",
					_bx1,
					_val_button_y1,
					_bx2,
					_val_button_y2
				)
			){
				hscr_cheats_party_heal(
					_beast
				);
			}

			_bx1 =
				_bx2 +
				_val_button_gap;

			_bx2 =
				_val_inner_x2;

			if (
				hscr_cheats_button(
					"TALENTS",
					_bx1,
					_val_button_y1,
					_bx2,
					_val_button_y2
				)
			){

				audio_play_sound(
					snd_gui_error,
					0,
					false
				);

				hscr_cheats_log(
					"RESET TALENTS",
					"NOT IMPLEMENTED - NO ALLOCATED TALENT STATE EXISTS"
				);
			}
		}
	}

//================//
//PAGE//
//================//
	draw_set_colour(c_ltgray);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	draw_text(
		_val_left,
		_val_footer_y,
		"PAGE " +
		string(_it_page + 1) +
		"/" +
		string(_it_max_page + 1)
	);
}

//===============================================================================//
// CARDS
//===============================================================================//
else if (_it_tab == 1){

	// Cached once when the Cheats pane opens; do not rebuild/sort in Draw.
	var _arr_cards =
		_arr_cheat_cards_sorted;

	var _ct_catalog =
		array_length(
			_arr_cards
		);

	var _it_max_page =
		hscr_cheats_get_max_page(
			_ct_catalog,
			_ct_rows_per_page
		);

	_it_page =
		clamp(
			_it_page,
			0,
			_it_max_page
		);

	draw_set_font(
		fnt_gui_party_small
	);

	draw_set_colour(c_white);
	draw_set_halign(fa_left);

	draw_text(
		_val_left,
		_val_top,
		"CARD CATALOG"
	);

	for (
		var _r = 0;
		_r < _ct_rows_per_page;
		_r++
	){

		var _index =
			(_it_page *
			_ct_rows_per_page) +
			_r;

		if (_index >= _ct_catalog){
			break;
		}

		var _entry =
			_arr_cards[
				_index
			];

		if (!is_struct(_entry)){
			continue;
		}

		var _y =
			_val_top +
			26 +
			(_r * _val_row_step);

		var _str_card_color =
			hscr_cheats_get_entry_color(
				_entry
			);

		var _c_card =
			hscr_cheats_get_color(
				_str_card_color
			);

	//----------------//
	//COLORED CARD PANEL//
	//----------------//
	draw_set_colour(
	    _c_card
	);

	draw_rectangle(
	    _val_left,
	    _y,
	    _val_right,
	    _y + _val_row_h,
	    false
	);

	draw_set_colour(c_white);

	draw_rectangle(
	    _val_left,
	    _y,
	    _val_right,
	    _y + _val_row_h,
	    true
	);

//----------------//
//CARD CTRL INFO//
//----------------//
		if (hscr_cheats_point_in_rect(_val_hover_mouse_x,_val_hover_mouse_y,_val_left,_y,_val_right,_y + _val_row_h)){
			var _str_card_tooltip = "DESCRIPTION UNAVAILABLE";
			if (
				variable_struct_exists(_entry,"_stct_card_info") &&
				is_struct(_entry._stct_card_info) &&
				variable_struct_exists(_entry._stct_card_info,"_str_card_description")
			){
				_str_card_tooltip = string(_entry._stct_card_info._str_card_description);
			}
			hscr_cheats_set_hover_tooltip(_entry._str_card_name,_str_card_tooltip);
		}

//----------------//
//BUTTONS//
//----------------//
		var _val_library_w = 145;
		var _val_deck_w = 120;
		var _val_gap = 6;

		var _val_library_x2 =
			_val_right - 4;

		var _val_library_x1 =
			_val_library_x2 -
			_val_library_w;

		var _val_deck_x2 =
			_val_library_x1 -
			_val_gap;

		var _val_deck_x1 =
			_val_deck_x2 -
			_val_deck_w;

//----------------//
//NAME//
//----------------//
		draw_set_colour(c_black);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);

		draw_text(
			_val_left + 8,
			_y +
			(_val_row_h * 0.5),
			_entry._str_card_name
		);

		draw_set_valign(fa_top);

//----------------//
//ADD DECK//
//----------------//
		if (
			hscr_cheats_button(
				"ADD TO DECK",
				_val_deck_x1,
				_y + 3,
				_val_deck_x2,
				_y + _val_row_h - 3
			)
		){
			hscr_cheats_add_card(
				_entry._str_card_id,
				"DECK"
			);
		}

//----------------//
//ADD LIBRARY//
//----------------//
		if (
			hscr_cheats_button(
				"ADD TO LIBRARY",
				_val_library_x1,
				_y + 3,
				_val_library_x2,
				_y + _val_row_h - 3
			)
		){
			hscr_cheats_add_card(
				_entry._str_card_id,
				"LIBRARY"
			);
		}
	}

	draw_set_colour(c_ltgray);
	draw_set_halign(fa_left);

	draw_text(
		_val_left,
		_val_footer_y,
		"PAGE " +
		string(_it_page + 1) +
		"/" +
		string(_it_max_page + 1)
	);
}

//===============================================================================//
// ITEMS
//===============================================================================//
else if (_it_tab == 2){

	var _arr_items =
		global.arr_pool_items;

	var _ct_catalog =
		array_length(
			_arr_items
		);

	var _it_max_page =
		hscr_cheats_get_max_page(
			_ct_catalog,
			_ct_rows_per_page
		);

	_it_page =
		clamp(
			_it_page,
			0,
			_it_max_page
		);

	draw_set_font(
		fnt_gui_party_small
	);

	draw_set_colour(c_white);
	draw_set_halign(fa_left);

	draw_text(
		_val_left,
		_val_top,
		"ITEM CATALOG"
	);

	for (
		var _r = 0;
		_r < _ct_rows_per_page;
		_r++
	){

		var _index =
			(_it_page *
			_ct_rows_per_page) +
			_r;

		if (_index >= _ct_catalog){
			break;
		}

		var _id =
			_arr_items[_index];

		var _item =
			scr_inventory_get_item_info(
				_id
			);

		if (_item == undefined){
			continue;
		}

		var _y =
			_val_top +
			26 +
			(_r * _val_row_step);

		var _str_item_type =
			"DEFAULT";

		if (
			variable_struct_exists(
				_item,
				"_str_item_type"
			)
		){
			_str_item_type =
				_item._str_item_type;
		}

		var _c_item =
			hscr_cheats_get_item_color(
				_str_item_type
			);

//----------------//
//INVENTORY STYLE ROW//
//----------------//
		draw_set_colour(c_black);

		draw_rectangle(
			_val_left,
			_y,
			_val_right,
			_y + _val_row_h,
			false
		);

		draw_set_colour(_c_item);

		draw_rectangle(
			_val_left + 2,
			_y + 2,
			_val_right - 2,
			_y + _val_row_h - 2,
			false
		);

		draw_set_colour(c_black);

		draw_rectangle(
			_val_left,
			_y,
			_val_right,
			_y + _val_row_h,
			true
		);

//----------------//
//ITEM CTRL INFO//
//----------------//
		if (hscr_cheats_point_in_rect(_val_hover_mouse_x,_val_hover_mouse_y,_val_left,_y,_val_right,_y + _val_row_h)){
			var _str_item_description = "DESCRIPTION UNAVAILABLE";
			if (variable_struct_exists(_item,"_str_item_desc")){
				_str_item_description = string(_item._str_item_desc);
			}
			hscr_cheats_set_hover_tooltip(
				_item._str_item_name,
				string_upper(string(_str_item_type)) + " | " + _str_item_description
			);
		}

//----------------//
//NAME//
//----------------//
		draw_set_colour(c_black);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);

		draw_text(
			_val_left + 8,
			_y +
			(_val_row_h * 0.5),
			_item._str_item_name
		);

		draw_set_valign(fa_top);

//----------------//
//ADD BUTTON//
//----------------//
		var _val_button_x2 =
			_val_right - 4;

		var _val_button_x1 =
			_val_button_x2 - 165;

		if (
			hscr_cheats_button(
				"ADD TO INVENTORY",
				_val_button_x1,
				_y + 3,
				_val_button_x2,
				_y + _val_row_h - 3
			)
		){
			hscr_cheats_add_item(
				_id
			);
		}
	}

	draw_set_colour(c_ltgray);
	draw_set_halign(fa_left);

	draw_text(
		_val_left,
		_val_footer_y,
		"PAGE " +
		string(_it_page + 1) +
		"/" +
		string(_it_max_page + 1)
	);
}

//===============================================================================//
// MISC
//===============================================================================//
else if (_it_tab == 3){

	draw_set_font(
		fnt_gui_party_small
	);

	draw_set_colour(c_white);
	draw_set_halign(fa_left);

//================//
//START BATTLE//
//================//
	draw_text(
		_val_left,
		_val_top,
		"START BATTLE"
	);

	var _val_world_gap = 6;

	var _val_world_button_w =
		(
			_val_content_w -
			(_val_world_gap * 2)
		) / 3;

	var _val_battle_button_y1 =
		_val_top + 22;

	var _val_battle_button_y2 =
		_val_battle_button_y1 + 30;

	if (
		hscr_cheats_button(
			"START EASY BATTLE",
			_val_left,
			_val_battle_button_y1,
			_val_left +
			_val_world_button_w,
			_val_battle_button_y2
		)
	){
		if (hscr_cheats_start_battle("EASY")){
			exit;
		}
	}

	if (
		hscr_cheats_button(
			"START MEDIUM BATTLE",
			_val_left +
			_val_world_button_w +
			_val_world_gap,
			_val_battle_button_y1,
			_val_left +
			(_val_world_button_w * 2) +
			_val_world_gap,
			_val_battle_button_y2
		)
	){
		if (hscr_cheats_start_battle("MEDIUM")){
			exit;
		}
	}

	if (
		hscr_cheats_button(
			"START HARD BATTLE",
			_val_left +
			(_val_world_button_w * 2) +
			(_val_world_gap * 2),
			_val_battle_button_y1,
			_val_right,
			_val_battle_button_y2
		)
	){
		if (hscr_cheats_start_battle("HARD")){
			exit;
		}
	}

//================//
//TELEPORT//
//================//
	var _val_teleport_header_y =
		_val_top + 62;

	draw_set_colour(c_white);
	draw_set_halign(fa_left);

	draw_text(
		_val_left,
		_val_teleport_header_y,
		"TELEPORT"
	);

	var _val_teleport_button_y1 =
		_val_teleport_header_y + 22;

	var _val_teleport_button_y2 =
		_val_teleport_button_y1 + 30;

	if (
		hscr_cheats_button(
			"TELEPORT RANCH",
			_val_left,
			_val_teleport_button_y1,
			_val_left +
			_val_world_button_w,
			_val_teleport_button_y2
		)
	){
		if (hscr_cheats_teleport_ranch()){
			exit;
		}
	}

	if (
		hscr_cheats_button(
			"ROOM CENTER",
			_val_left +
			_val_world_button_w +
			_val_world_gap,
			_val_teleport_button_y1,
			_val_left +
			(_val_world_button_w * 2) +
			_val_world_gap,
			_val_teleport_button_y2
		)
	){
		hscr_cheats_teleport_player(
			room_width * 0.5,
			room_height * 0.5,
			"ROOM CENTER"
		);
	}

	if (
		hscr_cheats_button(
			"CLICK TELEPORT",
			_val_left +
			(_val_world_button_w * 2) +
			(_val_world_gap * 2),
			_val_teleport_button_y1,
			_val_right,
			_val_teleport_button_y2
		)
	){
		hscr_cheats_start_tool(
			"CLICK_TELEPORT",
			"TELEPORT: CLICK WORLD POSITION",
			"WORLD_POSITION"
		);
	}

//================//
//GOLD//
//================//
	var _val_gold_header_y =
		_val_top + 124;

	draw_set_colour(c_white);
	draw_set_halign(fa_left);


	draw_text(
		_val_left,
		_val_gold_header_y,
		"GOLD"
	);

//================//
//GOLD BUTTONS//
//================//
	var _val_gold_y =
		_val_gold_header_y + 22;

	var _arr_gold_buttons = [
		["-1000 GP",-1000],
		["-100 GP",-100],
		["-1 GP",-1],
		["+1 GP",1],
		["+100 GP",100],
		["+1000 GP",1000]
	];

	var _val_gold_button_w =
		(_val_right - _val_left - 25) / 6;

	for (
		var _g = 0;
		_g < array_length(_arr_gold_buttons);
		_g++
	){

		var _gx1 =
			_val_left +
			(_g * (_val_gold_button_w + 5));

		var _gx2 =
			_gx1 +
			_val_gold_button_w;

		var _val_gold_change =
			_arr_gold_buttons[_g][1];

		if (
			hscr_cheats_button(
				_arr_gold_buttons[_g][0],
				_gx1,
				_val_gold_y,
				_gx2,
				_val_gold_y + 32
			)
		){

			if (
				_val_gold_change < 0 &&
				global.val_player_gold <= 0
			){

				audio_play_sound(
					snd_gui_error,
					0,
					false
				);

				hscr_cheats_log(
					"GOLD REMOVE CAPPED",
					"GOLD ALREADY 0"
				);
			}
			else{

				var _val_gold_before =
					global.val_player_gold;

				global.val_player_gold =
					max(
						0,
						global.val_player_gold +
						_val_gold_change
					);

				if (
					global.val_player_gold ==
					_val_gold_before
				){

					audio_play_sound(
						snd_gui_error,
						0,
						false
					);
				}
				else{

					audio_play_sound(
						snd_battle_heal,
						0,
						false
					);
				}

				hscr_cheats_log(
					(_val_gold_change > 0)
					? "GOLD ADDED"
					: "GOLD REMOVED",
					"REQUESTED: " +
					string(_val_gold_change) +
					" | GOLD: " +
					string(_val_gold_before) +
					" -> " +
					string(global.val_player_gold)
				);
			}
		}
	}

//================//
//SPAWN HEADER//
//================//
	var _val_spawn_top =
		_val_top + 195;

	draw_set_colour(c_white);
	draw_set_halign(fa_left);


	draw_text(
		_val_left,
		_val_spawn_top,
		"SPAWN WILD BEAST"
	);

	var _list_beasts =
		global.list_logbook_beasts;

	var _ct_catalog =
		ds_list_size(
			_list_beasts
		);

	var _ct_spawn_rows_per_page =
		max(
			1,
			floor(
				(
					_val_bottom -
					(
						_val_spawn_top +
						24
					) +
					_val_row_gap
				) /
				_val_row_step
			)
		);

	var _it_max_page =
		hscr_cheats_get_max_page(
			_ct_catalog,
			_ct_spawn_rows_per_page
		);

	_it_page =
		clamp(
			_it_page,
			0,
			_it_max_page
		);

//================//
//SPAWN ROWS//
//================//
	for (
		var _r = 0;
		_r < _ct_spawn_rows_per_page;
		_r++
	){

		var _index =
			(_it_page *
			_ct_spawn_rows_per_page) +
			_r;

		if (_index >= _ct_catalog){
			break;
		}

		var _entry =
			ds_list_find_value(
				_list_beasts,
				_index
			);

		if (!is_struct(_entry)){
			continue;
		}

		var _y =
			_val_spawn_top +
			24 +
			(_r * _val_row_step);

		if (
			_y + _val_row_h >
			_val_bottom
		){
			break;
		}

		var _str_beast_color =
			hscr_cheats_get_entry_color(
				_entry
			);

		var _c_beast =
			hscr_cheats_get_color(
				_str_beast_color
			);

		//----------------//
		//COLORED BEAST PANEL//
		//----------------//
		draw_set_colour(
			_c_beast
		);

		draw_rectangle(
			_val_left,
			_y,
			_val_right,
			_y + _val_row_h,
			false
		);

		draw_set_colour(c_white);

		draw_rectangle(
			_val_left,
			_y,
			_val_right,
			_y + _val_row_h,
			true
		);

//----------------//
//BEAST CTRL INFO//
//----------------//
		if (hscr_cheats_point_in_rect(_val_hover_mouse_x,_val_hover_mouse_y,_val_left,_y,_val_right,_y + _val_row_h)){
			var _str_misc_beast_tooltip = "BASE STATS UNAVAILABLE";
			if (variable_struct_exists(_entry,"_stct_beast_info") && is_struct(_entry._stct_beast_info)){
				var _stct_misc_beast_tooltip = _entry._stct_beast_info;
				_str_misc_beast_tooltip =
					"BASE STATS" +
					"\nHP: " + string(_stct_misc_beast_tooltip._val_beast_hp_stat) +
					" | CON: " + string(_stct_misc_beast_tooltip._val_beast_con_stat) +
					" | PPOW: " + string(_stct_misc_beast_tooltip._val_beast_ppow_stat) +
					" | MPOW: " + string(_stct_misc_beast_tooltip._val_beast_mpow_stat) +
					"\nPDEF: " + string(_stct_misc_beast_tooltip._val_beast_pdef_stat) +
					" | MDEF: " + string(_stct_misc_beast_tooltip._val_beast_mdef_stat) +
					" | SPEED: " + string(_stct_misc_beast_tooltip._val_beast_speed_stat) +
					"\nCRIT: " + string(_stct_misc_beast_tooltip._val_beast_crit_stat) +
					" | CRIT DMG: " + string(_stct_misc_beast_tooltip._val_beast_crit_dmg_stat) +
					" | DODGE: " + string(_stct_misc_beast_tooltip._val_beast_dod_stat) +
					" | MIN: " + string(_stct_misc_beast_tooltip._val_beast_min_stat);
			}
			hscr_cheats_set_hover_tooltip(_entry._str_beast_name,_str_misc_beast_tooltip);
		}

		draw_set_colour(c_black);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);

		draw_text(
			_val_left + 8,
			_y +
			(_val_row_h * 0.5),
			_entry._str_beast_name
		);

		draw_set_valign(fa_top);

		//----------------//
		//SPAWN NORMAL//
		//----------------//
		if (
			hscr_cheats_button(
				"SPAWN",
				_val_right - 250,
				_y + 3,
				_val_right - 134,
				_y + _val_row_h - 3
			)
		){

			hscr_cheats_start_tool(
				"SPAWN_WILD",
				"SPAWN " +
				string_upper(
					_entry._str_beast_name
				),
				"WORLD_POSITION",
				_entry._str_beast_id
			);
		}

		//----------------//
		//SPAWN ELITE//
		//----------------//
		if (
			hscr_cheats_button(
				"SPAWN ELITE",
				_val_right - 128,
				_y + 3,
				_val_right - 4,
				_y + _val_row_h - 3
			)
		){

			hscr_cheats_start_tool(
				"SPAWN_ELITE",
				"SPAWN ELITE " +
				string_upper(
					_entry._str_beast_name
				),
				"WORLD_POSITION",
				_entry._str_beast_id
			);
		}
	}

	draw_set_colour(c_ltgray);
	draw_set_halign(fa_left);
	
	draw_text(
		_val_left,
		_val_footer_y,
		"PAGE " +
		string(_it_page + 1) +
		"/" +
		string(_it_max_page + 1)
	);
}

}

//===============================================================================//
// BATTLE
//===============================================================================//
else{

//===============================================================================//
// INTERACT
//===============================================================================//
if (_it_tab == 0){

	draw_set_font(
		fnt_gui_party_small
	);

	draw_set_colour(c_white);
	draw_set_halign(fa_left);

	draw_text(
		_val_left,
		_val_top,
		"TARGET"
	);
//================//
//TARGET BUTTONS//
//================//
	var _val_target_y =
		_val_top + 24;

	var _val_target_gap = 5;

	var _arr_target_buttons = [
		["RESURRECT","RESURRECT","RESURRECT TARGET","BATTLE_UNIT"],
		["HEAL +1","HEAL_1","HEAL TARGET +1","BATTLE_UNIT"],
		["HEAL +10","HEAL_10","HEAL TARGET +10","BATTLE_UNIT"],
		["FULL HEAL","HEAL_FULL","FULL HEAL TARGET","BATTLE_UNIT"],
		["DAMAGE -1","DAMAGE_1","DAMAGE TARGET -1","BATTLE_UNIT"],
		["DAMAGE -10","DAMAGE_10","DAMAGE TARGET -10","BATTLE_UNIT"],
		["KILL","KILL","KILL TARGET","BATTLE_UNIT"]
	];

	var _ct_target_buttons = array_length(_arr_target_buttons);

	var _val_target_w =
		(
			_val_content_w -
			(_val_target_gap * (_ct_target_buttons - 1))
		) /
		_ct_target_buttons;

	for (var _i = 0;_i < _ct_target_buttons;_i++){

		var _bx1 =
			_val_left +
			(_i * (_val_target_w + _val_target_gap));

		var _bx2 = _bx1 + _val_target_w;

		if (
			hscr_cheats_button(
				_arr_target_buttons[_i][0],
				_bx1,
				_val_target_y,
				_bx2,
				_val_target_y + 30
			)
		){

			hscr_cheats_start_tool(
				_arr_target_buttons[_i][1],
				_arr_target_buttons[_i][2],
				_arr_target_buttons[_i][3]
			);
		}
	}


//================//
//LEVEL//
//================//
	var _val_level_y =
		_val_target_y + 48;

	draw_set_colour(c_white);
	draw_set_halign(fa_left);


	draw_text(
		_val_left,
		_val_level_y,
		"LEVEL"
	);

	var _arr_level_buttons = [
		["+1","LEVEL_1","TARGET LEVEL +1"],
		["+5","LEVEL_5","TARGET LEVEL +5"],
		["-1","LEVEL_MINUS_1","TARGET LEVEL -1"],
		["-5","LEVEL_MINUS_5","TARGET LEVEL -5"]
	];

	for (
		var _i = 0;
		_i < 4;
		_i++
	){

		var _bx1 =
			_val_left +
			(_i * 65);

		if (
			hscr_cheats_button(
				_arr_level_buttons[_i][0],
				_bx1,
				_val_level_y + 23,
				_bx1 + 55,
				_val_level_y + 51
			)
		){

			hscr_cheats_start_tool(
				_arr_level_buttons[_i][1],
				_arr_level_buttons[_i][2],
				"BATTLE_UNIT"
			);
		}
	}

//================//
//CLEANSE//
//================//
	var _val_cleanse_y =
		_val_level_y + 70;

	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_text(_val_left,_val_cleanse_y,"CLEANSE");

	var _val_cleanse_gap = 5;
	var _ct_cleanse_cols = 4;
	var _val_cleanse_w =
		(
			_val_content_w -
			(_val_cleanse_gap * (_ct_cleanse_cols - 1))
		) /
		_ct_cleanse_cols;

	var _arr_cleanse_buttons = [
		["SINGLE STATUS","STATUS_CLICK"],
		["DOT ALL","DOT|STATUS|ALL"],
		["DEBUFF ALL","DEBUFF|STATUS|ALL"],
		["CC ALL","CC|STATUS|ALL"],
		["AURA ALL","AURA|STATUS|ALL"],
		["NEGATIVE ALL","NEGATIVE|STATUS|ALL"],
		["ALL","ALL|STATUS|ALL"]
	];

	for (
		var _i = 0;
		_i < array_length(_arr_cleanse_buttons);
		_i++
	){
		var _col = _i mod _ct_cleanse_cols;
		var _row = floor(_i / _ct_cleanse_cols);

		var _bx1 =
			_val_left +
			(_col * (_val_cleanse_w + _val_cleanse_gap));

		var _by1 =
			_val_cleanse_y +
			23 +
			(_row * 34);

		if (
			hscr_cheats_button(
				_arr_cleanse_buttons[_i][0],
				_bx1,
				_by1,
				_bx1 + _val_cleanse_w,
				_by1 + 28
			)
		){
			if (_arr_cleanse_buttons[_i][1] == "STATUS_CLICK"){
				hscr_cheats_start_tool(
					"STATUS_CLEANSE_CLICK",
					"CLEANSE: CLICK STATUS",
					"BATTLE_STATUS"
				);
			}
			else{
				hscr_cheats_start_tool(
					"CLEANSE",
					"CLEANSE " + _arr_cleanse_buttons[_i][0],
					"BATTLE_UNIT",
					_arr_cleanse_buttons[_i][1]
				);
			}
		}
	}

//================//
//INTERACT SECTIONS//
//================//
	var _val_submenu_y =
		_val_cleanse_y + 100;

	var _val_section_gap = 10;
	var _val_section_w =
		(_val_content_w - (_val_section_gap * 3)) / 4;
	var _val_section_button_y = _val_submenu_y + 20;
	var _val_section_button_h = 30;

	//----------------//
	//STATUS//
	//----------------//
	var _val_status_section_x = _val_left;
	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_text(_val_status_section_x,_val_submenu_y,"STATUS");

	if (hscr_cheats_button(
		"STATUS TARGET",
		_val_status_section_x,
		_val_section_button_y,
		_val_status_section_x + _val_section_w,
		_val_section_button_y + _val_section_button_h
	)){
		_it_submenu = 1;
		_it_page = 0;
	}

	var _val_status_half_w = (_val_section_w - 5) * 0.5;
	var _val_status_row_2 = _val_section_button_y + 36;
	var _val_status_row_3 = _val_status_row_2 + 32;

	if (hscr_cheats_button(
		"STACK +1",
		_val_status_section_x,
		_val_status_row_2,
		_val_status_section_x + _val_status_half_w,
		_val_status_row_2 + 26
	)){
		hscr_cheats_start_tool("STATUS_STACK_ADD","STACK +1: CLICK STATUS","BATTLE_STATUS");
	}

	if (hscr_cheats_button(
		"STACK -1",
		_val_status_section_x + _val_status_half_w + 5,
		_val_status_row_2,
		_val_status_section_x + _val_section_w,
		_val_status_row_2 + 26
	)){
		hscr_cheats_start_tool("STATUS_STACK_REMOVE","STACK -1: CLICK STATUS","BATTLE_STATUS");
	}

	var _val_status_third_gap = 4;
	var _val_status_third_w = (_val_section_w - (_val_status_third_gap * 2)) / 3;

	if (hscr_cheats_button(
		"DUR -1",
		_val_status_section_x,
		_val_status_row_3,
		_val_status_section_x + _val_status_third_w,
		_val_status_row_3 + 26
	)){
		hscr_cheats_start_tool("STATUS_DURATION_REMOVE","DURATION -1: CLICK STATUS","BATTLE_STATUS");
	}

	if (hscr_cheats_button(
		"REFRESH",
		_val_status_section_x + _val_status_third_w + _val_status_third_gap,
		_val_status_row_3,
		_val_status_section_x + (_val_status_third_w * 2) + _val_status_third_gap,
		_val_status_row_3 + 26
	)){
		hscr_cheats_start_tool("STATUS_REFRESH","REFRESH: CLICK STATUS","BATTLE_STATUS");
	}

	if (hscr_cheats_button(
		"DUR +1",
		_val_status_section_x + (_val_status_third_w * 2) + (_val_status_third_gap * 2),
		_val_status_row_3,
		_val_status_section_x + _val_section_w,
		_val_status_row_3 + 26
	)){
		hscr_cheats_start_tool("STATUS_DURATION_ADD","DURATION +1: CLICK STATUS","BATTLE_STATUS");
	}

	//----------------//
	//MINIONS//
	//----------------//
	var _val_minion_section_x = _val_left + _val_section_w + _val_section_gap;
	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_text(_val_minion_section_x,_val_submenu_y,"MINIONS");

	if (hscr_cheats_button(
		"SPAWN MINION",
		_val_minion_section_x,
		_val_section_button_y,
		_val_minion_section_x + _val_section_w,
		_val_section_button_y + _val_section_button_h
	)){
		_str_minion_submenu_action = "SPAWN";
		_it_submenu = 2;
		_it_page = 0;
	}

	if (hscr_cheats_button(
		"REPLACE MINION",
		_val_minion_section_x,
		_val_status_row_2,
		_val_minion_section_x + _val_section_w,
		_val_status_row_2 + 26
	)){
		_str_minion_submenu_action = "REPLACE";
		_it_submenu = 2;
		_it_page = 0;
	}

	var _val_minion_half_w = (_val_section_w - 5) * 0.5;
	var _val_minion_row_3 = _val_status_row_3;
	var _val_minion_row_4 = _val_minion_row_3 + 32;

	// All expanded INTERACT lists/panels begin below the lowest Minion edit row.
	// This prevents Status/Minion/Stat submenu controls from overlapping the
	// HP/Magnitude buttons added to the compact section header.
	var _val_expanded_start_y = _val_minion_row_4 + 32;

	if (hscr_cheats_button(
		"HP -1",
		_val_minion_section_x,
		_val_minion_row_3,
		_val_minion_section_x + _val_minion_half_w,
		_val_minion_row_3 + 26
	)){
		hscr_cheats_start_tool(
			"MINION_HP_REMOVE",
			"MINION HP -1: CLICK MINION",
			"BATTLE_MINION"
		);
	}

	if (hscr_cheats_button(
		"HP +1",
		_val_minion_section_x + _val_minion_half_w + 5,
		_val_minion_row_3,
		_val_minion_section_x + _val_section_w,
		_val_minion_row_3 + 26
	)){
		hscr_cheats_start_tool(
			"MINION_HP_ADD",
			"MINION HP +1: CLICK MINION",
			"BATTLE_MINION"
		);
	}

	if (hscr_cheats_button(
		"MAG -1",
		_val_minion_section_x,
		_val_minion_row_4,
		_val_minion_section_x + _val_minion_half_w,
		_val_minion_row_4 + 26
	)){
		hscr_cheats_start_tool(
			"MINION_MAG_REMOVE",
			"MINION MAG -1: CLICK MINION",
			"BATTLE_MINION"
		);
	}

	if (hscr_cheats_button(
		"MAG +1",
		_val_minion_section_x + _val_minion_half_w + 5,
		_val_minion_row_4,
		_val_minion_section_x + _val_section_w,
		_val_minion_row_4 + 26
	)){
		hscr_cheats_start_tool(
			"MINION_MAG_ADD",
			"MINION MAG +1: CLICK MINION",
			"BATTLE_MINION"
		);
	}

	//----------------//
	//REPOSITION / BEAST//
	//----------------//
	var _val_beast_section_x = _val_minion_section_x + _val_section_w + _val_section_gap;
	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_text(_val_beast_section_x,_val_submenu_y,"REPOSITION / BEAST");

	var _val_half_button_w = (_val_section_w - 5) * 0.5;

	if (hscr_cheats_button(
		"REPOSITION",
		_val_beast_section_x,
		_val_section_button_y,
		_val_beast_section_x + _val_half_button_w,
		_val_section_button_y + _val_section_button_h
	)){
		hscr_cheats_start_tool(
			"SWAP_BEASTS",
			"REPOSITION: SELECT FIRST BEAST",
			"BATTLE_BEAST_PAIR"
		);
	}

	if (hscr_cheats_button(
		"CHANGE BEAST",
		_val_beast_section_x + _val_half_button_w + 5,
		_val_section_button_y,
		_val_beast_section_x + _val_section_w,
		_val_section_button_y + _val_section_button_h
	)){
		_it_submenu = 4;
		_it_page = 0;
	}

	if (hscr_cheats_button(
		"STAT EDITOR",
		_val_beast_section_x,
		_val_status_row_2,
		_val_beast_section_x + _val_section_w,
		_val_status_row_2 + 26
	)){
		_it_submenu = 5;
		_it_page = 0;
	}

	//----------------//
	//ELITES//
	//----------------//
	var _val_elite_section_x = _val_beast_section_x + _val_section_w + _val_section_gap;
	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_text(_val_elite_section_x,_val_submenu_y,"ELITES");

	if (hscr_cheats_button(
		"ELITE MODIFIER",
		_val_elite_section_x,
		_val_section_button_y,
		_val_elite_section_x + _val_half_button_w,
		_val_section_button_y + _val_section_button_h
	)){
		_it_submenu = 3;
		_it_page = 0;
	}

	if (hscr_cheats_button(
		"DEMOTE ELITE",
		_val_elite_section_x + _val_half_button_w + 5,
		_val_section_button_y,
		_val_elite_section_x + _val_section_w,
		_val_section_button_y + _val_section_button_h
	)){
		hscr_cheats_start_tool(
			"ELITE_DEMOTE",
			"DEMOTE: CLICK ENEMY ELITE",
			"BATTLE_UNIT"
		);
	}

	//========================//
	//ELITE RISK TIER BUTTONS//
	//========================//
	var _val_risk_button_y = _val_section_button_y + 36;
	var _val_risk_button_gap = 5;
	var _val_risk_button_w = (_val_section_w - _val_risk_button_gap) * 0.5;

	if (hscr_cheats_button(
		"TIER 1",
		_val_elite_section_x,
		_val_risk_button_y,
		_val_elite_section_x + _val_risk_button_w,
		_val_risk_button_y + 26
	)){
		hscr_cheats_start_tool("ELITE_RISK_SET","TIER 1: CLICK ENEMY ELITE","BATTLE_UNIT","1");
	}

	if (hscr_cheats_button(
		"TIER 0",
		_val_elite_section_x + _val_risk_button_w + _val_risk_button_gap,
		_val_risk_button_y,
		_val_elite_section_x + _val_section_w,
		_val_risk_button_y + 26
	)){
		hscr_cheats_start_tool("ELITE_RISK_SET","TIER 0: CLICK ENEMY ELITE","BATTLE_UNIT","0");
	}

	//----------------//
	//CLOSE LIST//
	//----------------//
	if (_it_submenu != 0 && hscr_cheats_button(
		"CLOSE LIST",
		_val_beast_section_x,
		_val_status_row_3,
		_val_beast_section_x + _val_section_w,
		_val_status_row_3 + 26
	)){
		_it_submenu = 0;
		_it_page = 0;
	}

	//----------------//
	//SUBMENU HELP//
	//----------------//
	if (_it_submenu == 1){

		var _val_team_select_y =
			_val_expanded_start_y;

		var _val_team_button_w = 122;
		var _val_team_button_gap = 6;

		draw_set_colour(c_ltgray);
		draw_set_font(fnt_gui_party_small);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

		draw_text(
			_val_left,
			_val_team_select_y + 7,
			"TEAM EFFECT TARGET: " +
			_str_selected_status_team
		);

		var _val_team_player_x =
			_val_left + 190;

		if (
			hscr_cheats_button(
				"PLAYER TEAM",
				_val_team_player_x,
				_val_team_select_y,
				_val_team_player_x +
					_val_team_button_w,
				_val_team_select_y + 30
			)
		){
			_str_selected_status_team = "PLAYER";
		}

		var _val_team_enemy_x =
			_val_team_player_x +
			_val_team_button_w +
			_val_team_button_gap;

		if (
			hscr_cheats_button(
				"ENEMY TEAM",
				_val_team_enemy_x,
				_val_team_select_y,
				_val_team_enemy_x +
					_val_team_button_w,
				_val_team_select_y + 30
			)
		){
			_str_selected_status_team = "ENEMY";
		}

		//==============================//
		//RESET STATUS SECTION ALIGNMENT//
		//==============================//
		// Button helpers draw centered text. Restore the status section header
		// explicitly so its instructions remain left-aligned.
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_colour(c_ltgray);

		draw_text(
			_val_left,
			_val_expanded_start_y + 36,
			"APPLY STATUS: HOST = CLICK BEAST   |   TEAM / AURA (TEAM) = CLICK SOURCE ON SELECTED TEAM"
		);
	}
	else if (_it_submenu == 2){

		draw_set_colour(c_ltgray);
		draw_set_font(fnt_gui_party_small);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

		draw_text(
			_val_left,
			_val_expanded_start_y,
			(_str_minion_submenu_action == "REPLACE")
			? "SELECT REPLACEMENT MINION -> CLICK EXISTING MINION"
			: "SELECT MINION -> CLICK HOST"
		);
	}
	else if (_it_submenu == 3){

		draw_set_colour(c_ltgray);
		draw_set_font(fnt_gui_party_small);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

		draw_text(
			_val_left,
			_val_expanded_start_y,
			"SELECT MODIFIER / ELEMENT -> REPEATEDLY CLICK LIVING ENEMIES   |   RMB: RETURN"
		);
	}
	else if (_it_submenu == 4){

		draw_set_colour(c_ltgray);
		draw_set_font(fnt_gui_party_small);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

		draw_text(
			_val_left,
			_val_expanded_start_y,
			"SELECT BEAST -> REPEATEDLY CLICK LIVING ENEMIES   |   RMB: RETURN"
		);
	}
	else if (_it_submenu == 5){

		draw_set_colour(c_ltgray);
		draw_set_font(fnt_gui_party_small);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

		draw_text(
			_val_left,
			_val_expanded_start_y,
			"SELECT DELTA -> CLICK ANY BATTLE BEAST   |   FLOOR 0   |   CRIT/DODGE MAX 100   |   MINIONS MAX 10"
		);
	}

//===============================================================================//
// STATUS SUBMENU
//===============================================================================//
	if (_it_submenu == 1){

		// Cached once when the Cheats pane opens; do not rebuild/sort in Draw.
		var _arr_all_statuses =
			_arr_cheat_statuses_sorted;

		var _ct_per_page = 24;

		var _it_max_page =
			hscr_cheats_get_max_page(
				array_length(
					_arr_all_statuses
				),
				_ct_per_page
			);

		_it_page =
			clamp(
				_it_page,
				0,
				_it_max_page
			);

		var _val_list_y =
			_val_expanded_start_y + 60;

		var _val_gap = 6;

		var _val_list_row_step = 40;

		var _val_button_w =
			(
				_val_content_w -
				(_val_gap * 3)
			) / 4;

		for (
			var _i = 0;
			_i < _ct_per_page;
			_i++
		){

			var _index =
				(_it_page *
				_ct_per_page) +
				_i;

			if (
				_index >=
				array_length(
					_arr_all_statuses
				)
			){
				break;
			}

			var _entry =
				_arr_all_statuses[
					_index
				];

			var _str_category =
				_entry[0];

			var _str_status =
				_entry[1];

			var _str_display_category =
				_entry[2];

			var _flag_team_effect =
				_entry[3];

			var _flag_player_only_team_effect =
				_str_category == "TEAM" &&
				hscr_cheats_status_is_player_only_team_effect(
					_str_status
				);

			var _flag_status_enabled =
				!(
					_flag_player_only_team_effect &&
					_str_selected_status_team == "ENEMY"
				);

			var _col =
				_i mod 4;

			var _row =
				floor(
					_i / 4
				);

			var _bx1 =
				_val_left +
				(
					_col *
					(
						_val_button_w +
						_val_gap
					)
				);

			var _by1 =
				_val_list_y +
				(_row *
				_val_list_row_step);

			var _str_status_color =
				hscr_cheats_get_status_color_group(
					_str_category,
					_str_status
				);

			var _str_status_label =
				_str_display_category +
				" - " +
				_str_status;

			if (
				hscr_cheats_colored_button(
					_str_status_label,
					_bx1,
					_by1,
					_bx1 +
						_val_button_w,
					_by1 + 32,
					_str_status_color,
					_flag_status_enabled
				)
			){

				/*
					PLAYER-only Card/Mana Team effects are disabled while ENEMY is
					selected. Team Auras remain valid for both PLAYER and ENEMY.
				*/
				hscr_cheats_start_tool(
					"STATUS",
					"APPLY " +
					_str_status +
					(
						_flag_team_effect
						? " [" +
							_str_selected_status_team +
							"]"
						: ""
					),
					"BATTLE_UNIT",
					_str_category +
						"|" +
						_str_status
				);
			}
		}

		draw_set_colour(c_ltgray);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

		draw_text(
			_val_left,
			_val_footer_y,
			"STATUS PAGE " +
			string(_it_page + 1) +
			"/" +
			string(_it_max_page + 1)
		);
	}

//===============================================================================//
// MINION SUBMENU
//===============================================================================//
	else if (_it_submenu == 2){

		var _ct_per_page = 24;

		var _it_max_page =
			hscr_cheats_get_max_page(
				array_length(
					_arr_cheat_minions
				),
				_ct_per_page
			);

		_it_page =
			clamp(
				_it_page,
				0,
				_it_max_page
			);

		var _val_list_y =
			_val_expanded_start_y + 26;

		var _val_gap = 6;

		var _val_list_row_step = 40;

		var _val_button_w =
			(
				_val_content_w -
				(_val_gap * 3)
			) / 4;

		for (
			var _i = 0;
			_i < _ct_per_page;
			_i++
		){

			var _index =
				(_it_page *
				_ct_per_page) +
				_i;

			if (
				_index >=
				array_length(
					_arr_cheat_minions
				)
			){
				break;
			}

			var _col =
				_i mod 4;

			var _row =
				floor(
					_i / 4
				);

			var _bx1 =
				_val_left +
				(
					_col *
					(
						_val_button_w +
						_val_gap
					)
				);

			var _by1 =
				_val_list_y +
				(_row *
				_val_list_row_step);

			var _str_minion =
				_arr_cheat_minions[
					_index
				];

			var _str_minion_color =
				hscr_cheats_get_minion_color_group(
					_str_minion
				);

			if (
				hscr_cheats_colored_button(
					_str_minion,
					_bx1,
					_by1,
					_bx1 +
					_val_button_w,
					_by1 + 32,
					_str_minion_color
				)
			){

				if (_str_minion_submenu_action == "REPLACE"){
					hscr_cheats_start_tool(
						"REPLACE_MINION",
						"REPLACE WITH " + _str_minion + ": CLICK MINION",
						"BATTLE_MINION",
						_str_minion
					);
				}
				else{
					hscr_cheats_start_tool(
						"SPAWN_MINION",
						"SPAWN " + _str_minion,
						"BATTLE_UNIT",
						_str_minion
					);
				}
			}
		}

		draw_set_colour(c_ltgray);
		draw_set_halign(fa_left);

		draw_text(
			_val_left,
			_val_footer_y,
			"MINION PAGE " +
			string(_it_page + 1) +
			"/" +
			string(_it_max_page + 1)
		);
	}

//===============================================================================//
// ELITE MODIFIER SUBMENU
//===============================================================================//
	else if (_it_submenu == 3){

		var _ct_per_page = 24;

		var _it_max_page =
			hscr_cheats_get_max_page(
				array_length(
					_arr_cheat_elite_menu_entries
				),
				_ct_per_page
			);

		_it_page =
			clamp(
				_it_page,
				0,
				_it_max_page
			);

		var _val_elite_list_y =
			_val_expanded_start_y + 26;

		var _val_elite_gap = 6;

		var _val_elite_row_step = 42;

		var _val_elite_button_w =
			(
				_val_content_w -
				(_val_elite_gap * 3)
			) / 4;

		for (
			var _i = 0;
			_i < _ct_per_page;
			_i++
		){
			var _index =
				(
					_it_page *
					_ct_per_page
				) +
				_i;

			if (
				_index >=
				array_length(
					_arr_cheat_elite_menu_entries
				)
			){
				break;
			}

			var _stct_elite_entry =
				_arr_cheat_elite_menu_entries[
					_index
				];

			if (!is_struct(_stct_elite_entry)){
				continue;
			}

			var _str_label =
				_stct_elite_entry
					._str_label;

			var _str_modifier =
				_stct_elite_entry
					._str_modifier;

			var _str_variant =
				_stct_elite_entry
					._str_variant;

			var _col =
				_i mod 4;

			var _row =
				floor(
					_i / 4
				);

			var _bx1 =
				_val_left +
				(
					_col *
					(
						_val_elite_button_w +
						_val_elite_gap
					)
				);

			var _by1 =
				_val_elite_list_y +
				(
					_row *
					_val_elite_row_step
				);

			var _bx2 =
				_bx1 +
				_val_elite_button_w;

			var _by2 =
				_by1 + 34;

			var _flag_clicked =
				hscr_cheats_button(
					_str_label,
					_bx1,
					_by1,
					_bx2,
					_by2
				);

			//----------------//
			//ELITE TOOLTIP//
			//----------------//
			var _val_mouse_x =
				device_mouse_x_to_gui(0);

			var _val_mouse_y =
				device_mouse_y_to_gui(0);

			if (
				hscr_cheats_point_in_rect(
					_val_mouse_x,
					_val_mouse_y,
					_bx1,
					_by1,
					_bx2,
					_by2
				)
			){
				hscr_cheats_set_hover_tooltip(
					_str_label,
					hscr_cheats_get_elite_tooltip(
						_str_modifier,
						_str_variant
					)
				);
			}

			//----------------//
			//SELECT MODIFIER//
			//----------------//
			if (_flag_clicked){

				var _str_selected_elite_id =
					_str_modifier;

				if (_str_variant != ""){
					_str_selected_elite_id +=
						"|" +
						_str_variant;
				}

				hscr_cheats_start_tool(
					"ELITE_SET",
					"ELITE " +
					_str_label +
					": CLICK ENEMY",
					"BATTLE_UNIT",
					_str_selected_elite_id
				);
			}
		}

		draw_set_colour(c_ltgray);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

		draw_text(
			_val_left,
			_val_footer_y,
			"ELITE MODIFIER PAGE " +
			string(_it_page + 1) +
			"/" +
			string(_it_max_page + 1) +
			"   |   ELEMENTAL VARIANTS ARE EXPLICIT   |   CTRL: DESCRIPTION"
		);
	}

//===============================================================================//
// CHANGE BEAST SUBMENU
//===============================================================================//
	else if (_it_submenu == 4){

		var _list_beasts =
			global.list_logbook_beasts;

		var _ct_catalog =
			(
				ds_exists(
					_list_beasts,
					ds_type_list
				)
			)
			? ds_list_size(
				_list_beasts
			)
			: 0;

		var _ct_per_page = 24;

		var _it_max_page =
			hscr_cheats_get_max_page(
				_ct_catalog,
				_ct_per_page
			);

		_it_page =
			clamp(
				_it_page,
				0,
				_it_max_page
			);

		var _val_beast_list_y =
			_val_expanded_start_y + 26;

		var _val_beast_gap =
			6;

		var _val_beast_row_step =
			42;

		var _val_beast_button_w =
			(
				_val_content_w -
				(_val_beast_gap * 3)
			) / 4;

		for (
			var _i = 0;
			_i < _ct_per_page;
			_i++
		){
			var _index =
				(
					_it_page *
					_ct_per_page
				) +
				_i;

			if (_index >= _ct_catalog){
				break;
			}

			var _entry =
				ds_list_find_value(
					_list_beasts,
					_index
				);

			if (
				!is_struct(
					_entry
				) ||
				!variable_struct_exists(
					_entry,
					"_str_beast_id"
				)
			){
				continue;
			}

			var _str_beast_name =
				variable_struct_exists(
					_entry,
					"_str_beast_name"
				)
				? string(
					_entry
						._str_beast_name
				)
				: string(
					_entry
						._str_beast_id
				);

			var _str_beast_color =
				hscr_cheats_get_entry_color(
					_entry
				);

			var _col =
				_i mod 4;

			var _row =
				floor(
					_i / 4
				);

			var _bx1 =
				_val_left +
				(
					_col *
					(
						_val_beast_button_w +
						_val_beast_gap
					)
				);

			var _by1 =
				_val_beast_list_y +
				(
					_row *
					_val_beast_row_step
				);

			var _bx2 =
				_bx1 +
				_val_beast_button_w;

			var _by2 =
				_by1 + 34;

			var _flag_clicked =
				hscr_cheats_colored_button(
					_str_beast_name,
					_bx1,
					_by1,
					_bx2,
					_by2,
					_str_beast_color
				);

			var _val_mouse_x =
				device_mouse_x_to_gui(0);

			var _val_mouse_y =
				device_mouse_y_to_gui(0);

			if (
				hscr_cheats_point_in_rect(
					_val_mouse_x,
					_val_mouse_y,
					_bx1,
					_by1,
					_bx2,
					_by2
				)
			){
				hscr_cheats_set_hover_tooltip(
					"CHANGE TO " +
					_str_beast_name,
					"Transform a living enemy into this Beast. Current HP percentage, Armor, Overhealth, Statuses, Minions, Traps, and Elite state remain attached to the battle instance. The Beast's identity, stats, Ability, subtype, sounds, and Deck are rebuilt."
				);
			}

			if (_flag_clicked){

				hscr_cheats_start_tool(
					"CHANGE_BEAST",
					"CHANGE TO " +
					string_upper(
						_str_beast_name
					) +
					": CLICK ENEMY",
					"BATTLE_UNIT",
					_entry._str_beast_id
				);
			}
		}

		draw_set_colour(c_ltgray);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

		draw_text(
			_val_left,
			_val_footer_y,
			"CHANGE BEAST PAGE " +
			string(_it_page + 1) +
			"/" +
			string(_it_max_page + 1) +
			"   |   SELECT ONCE, APPLY REPEATEDLY   |   RMB: RETURN"
		);
	}

//===============================================================================//
// STAT EDITOR SUBMENU
//===============================================================================//
	else if (_it_submenu == 5){

		var _arr_stat_rows = [
			["HP","HP"],
			["CON","CON"],
			["PPOW","PPOW"],
			["MPOW","MPOW"],
			["PDEF","PDEF"],
			["MDEF","MDEF"],
			["SPEED","SPEED"],
			["CRIT","CRIT"],
			["CRIT DMG","CRIT_DMG"],
			["DODGE","DODGE"],
			["MINIONS","MIN"]
		];

		var _arr_stat_deltas = [-1,-5,-10,1,5,10];
		var _val_stat_list_y = _val_expanded_start_y + 20;
		var _val_stat_row_h = 27;
		var _val_stat_label_w = 92;
		var _val_stat_gap = 5;
		var _val_stat_button_w =
			(
				_val_content_w -
				_val_stat_label_w -
				(_val_stat_gap * 6)
			) / 6;

		draw_set_font(fnt_gui_party_small);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);

		for (var _it_stat = 0; _it_stat < array_length(_arr_stat_rows); _it_stat++){
			var _str_stat_label = _arr_stat_rows[_it_stat][0];
			var _str_stat_id = _arr_stat_rows[_it_stat][1];
			var _val_row_y = _val_stat_list_y + (_it_stat * _val_stat_row_h);

			draw_set_colour(c_white);
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);

			draw_text(
				_val_left + 4,
				_val_row_y + 12,
				_str_stat_label
			);

			for (var _it_delta = 0; _it_delta < array_length(_arr_stat_deltas); _it_delta++){
				var _val_delta = _arr_stat_deltas[_it_delta];
				var _val_bx1 =
					_val_left +
					_val_stat_label_w +
					_val_stat_gap +
					(_it_delta * (_val_stat_button_w + _val_stat_gap));

				var _str_delta_label =
					(_val_delta > 0 ? "+" : "") +
					string(_val_delta);

				if (hscr_cheats_button(
					_str_delta_label,
					_val_bx1,
					_val_row_y,
					_val_bx1 + _val_stat_button_w,
					_val_row_y + 23
				)){
					hscr_cheats_start_tool(
						"STAT_EDIT",
						_str_stat_label + " " + _str_delta_label + ": CLICK BEAST",
						"BATTLE_BEAST_STAT",
						_str_stat_id + "|" + string(_val_delta)
					);
				}
			}
		}

		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_colour(c_ltgray);
		draw_text(
			_val_left,
			_val_footer_y,
			"STAT EDITS ARE BATTLE-ONLY AND ROLLBACK ON BEAST CLEANUP   |   RMB: RETURN"
		);
	}
}

//===============================================================================//
// EVENTS / WEATHER
//===============================================================================//
else if (_it_tab == 1){

	var _val_gap = 24;

	var _val_column_w =
		(
			_val_content_w -
			_val_gap
		) * 0.5;

	var _val_weather_x =
		_val_left;

	var _val_event_x =
		_val_left +
		_val_column_w +
		_val_gap;

	draw_set_font(
		fnt_gui_party_small
	);

	draw_set_colour(c_white);
	draw_set_halign(fa_left);

	draw_text(
		_val_weather_x,
		_val_top,
		"WEATHER"
	);

	draw_text(
		_val_event_x,
		_val_top,
		"EVENTS"
	);

	var _val_event_team_y =
		_val_top + 22;

	draw_set_colour(c_ltgray);
	draw_text(
		_val_event_x,
		_val_event_team_y + 7,
		"OWNER: " +
		_str_selected_status_team
	);

	var _val_event_team_button_w = 92;
	var _val_event_team_player_x =
		_val_event_x + 90;

	if (
		hscr_cheats_button(
			"PLAYER TEAM",
			_val_event_team_player_x,
			_val_event_team_y,
			_val_event_team_player_x +
				_val_event_team_button_w,
			_val_event_team_y + 30
		)
	){
		_str_selected_status_team = "PLAYER";
	}

	var _val_event_team_enemy_x =
		_val_event_team_player_x +
		_val_event_team_button_w + 6;

	if (
		hscr_cheats_button(
			"ENEMY TEAM",
			_val_event_team_enemy_x,
			_val_event_team_y,
			_val_event_team_enemy_x +
				_val_event_team_button_w,
			_val_event_team_y + 30
		)
	){
		_str_selected_status_team = "ENEMY";
	}

//================//
//WEATHER//
//================//
	for (
		var _i = 0;
		_i < array_length(
			_arr_cheat_weather
		);
		_i++
	){

		var _by =
			_val_top +
			27 +
			(_i * 38);

		if (
			hscr_cheats_colored_button(
				_arr_cheat_weather[_i],
				_val_weather_x,
				_by,
				_val_weather_x +
					_val_column_w,
				_by + 30,
				hscr_cheats_get_environment_color_group(_arr_cheat_weather[_i])
			)
		){

			var _ref_weather_status =
				scr_status_apply_weather(
					_arr_cheat_weather[_i]
				);

			if (instance_exists(_ref_weather_status)){
				hscr_cheats_log(
					"WEATHER STARTED",
					"WEATHER: " +
					_arr_cheat_weather[_i]
				);
			}
			else{
				hscr_cheats_error(
					"WEATHER START FAILED",
					"WEATHER: " +
					_arr_cheat_weather[_i]
				);
			}
		}
	}

//================//
//EVENTS//
//================//
	for (
		var _i = 0;
		_i < array_length(
			_arr_cheat_events
		);
		_i++
	){

		var _event =
			_arr_cheat_events[_i];

		var _by =
			_val_top +
			64 +
			(_i * 38);

		if (
			hscr_cheats_colored_button(
				_event,
				_val_event_x,
				_by,
				_val_event_x +
					_val_column_w,
				_by + 30,
				hscr_cheats_get_environment_color_group(_event)
			)
		){

			var _ref_event_status =
				scr_status_apply_event(
					_event,
					undefined,
					_str_selected_status_team
				);

			if (instance_exists(_ref_event_status)){
				hscr_cheats_log(
					"EVENT STARTED",
					"EVENT: " +
						_event +
						" | OWNER CONTEXT: " +
						_str_selected_status_team
				);
			}
			else{
				hscr_cheats_error(
					"EVENT START FAILED",
					"EVENT: " +
						_event +
						" | OWNER CONTEXT: " +
						_str_selected_status_team
				);
			}
		}
	}
}

//===============================================================================//
// HAND
//===============================================================================//
else if (_it_tab == 2){

	draw_set_font(
		fnt_gui_party_small
	);

	draw_set_colour(c_white);
	draw_set_halign(fa_left);

	draw_text(
		_val_left,
		_val_top,
		"PLAYER HAND"
	);

	var _val_y =
		_val_top + 30;

	var _val_gap = 10;

	var _val_button_w =
		(
			_val_content_w -
			(_val_gap * 2)
		) / 3;

	if (
		hscr_cheats_button(
			"DRAW 1 CARD",
			_val_left,
			_val_y,
			_val_left +
			_val_button_w,
			_val_y + 38
		)
	){

		var _ct_drawn =
			scr_battle_draw_cards(1);

		if (_ct_drawn <= 0){

			hscr_cheats_error(
				"CARD DRAW FAILED",
				"NO CARD COULD BE DRAWN"
			);
		}
		else{

			hscr_cheats_log(
				"CARD DRAW CHEAT",
				"DRAWN: " +
				string(_ct_drawn)
			);
		}
	}

	if (
		hscr_cheats_button(
			"DISCARD CARD",
			_val_left +
			_val_button_w +
			_val_gap,
			_val_y,
			_val_left +
			(_val_button_w * 2) +
			_val_gap,
			_val_y + 38
		)
	){

		hscr_cheats_start_tool(
			"DISCARD_CARD",
			"DISCARD HAND CARD",
			"BATTLE_CARD"
		);
	}

	if (
		hscr_cheats_button(
			"EXHAUST CARD",
			_val_left +
			(_val_button_w * 2) +
			(_val_gap * 2),
			_val_y,
			_val_right,
			_val_y + 38
		)
	){

		hscr_cheats_start_tool(
			"EXHAUST_CARD",
			"EXHAUST HAND CARD",
			"BATTLE_CARD"
		);
	}
}

//===============================================================================//
// CAST SIMULATED CARD
//===============================================================================//
else if (_it_tab == 3){

	draw_set_font(fnt_gui_party_small);
	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	//================//
	//ECHO//
	//================//
	draw_text(_val_left,_val_top,"ECHO");

	var _val_echo_y = _val_top + 24;
	var _val_echo_label_w = 150;
	var _val_echo_button_w = 62;
	var _val_echo_gap = 6;

	var _ct_player_echo = hscr_cheats_get_echo_count("PLAYER");
	var _ct_enemy_echo = hscr_cheats_get_echo_count("ENEMY");

	draw_set_colour(c_ltgray);
	draw_text(
		_val_left,
		_val_echo_y + 8,
		"PLAYER ECHO: " + string(_ct_player_echo)
	);

	if (
		hscr_cheats_button(
			"-1",
			_val_left + _val_echo_label_w,
			_val_echo_y,
			_val_left + _val_echo_label_w + _val_echo_button_w,
			_val_echo_y + 30
		)
	){
		hscr_cheats_adjust_echo("PLAYER",-1);
	}

	if (
		hscr_cheats_button(
			"+1",
			_val_left + _val_echo_label_w + _val_echo_button_w + _val_echo_gap,
			_val_echo_y,
			_val_left + _val_echo_label_w + (_val_echo_button_w * 2) + _val_echo_gap,
			_val_echo_y + 30
		)
	){
		hscr_cheats_adjust_echo("PLAYER",1);
	}

	_val_echo_y += 36;

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_colour(c_ltgray);
	draw_text(
		_val_left,
		_val_echo_y + 8,
		"ENEMY ECHO: " + string(_ct_enemy_echo)
	);

	if (
		hscr_cheats_button(
			"-1",
			_val_left + _val_echo_label_w,
			_val_echo_y,
			_val_left + _val_echo_label_w + _val_echo_button_w,
			_val_echo_y + 30
		)
	){
		hscr_cheats_adjust_echo("ENEMY",-1);
	}

	if (
		hscr_cheats_button(
			"+1",
			_val_left + _val_echo_label_w + _val_echo_button_w + _val_echo_gap,
			_val_echo_y,
			_val_left + _val_echo_label_w + (_val_echo_button_w * 2) + _val_echo_gap,
			_val_echo_y + 30
		)
	){
		hscr_cheats_adjust_echo("ENEMY",1);
	}

	//================//
	//CASTING//
	//================//
	var _val_cast_header_y = _val_top + 110;
	var _val_cast_list_y = _val_cast_header_y + 24;

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_colour(c_white);
	draw_text(_val_left,_val_cast_header_y,"CASTING");

	var _arr_cards = _arr_cheat_cards_sorted;
	var _ct_catalog = array_length(_arr_cards);

	var _ct_cast_rows =
		max(
			1,
			floor(
				(
					_val_bottom -
					_val_cast_list_y -
					8
				) /
				_val_row_step
			)
		);

	var _it_max_page =
		hscr_cheats_get_max_page(
			_ct_catalog,
			_ct_cast_rows
		);

	_it_page = clamp(_it_page,0,_it_max_page);

	for (
		var _r = 0;
		_r < _ct_cast_rows;
		_r++
	){
		var _index =
			(_it_page * _ct_cast_rows) +
			_r;

		if (_index >= _ct_catalog){
			break;
		}

		var _entry = _arr_cards[_index];

		if (!is_struct(_entry)){
			continue;
		}

		var _y =
			_val_cast_list_y +
			(_r * _val_row_step);

		var _str_card_color =
			hscr_cheats_get_entry_color(
				_entry
			);

		var _c_card =
			hscr_cheats_get_color(
				_str_card_color
			);

		//----------------//
		//COLORED CARD ROW//
		//----------------//
		draw_set_colour(_c_card);
		draw_rectangle(
			_val_left,
			_y,
			_val_right,
			_y + _val_row_h,
			false
		);

		draw_set_colour(c_white);
		draw_rectangle(
			_val_left,
			_y,
			_val_right,
			_y + _val_row_h,
			true
		);

		//----------------//
		//CARD INFO TOOLTIP//
		//----------------//
		if (
			hscr_cheats_point_in_rect(
				_val_hover_mouse_x,
				_val_hover_mouse_y,
				_val_left,
				_y,
				_val_right,
				_y + _val_row_h
			)
		){
			var _str_card_tooltip = "DESCRIPTION UNAVAILABLE";

			if (
				variable_struct_exists(_entry,"_stct_card_info") &&
				is_struct(_entry._stct_card_info) &&
				variable_struct_exists(_entry._stct_card_info,"_str_card_description")
			){
				_str_card_tooltip =
					string(_entry._stct_card_info._str_card_description);
			}

			hscr_cheats_set_hover_tooltip(
				_entry._str_card_name,
				_str_card_tooltip
			);
		}

		//----------------//
		//CARD NAME//
		//----------------//
		draw_set_colour(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_text(
			_val_left + 10,
			_y + (_val_row_h * 0.5),
			string_upper(string(_entry._str_card_name))
		);

		//----------------//
		//CAST BUTTON//
		//----------------//
		var _val_cast_button_w = 92;

		var _flag_sim_cast_clicked =
			hscr_cheats_colored_button(
				"CAST",
				_val_right - _val_cast_button_w - 4,
				_y + 3,
				_val_right - 4,
				_y + _val_row_h - 3,
				_str_card_color
			);

		// The CAST control is part of this Card row. Re-register the Card tooltip
		// after drawing the button so hovering directly over CAST still exposes
		// the Card description rather than the generic CAST button tooltip.
		if (
			hscr_cheats_point_in_rect(
				_val_hover_mouse_x,
				_val_hover_mouse_y,
				_val_left,
				_y,
				_val_right,
				_y + _val_row_h
			)
		){
			hscr_cheats_set_hover_tooltip(
				_entry._str_card_name,
				_str_card_tooltip
			);
		}

		if (_flag_sim_cast_clicked){
			var _str_card_id =
				variable_struct_exists(_entry,"_str_card_id")
				? string(_entry._str_card_id)
				: string(_entry._str_card_name);

			hscr_cheats_start_tool(
				"SIMULATED_CAST",
				"CAST " + string_upper(_str_card_id) + ": SELECT CASTER",
				"SIMULATED_CARD_CASTER",
				_str_card_id
			);
		}
	}

	//================//
	//PAGE//
	//================//
	draw_set_colour(c_ltgray);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(
		_val_left,
		_val_footer_y,
		"PAGE " +
		string(_it_page + 1) +
		"/" +
		string(_it_max_page + 1)
	);
}

//===============================================================================//
// END BATTLE
//===============================================================================//
else if (_it_tab == 4){

	draw_set_font(fnt_gui_party_small);
	draw_set_colour(c_white);
	draw_set_halign(fa_left);

	draw_text(_val_left,_val_top,"BATTLE RESULT");

	draw_set_colour(c_ltgray);
	draw_text(_val_left,_val_top + 20,"FORCE AN OUTCOME OR CANCEL WITHOUT APPLYING WIN/LOSS RESULTS");

	var _val_y = _val_top + 50;
	var _val_gap = 10;
	var _val_button_w = (_val_content_w - (_val_gap * 2)) / 3;

	if (hscr_cheats_button(
		"WIN",
		_val_left,
		_val_y,
		_val_left + _val_button_w,
		_val_y + 46
	)){
		hscr_cheats_end_battle("WIN");
		exit;
	}

	if (hscr_cheats_button(
		"LOSS",
		_val_left + _val_button_w + _val_gap,
		_val_y,
		_val_left + (_val_button_w * 2) + _val_gap,
		_val_y + 46
	)){
		hscr_cheats_end_battle("LOSS");
		exit;
	}

	if (hscr_cheats_button(
		"CANCEL BATTLE",
		_val_left + (_val_button_w * 2) + (_val_gap * 2),
		_val_y,
		_val_right,
		_val_y + 46
	)){
		hscr_cheats_cancel_battle();
		exit;
	}
}

}

//===============================================================================//
// FOOTER
//===============================================================================//
draw_set_font(
	fnt_gui_party_small
);

draw_set_colour(c_ltgray);
draw_set_halign(fa_right);
draw_set_valign(fa_top);

draw_text(
	_val_right,
	_val_footer_y,
	"LEFT/RIGHT: TAB   UP/DOWN OR WHEEL: PAGE   CTRL: INFO   `: CLOSE"
);

//================//
//CTRL HOVER TOOLTIP//
//================//
/*
	Buttons populate _str_hover_tooltip_title/body while drawing.
	Render the final hovered control above the pane while Ctrl is held.
*/
hscr_cheats_draw_tooltip();

//================//
//RESET DRAW STATE//
//================//
draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
