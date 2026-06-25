//===============================================================================//
//
// DRAW GUI: OBJ_GUI_LIBRARY_PANE
// FUNCTION: Draws the player's deck and library card lists.
// Handles card movement between deck/library and card deletion.
// Draws deck average cost, page display, click cooldown, and card preview.
//
//===============================================================================//

draw_self();

//
// SETUP
//
#region SETUP
_stct_preview_card = undefined;

_ct_deck = ds_list_size(global.player_deck);
_ct_library = ds_list_size(global.player_library);

var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);
#endregion

//
// HEADER
//
#region HEADER
draw_set_font(fnt_medium_gui);
draw_set_colour(c_white);

draw_text(_val_pane_left + 135,_val_pane_top - 25,"DECK");
draw_text(_val_pane_left + 575,_val_pane_top - 25,"LIBRARY");

draw_set_font(fnt_small_gui);
#endregion

//
// DECK
//
#region DRAW DECK
for (var _it_card = 0; _it_card < _ct_deck_visible; _it_card++){
	var _stct_card = ds_list_find_value(global.player_deck,_it_card);

	var _val_box_x = _val_deck_x;
	var _val_box_y = _val_start_y + (_it_card * (_val_slot_h + _val_slot_margin));

	hscr_draw_card_slot(_val_box_x,_val_box_y);

	if (_stct_card != undefined){
		hscr_draw_card_info(_stct_card,_val_box_x,_val_box_y);

		if (hscr_is_mouse_in_slot(_val_mouse_x,_val_mouse_y,_val_box_x,_val_box_y)){
			hscr_draw_card_hover(_stct_card,_val_box_x,_val_box_y);

			if (mouse_check_button_pressed(mb_left) && !_flag_clicked && _ct_deck > 1){
				_flag_clicked = true;
				_val_cooldown = 10;

				ds_list_add(global.player_library,_stct_card);
				ds_list_delete(global.player_deck,_it_card);
			}
		}
	}
}
#endregion

//
// LIBRARY
//
#region DRAW LIBRARY
var _val_start_index = _val_library_page * _ct_library_per_page;

for (var _it_card = 0; _it_card < _ct_library_per_page; _it_card++){
	var _val_library_index = _val_start_index + _it_card;
	var _stct_card = ds_list_find_value(global.player_library,_val_library_index);

	var _val_box_x = _val_library_x;
	var _val_box_y = _val_start_y + (_it_card * (_val_slot_h + _val_slot_margin));

	hscr_draw_card_slot(_val_box_x,_val_box_y);

	if (_stct_card != undefined){
		hscr_draw_card_info(_stct_card,_val_box_x,_val_box_y);

		if (hscr_is_mouse_in_slot(_val_mouse_x,_val_mouse_y,_val_box_x,_val_box_y)){
			hscr_draw_card_hover(_stct_card,_val_box_x,_val_box_y);

			if (mouse_check_button_pressed(mb_left) && !_flag_clicked && _ct_deck < _ct_deck_max){
				_flag_clicked = true;
				_val_cooldown = 10;

				ds_list_add(global.player_deck,_stct_card);
				ds_list_delete(global.player_library,_val_library_index);
			}

			if (keyboard_check_pressed(vk_delete) && !_flag_clicked){
				_flag_clicked = true;
				_val_cooldown = 10;

				ds_list_delete(global.player_library,_val_library_index);
			}
		}
	}
}
#endregion

//
// AVERAGE DECK COST
//
#region AVERAGE DECK COST
var _val_avg_cost = hscr_get_average_deck_cost();

draw_set_colour(c_black);
draw_text(_val_deck_x,_val_pane_top + _val_pane_h - 30,"AVG COST: " + string_format(_val_avg_cost,1,2));
#endregion

//
// PAGE DISPLAY
//
#region PAGE DISPLAY
var _ct_total_pages = max(1,ceil(_ct_library / _ct_library_per_page));

draw_set_halign(fa_center);
draw_set_colour(c_black);
draw_text(_val_page_center_x,_val_page_y,"PAGE " + string(_val_library_page + 1) + "/" + string(_ct_total_pages));

draw_set_halign(fa_left);
#endregion

//
// CLICK COOLDOWN
//
#region CLICK COOLDOWN
hscr_update_click_cooldown();
#endregion

//
// PREVIEW CARD
//
#region PREVIEW CARD
if (_stct_preview_card != undefined){
	draw_sprite_ext(_stct_preview_card.card_sprite,0,room_width * 0.5,room_height * 0.5,0.95,0.95,0,c_white,1);
}
#endregion