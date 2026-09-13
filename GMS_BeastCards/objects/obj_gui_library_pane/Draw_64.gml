//===============================================================================//
//
// DRAW GUI: OBJ_GUI_LIBRARY_PANE
// FUNCTION: Draws the player's deck and library card lists.
//           Handles card movement between deck/library and card deletion.
//           Draws deck average cost, page display, click cooldown, and card
//           preview.
//
//===============================================================================//

draw_self();

//================//
//SETUP//
//================//
#region SETUP

_stct_preview_card = undefined;

_ct_deck_cards = ds_list_size(global.list_player_deck);
_ct_library_cards = ds_list_size(global.list_player_library);

var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

#endregion

//================//
//HEADER//
//================//
#region HEADER

draw_set_font(fnt_gui_medium);
draw_set_colour(c_white);

draw_text(
	_val_pane_left + 135,
	_val_pane_top - 25,
	"DECK"
);

draw_text(
	_val_pane_left + 575,
	_val_pane_top - 25,
	"LIBRARY"
);

draw_set_font(fnt_gui_small);

#endregion

//================//
//DRAW DECK//
//================//
#region DRAW DECK

for (var _it_card = 0;_it_card < _ct_deck_visible;_it_card++){

	var _stct_card = ds_list_find_value(global.list_player_deck,_it_card);
	var _val_box_x = _val_deck_x;
	var _val_box_y = _val_start_y + (_it_card * (_val_slot_h + _val_slot_margin));

	hscr_gui_library_draw_card_slot(
		_val_box_x,
		_val_box_y
	);

	if (_stct_card != undefined){

		hscr_gui_library_draw_card_info(
			_stct_card,
			_val_box_x,
			_val_box_y
		);

		if (hscr_gui_library_is_mouse_in_slot(_val_mouse_x,_val_mouse_y,_val_box_x,_val_box_y)){

			hscr_gui_library_draw_card_hover(
				_stct_card,
				_val_box_x,
				_val_box_y
			);

			if (mouse_check_button_pressed(mb_left) && !_flag_clicked && _ct_deck_cards > 1){

				audio_play_sound(
					snd_battle_card_move,
					0,
					false
				);

				_flag_clicked = true;
				_ct_cooldown = 10;

				ds_list_add(
					global.list_player_library,
					_stct_card
				);

				ds_list_delete(
					global.list_player_deck,
					_it_card
				);
				
			//================//
			//DEBUG TRANSFER//
			//================//
			scr_debug_log(
				"CARDS",
				"LIBRARY",
				undefined,
				string_upper(_stct_card._str_card_name) +
				" MOVED FROM DECK TO LIBRARY" +
				" | DECK: " +
				string(ds_list_size(global.list_player_deck)) +
				"/30" +
				" | LIBRARY: " +
				string(ds_list_size(global.list_player_library)),
				"INFO",
				"OBJ_GUI_LIBRARY_PANE"
			);				
			
			}
		}
	}
}

#endregion

//================//
//DRAW LIBRARY//
//================//
#region DRAW LIBRARY

var _it_start_index = _it_library_page * _ct_library_per_page;

for (var _it_card = 0;_it_card < _ct_library_per_page;_it_card++){

	var _it_library_index = _it_start_index + _it_card;
	var _stct_card = ds_list_find_value(global.list_player_library,_it_library_index);
	var _val_box_x = _val_library_x;
	var _val_box_y = _val_start_y + (_it_card * (_val_slot_h + _val_slot_margin));

	hscr_gui_library_draw_card_slot(
		_val_box_x,
		_val_box_y
	);

	if (_stct_card != undefined){

		hscr_gui_library_draw_card_info(
			_stct_card,
			_val_box_x,
			_val_box_y
		);

		if (hscr_gui_library_is_mouse_in_slot(_val_mouse_x,_val_mouse_y,_val_box_x,_val_box_y)){

			hscr_gui_library_draw_card_hover(
				_stct_card,
				_val_box_x,
				_val_box_y
			);

			if (mouse_check_button_pressed(mb_left) && !_flag_clicked && _ct_deck_cards < _ct_deck_max){

				audio_play_sound(
					snd_battle_card_move,
					0,
					false
				);

				_flag_clicked = true;
				_ct_cooldown = 10;

				ds_list_add(
					global.list_player_deck,
					_stct_card
				);

				ds_list_delete(
					global.list_player_library,
					_it_library_index
				);
				
				//================//
				//DEBUG TRANSFER//
				//================//
				scr_debug_log(
					"CARDS",
					"DECK",
					undefined,
					string_upper(_stct_card._str_card_name) +
					" MOVED FROM LIBRARY TO DECK" +
					" | DECK: " +
					string(ds_list_size(global.list_player_deck)) +
					"/30" +
					" | LIBRARY: " +
					string(ds_list_size(global.list_player_library)),
					"INFO",
					"OBJ_GUI_LIBRARY_PANE"
				);	
				
			}

			if (keyboard_check_pressed(vk_delete) && !_flag_clicked){

				audio_play_sound(
					snd_gui_destroy,
					0,
					false
				);

				_flag_clicked = true;
				_ct_cooldown = 10;

				ds_list_delete(
					global.list_player_library,
					_it_library_index
				);
			}
		}
	}
}

#endregion

//================//
//AVERAGE DECK COST//
//================//
#region AVERAGE DECK COST

var _val_avg_cost = hscr_gui_library_get_average_deck_cost();

draw_set_colour(c_black);

draw_text(
	_val_deck_x,
	_val_pane_top + _val_pane_h - 30,
	"AVG COST: " + string_format(_val_avg_cost,1,2)
);

#endregion

//================//
//PAGE DISPLAY//
//================//
#region PAGE DISPLAY

var _ct_total_pages = max(
	1,
	ceil(_ct_library_cards / _ct_library_per_page)
);

draw_set_halign(fa_center);
draw_set_colour(c_black);

draw_text(
	_val_page_center_x,
	_val_page_y,
	"PAGE " + string(_it_library_page + 1) + "/" + string(_ct_total_pages)
);

draw_set_halign(fa_left);

#endregion

//================//
//CLICK COOLDOWN//
//================//
#region CLICK COOLDOWN

hscr_gui_library_update_click_cooldown();

#endregion

//================//
//PREVIEW CARD//
//================//
#region PREVIEW CARD

if (_stct_preview_card != undefined){

	var _val_gui_center_x = display_get_gui_width() * 0.5;
	var _val_gui_center_y = display_get_gui_height() * 0.5;

	draw_sprite_ext(
		_stct_preview_card._spr_card,
		0,
		_val_gui_center_x,
		_val_gui_center_y,
		0.95,
		0.95,
		0,
		c_white,
		1
	);
}

#endregion