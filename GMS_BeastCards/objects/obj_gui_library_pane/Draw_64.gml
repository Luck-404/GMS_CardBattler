//===============================================================================//
//
// DRAW GUI: OBJ_GUI_LIBRARY_PANE
// FUNCTION: Draws independently paged Deck and Library columns, current Deck
//           capacity, average Mana cost, page indicators, and Ctrl-hover preview.
//
//===============================================================================//

draw_self();

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

_stct_preview_card =
	undefined;

var _val_mouse_x =
	device_mouse_x_to_gui(0);

var _val_mouse_y =
	device_mouse_y_to_gui(0);

var _ct_deck_pages =
	max(
		1,
		ceil(
			_ct_deck_cards /
			_ct_deck_per_page
		)
	);

var _ct_library_pages =
	max(
		1,
		ceil(
			_ct_library_cards /
			_ct_library_per_page
		)
	);

draw_set_font(fnt_gui_small);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(c_black);

draw_text(
	_val_deck_page_center_x,
	_val_pane_top - 14,
	"DECK " +
	string(_ct_deck_cards) +
	"/" +
	string(_ct_deck_max)
);

draw_text(
	_val_library_page_center_x,
	_val_pane_top - 14,
	"LIBRARY " +
	string(_ct_library_cards)
);

//================//
//DRAW DECK PAGE//
//================//
var _it_deck_start =
	_it_deck_page *
	_ct_deck_per_page;

var _it_deck_end =
	min(
		_ct_deck_cards,
		_it_deck_start +
			_ct_deck_per_page
	);

for (
	var _it_card = _it_deck_start;
	_it_card < _it_deck_end;
	_it_card++
){

	var _it_row =
		_it_card -
		_it_deck_start;

	var _val_box_y =
		_val_start_y +
		(
			_it_row *
			(
				_val_slot_h +
				_val_slot_margin
			)
		);

	var _stct_card =
		ds_list_find_value(
			global.list_player_deck,
			_it_card
		);

	if (!is_struct(_stct_card)){
		continue;
	}

	hscr_gui_library_draw_card_slot(
		_val_deck_x,
		_val_box_y
	);

	hscr_gui_library_draw_card_info(
		_stct_card,
		_val_deck_x,
		_val_box_y
	);

	if (
		hscr_gui_library_is_mouse_in_slot(
			_val_mouse_x,
			_val_mouse_y,
			_val_deck_x,
			_val_box_y
		)
	){

		hscr_gui_library_draw_card_hover(
			_stct_card,
			_val_deck_x,
			_val_box_y
		);
	}
}

//===================//
//DRAW LIBRARY PAGE//
//===================//
var _it_library_start =
	_it_library_page *
	_ct_library_per_page;

var _it_library_end =
	min(
		_ct_library_cards,
		_it_library_start +
			_ct_library_per_page
	);

for (
	var _it_card = _it_library_start;
	_it_card < _it_library_end;
	_it_card++
){

	var _it_row =
		_it_card -
		_it_library_start;

	var _val_box_y =
		_val_start_y +
		(
			_it_row *
			(
				_val_slot_h +
				_val_slot_margin
			)
		);

	var _stct_card =
		ds_list_find_value(
			global.list_player_library,
			_it_card
		);

	if (!is_struct(_stct_card)){
		continue;
	}

	hscr_gui_library_draw_card_slot(
		_val_library_x,
		_val_box_y
	);

	hscr_gui_library_draw_card_info(
		_stct_card,
		_val_library_x,
		_val_box_y
	);

	if (
		hscr_gui_library_is_mouse_in_slot(
			_val_mouse_x,
			_val_mouse_y,
			_val_library_x,
			_val_box_y
		)
	){

		hscr_gui_library_draw_card_hover(
			_stct_card,
			_val_library_x,
			_val_box_y
		);
	}
}

//================//
//PAGE INDICATORS//
//================//
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(c_black);

draw_text(
	_val_deck_page_center_x,
	_val_page_y,
	"PAGE " +
	string(_it_deck_page + 1) +
	"/" +
	string(_ct_deck_pages)
);

draw_text(
	_val_library_page_center_x,
	_val_page_y,
	"PAGE " +
	string(_it_library_page + 1) +
	"/" +
	string(_ct_library_pages)
);

draw_text(
	x,
	_val_pane_top + _val_pane_h + 18,
	"AVG DECK COST: " +
	string_format(
		hscr_gui_library_get_average_deck_cost(),
		1,
		1
	)
);

//================//
//CARD PREVIEW//
//================//
if (_stct_preview_card != undefined){

	draw_sprite_ext(
		_stct_preview_card._spr_card,
		0,
		display_get_gui_width() * 0.5,
		display_get_gui_height() * 0.5,
		1,
		1,
		0,
		c_white,
		1
	);
}

draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);