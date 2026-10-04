//===============================================================================//
//
// STEP: OBJ_GUI_LIBRARY_PANE
// FUNCTION: Updates dynamic Deck/Library counts, page bounds, arrow visibility,
//           and Card transfers between the two persistent collections.
//
//           The Deck may span multiple pages whenever its current size exceeds
//           the calculated per-page row capacity.
//
//===============================================================================//

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

_it_deck_page =
	clamp(
		_it_deck_page,
		0,
		_ct_deck_pages - 1
	);

_it_library_page =
	clamp(
		_it_library_page,
		0,
		_ct_library_pages - 1
	);

if (instance_exists(_ref_deck_left_arrow)){
	_ref_deck_left_arrow.visible =
		_ct_deck_pages > 1;
}

if (instance_exists(_ref_deck_right_arrow)){
	_ref_deck_right_arrow.visible =
		_ct_deck_pages > 1;
}

if (instance_exists(_ref_library_left_arrow)){
	_ref_library_left_arrow.visible =
		_ct_library_pages > 1;
}

if (instance_exists(_ref_library_right_arrow)){
	_ref_library_right_arrow.visible =
		_ct_library_pages > 1;
}

if (
	mouse_check_button_pressed(mb_left) &&
	!_flag_clicked
){

	var _val_mouse_x =
		device_mouse_x_to_gui(0);

	var _val_mouse_y =
		device_mouse_y_to_gui(0);

	//================//
	//DECK -> LIBRARY//
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

		if (
			!hscr_gui_library_is_mouse_in_slot(
				_val_mouse_x,
				_val_mouse_y,
				_val_deck_x,
				_val_box_y
			)
		){
			continue;
		}

		var _stct_card =
			ds_list_find_value(
				global.list_player_deck,
				_it_card
			);

		if (is_struct(_stct_card)){

			ds_list_delete(
				global.list_player_deck,
				_it_card
			);

			ds_list_add(
				global.list_player_library,
				_stct_card
			);

			audio_play_sound(
				snd_battle_card_move,
				0,
				false
			);

			_flag_clicked = true;
			_ct_cooldown = 10;
		}

		break;
	}

	//================//
	//LIBRARY -> DECK//
	//================//
	if (!_flag_clicked){

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

			if (
				!hscr_gui_library_is_mouse_in_slot(
					_val_mouse_x,
					_val_mouse_y,
					_val_library_x,
					_val_box_y
				)
			){
				continue;
			}

			if (
				ds_list_size(
					global.list_player_deck
				) >=
				_ct_deck_max
			){

				audio_play_sound(
					snd_gui_error,
					0,
					false
				);

				scr_gui_spawn_popup_error(
					"DECK FULL (" +
					string(_ct_deck_max) +
					")",
					60
				);

				_flag_clicked = true;
				_ct_cooldown = 10;

				break;
			}

			var _stct_card =
				ds_list_find_value(
					global.list_player_library,
					_it_card
				);

			if (is_struct(_stct_card)){

				ds_list_delete(
					global.list_player_library,
					_it_card
				);

				ds_list_add(
					global.list_player_deck,
					_stct_card
				);

				audio_play_sound(
					snd_battle_card_move,
					0,
					false
				);

				_flag_clicked = true;
				_ct_cooldown = 10;
			}

			break;
		}
	}
}

hscr_gui_library_update_click_cooldown();