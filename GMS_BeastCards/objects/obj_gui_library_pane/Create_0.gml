//===============================================================================//
//
// CREATE: OBJ_GUI_LIBRARY_PANE
// FUNCTION: Initializes the library GUI pane.
// Stores deck/library layout values, page arrow references, and click state.
// Defines local helper scripts for repeated card struct row logic.
//
//===============================================================================//

//
// VARIABLES
//
#region VARIABLES
depth = -1;

// COUNTS
_ct_deck = ds_list_size(global.player_deck);
_ct_library = ds_list_size(global.player_library);

// DECK / LIBRARY SETTINGS
_ct_deck_max = 30;
_str_type = "library";

// PANE LAYOUT
_val_pane_w = 800;
_val_pane_h = 800;
_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

// SLOT LAYOUT
_val_slot_h = 22;
_val_slot_margin = 2;
_val_slot_w = 370;

_val_deck_x = _val_pane_left + 15;
_val_library_x = x + 15;
_val_start_y = _val_pane_top + 20;

// PAGE SETTINGS
_ct_deck_visible = 30;
_ct_library_per_page = 30;
_val_library_page = 0;

_val_page_y = _val_pane_top + _val_pane_h - 35;
_val_page_center_x = _val_library_x + (_val_slot_w * 0.5);
_val_arrow_offset = 80;

// CARD PREVIEW / ICON
_stct_preview_card = undefined;
_val_card_icon_scale = 0.022;

// CLICK COOLDOWN
_flag_clicked = false;
_val_cooldown = 10;
#endregion

//
// INIT
//
#region INIT
_ref_left_arrow = instance_create_layer(_val_page_center_x - _val_arrow_offset,_val_page_y,"ily_fx",obj_gui_library_left_arrow);
_ref_left_arrow._ref_gui_pane = self;

_ref_right_arrow = instance_create_layer(_val_page_center_x + _val_arrow_offset,_val_page_y,"ily_fx",obj_gui_library_right_arrow);
_ref_right_arrow._ref_gui_pane = self;
#endregion

//
// METHODS
//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_get_card_color_text
// FUNCTION: Returns display text for a card color array.
//           Supports one-color and two-color cards.
//—------------------------------------------------------------------------------//
function hscr_get_card_color_text(_arr_colors){
	var _str_color_text = "";

	if (is_array(_arr_colors)){
		var _str_color_1 = string(_arr_colors[0]);

		if (array_length(_arr_colors) > 1 && _arr_colors[1] != undefined){
			var _str_color_2 = string(_arr_colors[1]);
			_str_color_text = _str_color_1 + " / " + _str_color_2;
		}
		else{
			_str_color_text = _str_color_1;
		}
	}
	else{
		_str_color_text = string(_arr_colors);
	}

	return _str_color_text;
}

//—------------------------------------------------------------------------------//
// hscr_draw_card_slot
// FUNCTION: Draws one deck or library row slot.
//—------------------------------------------------------------------------------//
function hscr_draw_card_slot(_val_box_x,_val_box_y){
	draw_set_colour(c_black);
	draw_rectangle(_val_box_x,_val_box_y,_val_box_x + _val_slot_w,_val_box_y + _val_slot_h,false);

	draw_set_colour(c_gray);
	draw_rectangle(_val_box_x + 2,_val_box_y + 2,_val_box_x + _val_slot_w - 2,_val_box_y + _val_slot_h - 2,false);
}

//—------------------------------------------------------------------------------//
// hscr_draw_card_info
// FUNCTION: Draws one card icon and compact card text.
//           Reads card data from a card struct.
//—------------------------------------------------------------------------------//
function hscr_draw_card_info(_stct_card,_val_box_x,_val_box_y){
	draw_sprite_ext(_stct_card.card_sprite,0,_val_box_x + 10,_val_box_y + 11,_val_card_icon_scale,_val_card_icon_scale,0,c_white,1);

	draw_set_colour(c_black);

	var _str_color_text = hscr_get_card_color_text(_stct_card.card_colors);
	var _str_display_text = _stct_card.card_name + " - " + _str_color_text + " - " + string(_stct_card.card_mana_cost);

	draw_text(_val_box_x + 24,_val_box_y + 3,_str_display_text);
}

//—------------------------------------------------------------------------------//
// hscr_is_mouse_in_slot
// FUNCTION: Returns true if the GUI mouse position is inside a card row slot.
//—------------------------------------------------------------------------------//
function hscr_is_mouse_in_slot(_val_mouse_x,_val_mouse_y,_val_box_x,_val_box_y){
	return (_val_mouse_x > _val_box_x && _val_mouse_x < _val_box_x + _val_slot_w && _val_mouse_y > _val_box_y && _val_mouse_y < _val_box_y + _val_slot_h);
}

//—------------------------------------------------------------------------------//
// hscr_draw_card_hover
// FUNCTION: Draws the hover highlight for a card row.
//           Queues the card preview while left control is held.
//—------------------------------------------------------------------------------//
function hscr_draw_card_hover(_stct_card,_val_box_x,_val_box_y){
	draw_sprite(spr_gui_library_highlight,0,_val_box_x + 185,_val_box_y + 11);

	if (keyboard_check(vk_lcontrol)){
		_stct_preview_card = _stct_card;
	}
}

//—------------------------------------------------------------------------------//
// hscr_get_average_deck_cost
// FUNCTION: Calculates the average mana cost of the current deck.
//           Reads card mana costs from card structs.
//—------------------------------------------------------------------------------//
function hscr_get_average_deck_cost(){
	var _val_total_cost = 0;

	for (var _it_card = 0; _it_card < _ct_deck; _it_card++){
		var _stct_card = ds_list_find_value(global.player_deck,_it_card);

		if (_stct_card != undefined){
			_val_total_cost += _stct_card.card_mana_cost;
		}
	}

	if (_ct_deck > 0){
		return _val_total_cost / _ct_deck;
	}

	return 0;
}

//—------------------------------------------------------------------------------//
// hscr_update_click_cooldown
// FUNCTION: Updates the card click cooldown.
//           Releases card clicking when cooldown reaches zero.
//—------------------------------------------------------------------------------//
function hscr_update_click_cooldown(){
	if (_flag_clicked){
		if (_val_cooldown > 0){
			_val_cooldown--;
		}
		else{
			_val_cooldown = 0;
			_flag_clicked = false;
		}
	}
}

#endregion