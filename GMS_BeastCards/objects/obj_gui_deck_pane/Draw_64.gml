//===============================================================================//
//
// DRAW GUI: OBJ_GUI_DECK_PANE
// FUNCTION: Draws the current player Deck using the capacity-driven layout.
//           Supports display-only sorting by Name, Color, Mana Cost, or Exhaust.
//           Supports Ctrl-hover Card preview and displays current Deck capacity.
//
//===============================================================================//

draw_sprite(spr_gui_deck_pane,0,x,y);

hscr_gui_deck_recalculate_layout();
hscr_gui_deck_handle_sort_input();

var _stct_preview_card = undefined;
var _val_total_cost = 0;

var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

for (var _it_card = 0; _it_card < _ct_slots; _it_card++){

	var _it_col = _it_card mod _ct_cols;
	var _it_row = _it_card div _ct_cols;

	var _val_box_x =
		_val_grid_start_x +
		(
			_it_col *
			(
				_val_slot_w +
				_val_spacing_x
			)
		);

	var _val_box_y =
		_val_grid_start_y +
		(
			_it_row *
			(
				_val_slot_h +
				_val_spacing_y
			)
		);

	var _val_center_x = _val_box_x + (_val_slot_w * 0.5);
	var _val_center_y = _val_box_y + (_val_slot_h * 0.5);

	draw_set_colour(c_black);

	draw_rectangle(
		_val_box_x,
		_val_box_y,
		_val_box_x + _val_slot_w,
		_val_box_y + _val_slot_h,
		false
	);

	draw_set_colour(c_dkgray);

	draw_rectangle(
		_val_box_x + 3,
		_val_box_y + 3,
		_val_box_x + _val_slot_w - 3,
		_val_box_y + _val_slot_h - 3,
		false
	);

	if (_it_card >= _ct_cards){
		continue;
	}

	if (_it_card >= array_length(_arr_display_cards)){
		continue;
	}

	var _stct_card = _arr_display_cards[_it_card];

	if (!is_struct(_stct_card)){
		continue;
	}

	_val_total_cost += _stct_card._val_card_mana_cost;

	draw_sprite_ext(
		_stct_card._spr_card,
		0,
		_val_center_x,
		_val_center_y,
		_val_card_scale,
		_val_card_scale,
		0,
		c_white,
		1
	);

	if (
		_val_mouse_x > _val_box_x &&
		_val_mouse_x < _val_box_x + _val_slot_w &&
		_val_mouse_y > _val_box_y &&
		_val_mouse_y < _val_box_y + _val_slot_h
	){

		var _val_highlight_scale = _val_slot_w / _val_base_slot_w;

		draw_sprite_ext(
			spr_gui_deck_highlight,
			0,
			_val_center_x,
			_val_center_y,
			_val_highlight_scale,
			_val_highlight_scale,
			0,
			c_white,
			1
		);

		if (keyboard_check(vk_lcontrol)){
			_stct_preview_card = _stct_card;
		}
	}
}

draw_set_font(fnt_gui_medium);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(c_black);

draw_text(
	x,
	_val_pane_top + _val_pane_h + 24,
	"DECK: " +
	string(_ct_cards) +
	"/" +
	string(_ct_deck_max) +
	(
		_ct_cards > 0
		? " | AVG COST: " +
			string_format(
				_val_total_cost / _ct_cards,
				1,
				1
			)
		: ""
	)
);

hscr_gui_deck_draw_sort_control();

if (_stct_preview_card != undefined){

	draw_sprite_ext(
		_stct_preview_card._spr_card,
		0,
		display_get_gui_width() * 0.5,
		display_get_gui_height() * 0.5,
		_val_preview_scale,
		_val_preview_scale,
		0,
		c_white,
		1
	);
}

draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);