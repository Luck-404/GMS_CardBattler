//===============================================================================//
//
// CREATE: OBJ_GUI_DECK_PANE
// FUNCTION: Initializes the Deck GUI pane.
//           Builds a sortable display copy of the persistent player Deck.
//           The grid is capacity-driven and supports Deck capacities above 30.
//
//===============================================================================//

#region VARIABLES

depth = -1;

_ct_cards = ds_list_size(global.list_player_deck);
_ct_deck_max = scr_deck_get_max_size();
_ct_deck_seen = -1;

_str_type = "DECK";
_str_sort_mode = "NAME";

_arr_display_cards = [];

_val_pane_w = 800;
_val_pane_h = 800;
_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

_val_base_slot_w = 104;
_val_base_slot_h = 145;
_val_base_spacing_x = 10;
_val_base_spacing_y = 10;
_val_base_card_scale = 0.23;

_val_available_grid_w = 780;
_val_available_grid_h = 765;

_ct_cols = 6;
_ct_rows = 5;
_ct_slots = 30;

_val_slot_w = _val_base_slot_w;
_val_slot_h = _val_base_slot_h;
_val_spacing_x = _val_base_spacing_x;
_val_spacing_y = _val_base_spacing_y;

_val_grid_w = 0;
_val_grid_h = 0;
_val_grid_start_x = x;
_val_grid_start_y = y;

_val_card_scale = _val_base_card_scale;
_val_preview_scale = 1.0;

_val_sort_w = 200;
_val_sort_h = 25;
_val_sort_x = _val_pane_left + 20;
_val_sort_y = _val_pane_top + _val_pane_h + 12;

#endregion

#region INIT

#endregion

#region METHODS

//-------------------------------------------------------------------------------//
// HSCR_GUI_DECK_GET_CARD_NAME
// FUNCTION: Returns a normalized Card name for sorting.
//-------------------------------------------------------------------------------//
hscr_gui_deck_get_card_name = function(_stct_card){

	if (!is_struct(_stct_card)){
		return "";
	}

	if (!variable_struct_exists(_stct_card,"_str_card_name")){
		return "";
	}

	return string_lower(string(_stct_card._str_card_name));
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_DECK_GET_PRIMARY_COLOR
// FUNCTION: Returns the Card's normalized primary color for sorting.
//-------------------------------------------------------------------------------//
hscr_gui_deck_get_primary_color = function(_stct_card){

	if (!is_struct(_stct_card)){
		return "ZZZ";
	}

	if (
		!variable_struct_exists(_stct_card,"_arr_card_colors") ||
		!is_array(_stct_card._arr_card_colors) ||
		array_length(_stct_card._arr_card_colors) <= 0
	){
		return "ZZZ";
	}

	var _str_color = _stct_card._arr_card_colors[0];

	if (_str_color == undefined){
		return "ZZZ";
	}

	return string_lower(string(_str_color));
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_DECK_SHOULD_SWAP
// FUNCTION: Returns whether two display Cards should swap under the active sort.
//-------------------------------------------------------------------------------//
hscr_gui_deck_should_swap = function(_stct_a,_stct_b){

	if (!is_struct(_stct_a)){
		return is_struct(_stct_b);
	}

	if (!is_struct(_stct_b)){
		return false;
	}

	var _str_name_a = hscr_gui_deck_get_card_name(_stct_a);
	var _str_name_b = hscr_gui_deck_get_card_name(_stct_b);

	switch (_str_sort_mode){

		case "NAME":
			return _str_name_a > _str_name_b;

		case "COLOR":

			var _str_color_a = hscr_gui_deck_get_primary_color(_stct_a);
			var _str_color_b = hscr_gui_deck_get_primary_color(_stct_b);

			if (_str_color_a != _str_color_b){
				return _str_color_a > _str_color_b;
			}

			return _str_name_a > _str_name_b;

		case "MANA COST":

			var _val_mana_a = _stct_a._val_card_mana_cost;
			var _val_mana_b = _stct_b._val_card_mana_cost;

			if (_val_mana_a != _val_mana_b){
				return _val_mana_a > _val_mana_b;
			}

			return _str_name_a > _str_name_b;

		case "EXHAUSTS":

			var _flag_exhaust_a = _stct_a._flag_card_exhausts;
			var _flag_exhaust_b = _stct_b._flag_card_exhausts;

			if (_flag_exhaust_a != _flag_exhaust_b){
				return !_flag_exhaust_a && _flag_exhaust_b;
			}

			return _str_name_a > _str_name_b;
	}

	return false;
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_DECK_SORT_DISPLAY
// FUNCTION: Sorts the Deck pane's display-only Card array.
//           Does not modify global.list_player_deck.
//-------------------------------------------------------------------------------//
hscr_gui_deck_sort_display = function(){

	var _ct_display_cards = array_length(_arr_display_cards);

	for (var _it_a = 0; _it_a < _ct_display_cards - 1; _it_a++){

		for (var _it_b = _it_a + 1; _it_b < _ct_display_cards; _it_b++){

			var _stct_a = _arr_display_cards[_it_a];
			var _stct_b = _arr_display_cards[_it_b];

			if (!hscr_gui_deck_should_swap(_stct_a,_stct_b)){
				continue;
			}

			_arr_display_cards[_it_a] = _stct_b;
			_arr_display_cards[_it_b] = _stct_a;
		}
	}
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_DECK_REFRESH_DISPLAY
// FUNCTION: Rebuilds the display-only Card array from the persistent Deck.
//-------------------------------------------------------------------------------//
hscr_gui_deck_refresh_display = function(){

	_ct_cards = ds_list_size(global.list_player_deck);

	_arr_display_cards = [];

	for (var _it_card = 0; _it_card < _ct_cards; _it_card++){

		array_push(
			_arr_display_cards,
			ds_list_find_value(global.list_player_deck,_it_card)
		);
	}

	_ct_deck_seen = _ct_cards;

	hscr_gui_deck_sort_display();
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_DECK_CYCLE_SORT
// FUNCTION: Advances the Deck display through its four available sort modes.
//-------------------------------------------------------------------------------//
hscr_gui_deck_cycle_sort = function(){

	switch (_str_sort_mode){

		case "NAME":
			_str_sort_mode = "COLOR";
		break;

		case "COLOR":
			_str_sort_mode = "MANA COST";
		break;

		case "MANA COST":
			_str_sort_mode = "EXHAUSTS";
		break;

		case "EXHAUSTS":
			_str_sort_mode = "NAME";
		break;

		default:
			_str_sort_mode = "NAME";
		break;
	}

	hscr_gui_deck_refresh_display();

	audio_play_sound(snd_gui_press,0,false);

	scr_debug_log(
		"GUI",
		"DECK",
		self,
		"DECK SORT CHANGED | MODE: " + _str_sort_mode,
		"INFO",
		"OBJ_GUI_DECK_PANE:HSCR_GUI_DECK_CYCLE_SORT"
	);
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_DECK_HANDLE_SORT_INPUT
// FUNCTION: Handles clicking the Deck sort control.
//-------------------------------------------------------------------------------//
hscr_gui_deck_handle_sort_input = function(){

	var _val_mouse_x = device_mouse_x_to_gui(0);
	var _val_mouse_y = device_mouse_y_to_gui(0);

	var _flag_sort_hover =
		_val_mouse_x > _val_sort_x &&
		_val_mouse_x < _val_sort_x + _val_sort_w &&
		_val_mouse_y > _val_sort_y &&
		_val_mouse_y < _val_sort_y + _val_sort_h;

	if (
		_flag_sort_hover &&
		mouse_check_button_pressed(mb_left)
	){
		hscr_gui_deck_cycle_sort();
	}
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_DECK_DRAW_SORT_CONTROL
// FUNCTION: Draws the active Deck sorting mode and hover feedback.
//-------------------------------------------------------------------------------//
hscr_gui_deck_draw_sort_control = function(){

	var _val_mouse_x = device_mouse_x_to_gui(0);
	var _val_mouse_y = device_mouse_y_to_gui(0);

	var _flag_sort_hover =
		_val_mouse_x > _val_sort_x &&
		_val_mouse_x < _val_sort_x + _val_sort_w &&
		_val_mouse_y > _val_sort_y &&
		_val_mouse_y < _val_sort_y + _val_sort_h;

	draw_set_font(fnt_gui_small);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);

	draw_set_colour(_flag_sort_hover ? c_white : global.c_dk_gray);

	draw_rectangle(
		_val_sort_x,
		_val_sort_y,
		_val_sort_x + _val_sort_w,
		_val_sort_y + _val_sort_h,
		false
	);

	draw_set_colour(c_black);

	draw_text(
		_val_sort_x + 5,
		_val_sort_y + (_val_sort_h * 0.5),
		"SORT: " + _str_sort_mode
	);

	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_DECK_RECALCULATE_LAYOUT
// FUNCTION: Recalculates capacity-driven Deck grid dimensions and Card scale.
//-------------------------------------------------------------------------------//
hscr_gui_deck_recalculate_layout = function(){

	_ct_cards = ds_list_size(global.list_player_deck);
	_ct_deck_max = scr_deck_get_max_size();

	if (_ct_cards != _ct_deck_seen){
		hscr_gui_deck_refresh_display();
	}

	_ct_slots = max(
		1,
		max(
			_ct_cards,
			_ct_deck_max
		)
	);

	var _val_best_scale = 0;
	var _ct_best_cols = 1;
	var _ct_best_rows = _ct_slots;
	var _ct_best_unused = 999999;

	for (var _ct_test_cols = 1; _ct_test_cols <= _ct_slots; _ct_test_cols++){

		var _ct_test_rows = ceil(_ct_slots / _ct_test_cols);

		var _val_test_w =
			(_ct_test_cols * _val_base_slot_w) +
			(max(0,_ct_test_cols - 1) * _val_base_spacing_x);

		var _val_test_h =
			(_ct_test_rows * _val_base_slot_h) +
			(max(0,_ct_test_rows - 1) * _val_base_spacing_y);

		var _val_test_scale = min(
			1,
			min(
				_val_available_grid_w / max(1,_val_test_w),
				_val_available_grid_h / max(1,_val_test_h)
			)
		);

		var _ct_unused =
			(_ct_test_cols * _ct_test_rows) -
			_ct_slots;

		if (
			_val_test_scale > _val_best_scale ||
			(
				abs(_val_test_scale - _val_best_scale) < 0.0001 &&
				_ct_unused < _ct_best_unused
			)
		){

			_val_best_scale = _val_test_scale;
			_ct_best_cols = _ct_test_cols;
			_ct_best_rows = _ct_test_rows;
			_ct_best_unused = _ct_unused;
		}
	}

	_ct_cols = _ct_best_cols;
	_ct_rows = _ct_best_rows;

	_val_slot_w = _val_base_slot_w * _val_best_scale;
	_val_slot_h = _val_base_slot_h * _val_best_scale;

	_val_spacing_x = _val_base_spacing_x * _val_best_scale;
	_val_spacing_y = _val_base_spacing_y * _val_best_scale;

	_val_card_scale = _val_base_card_scale * _val_best_scale;

	_val_grid_w =
		(_ct_cols * _val_slot_w) +
		(max(0,_ct_cols - 1) * _val_spacing_x);

	_val_grid_h =
		(_ct_rows * _val_slot_h) +
		(max(0,_ct_rows - 1) * _val_spacing_y);

	_val_grid_start_x = x - (_val_grid_w * 0.5);
	_val_grid_start_y = y - (_val_grid_h * 0.5);
};

hscr_gui_deck_refresh_display();
hscr_gui_deck_recalculate_layout();

#endregion