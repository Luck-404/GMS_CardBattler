//===============================================================================//
//
// CREATE: OBJ_GUI_LIBRARY_PANE
// FUNCTION: Initializes the Deck/Library management pane.
//
//           Deck and Library columns paginate independently. Page capacity is
//           calculated from the current pane height and row dimensions rather
//           than assuming the Deck can never exceed 30 Cards.
//
//===============================================================================//

#region VARIABLES

depth = -1;

_ct_deck_cards =
	ds_list_size(
		global.list_player_deck
	);

_ct_library_cards =
	ds_list_size(
		global.list_player_library
	);

_ct_deck_max =
	scr_deck_get_max_size();

_str_type = "library";

_val_pane_w = 800;
_val_pane_h = 800;
_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

_val_slot_h = 22;
_val_slot_margin = 2;
_val_slot_w = 370;

_val_deck_x =
	_val_pane_left + 15;

_val_library_x =
	x + 15;

_val_start_y =
	_val_pane_top + 20;

_val_page_y =
	_val_pane_top +
	_val_pane_h -
	35;

_val_arrow_offset = 80;

_ct_rows_per_page =
	max(
		1,
		floor(
			(
				_val_page_y -
				_val_start_y -
				20
			) /
			(
				_val_slot_h +
				_val_slot_margin
			)
		)
	);

_ct_deck_per_page =
	_ct_rows_per_page;

_ct_library_per_page =
	_ct_rows_per_page;

_it_deck_page = 0;
_it_library_page = 0;

_val_deck_page_center_x =
	_val_deck_x +
	(_val_slot_w * 0.5);

_val_library_page_center_x =
	_val_library_x +
	(_val_slot_w * 0.5);

_stct_preview_card = undefined;
_val_card_icon_scale = 0.022;

_flag_clicked = false;
_ct_cooldown = 10;

#endregion

#region INIT

_ref_deck_left_arrow =
	instance_create_layer(
		_val_deck_page_center_x -
			_val_arrow_offset,
		_val_page_y,
		"ily_fx",
		obj_gui_library_left_arrow
	);

_ref_deck_left_arrow._ref_gui_pane =
	self;

_ref_deck_left_arrow._str_page_target =
	"DECK";

_ref_deck_right_arrow =
	instance_create_layer(
		_val_deck_page_center_x +
			_val_arrow_offset,
		_val_page_y,
		"ily_fx",
		obj_gui_library_right_arrow
	);

_ref_deck_right_arrow._ref_gui_pane =
	self;

_ref_deck_right_arrow._str_page_target =
	"DECK";

_ref_library_left_arrow =
	instance_create_layer(
		_val_library_page_center_x -
			_val_arrow_offset,
		_val_page_y,
		"ily_fx",
		obj_gui_library_left_arrow
	);

_ref_library_left_arrow._ref_gui_pane =
	self;

_ref_library_left_arrow._str_page_target =
	"LIBRARY";

_ref_library_right_arrow =
	instance_create_layer(
		_val_library_page_center_x +
			_val_arrow_offset,
		_val_page_y,
		"ily_fx",
		obj_gui_library_right_arrow
	);

_ref_library_right_arrow._ref_gui_pane =
	self;

_ref_library_right_arrow._str_page_target =
	"LIBRARY";

#endregion

#region METHODS

hscr_gui_library_get_card_color_text = function(_arr_colors){

	var _str_color_text = "";

	if (is_array(_arr_colors)){

		var _str_color_1 =
			string(
				_arr_colors[0]
			);

		if (
			array_length(_arr_colors) > 1 &&
			_arr_colors[1] != undefined
		){

			_str_color_text =
				_str_color_1 +
				" / " +
				string(
					_arr_colors[1]
				);
		}
		else{
			_str_color_text =
				_str_color_1;
		}
	}
	else{
		_str_color_text =
			string(
				_arr_colors
			);
	}

	return _str_color_text;
};

hscr_gui_library_draw_card_slot = function(_val_box_x,_val_box_y){

	draw_set_colour(c_black);

	draw_rectangle(
		_val_box_x,
		_val_box_y,
		_val_box_x + _val_slot_w,
		_val_box_y + _val_slot_h,
		false
	);

	draw_set_colour(global.c_dk_gray);

	draw_rectangle(
		_val_box_x + 2,
		_val_box_y + 2,
		_val_box_x + _val_slot_w - 2,
		_val_box_y + _val_slot_h - 2,
		false
	);
};

hscr_gui_library_draw_card_info = function(_stct_card,_val_box_x,_val_box_y){

	draw_sprite_ext(
		_stct_card._spr_card,
		0,
		_val_box_x + 10,
		_val_box_y + 11,
		_val_card_icon_scale,
		_val_card_icon_scale,
		0,
		c_white,
		1
	);

	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	var _str_color_text =
		hscr_gui_library_get_card_color_text(
			_stct_card._arr_card_colors
		);

	draw_text(
		_val_box_x + 24,
		_val_box_y + 3,
		_stct_card._str_card_name +
		" - " +
		_str_color_text +
		" - " +
		string(
			_stct_card._val_card_mana_cost
		)
	);
};

hscr_gui_library_is_mouse_in_slot = function(_val_mouse_x,_val_mouse_y,_val_box_x,_val_box_y){

	return (
		_val_mouse_x > _val_box_x &&
		_val_mouse_x < _val_box_x + _val_slot_w &&
		_val_mouse_y > _val_box_y &&
		_val_mouse_y < _val_box_y + _val_slot_h
	);
};

hscr_gui_library_draw_card_hover = function(_stct_card,_val_box_x,_val_box_y){

	draw_sprite(
		spr_gui_library_highlight,
		0,
		_val_box_x + (_val_slot_w * 0.5),
		_val_box_y + (_val_slot_h * 0.5)
	);

	if (keyboard_check(vk_lcontrol)){
		_stct_preview_card =
			_stct_card;
	}
};

hscr_gui_library_get_average_deck_cost = function(){

	var _val_total_cost = 0;

	for (
		var _it_card = 0;
		_it_card < _ct_deck_cards;
		_it_card++
	){

		var _stct_card =
			ds_list_find_value(
				global.list_player_deck,
				_it_card
			);

		if (is_struct(_stct_card)){
			_val_total_cost +=
				_stct_card._val_card_mana_cost;
		}
	}

	if (_ct_deck_cards > 0){
		return _val_total_cost / _ct_deck_cards;
	}

	return 0;
};

hscr_gui_library_update_click_cooldown = function(){

	if (!_flag_clicked){
		return;
	}

	if (_ct_cooldown > 0){
		_ct_cooldown--;
	}
	else{
		_ct_cooldown = 0;
		_flag_clicked = false;
	}
};

#endregion