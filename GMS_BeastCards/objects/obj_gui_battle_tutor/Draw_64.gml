//===============================================================================//
//
// DRAW GUI: OBJ_GUI_BATTLE_TUTOR
// FUNCTION: Draws Utility cards available in the player's draw pile.
//           Highlights hovered entries.
//           Draws the selected card and resolves queued Tutor selections.
//
//===============================================================================//

//----------------//
//BACKGROUND SHADE//
//----------------//
draw_set_alpha(0.65);
draw_set_colour(c_black);

draw_rectangle(
	0,
	0,
	display_get_gui_width(),
	display_get_gui_height(),
	false
);

draw_set_alpha(1);

//----//
//PANE//
//----//
draw_set_colour(c_black);

draw_rectangle(
	_val_pane_left,
	_val_pane_top,
	_val_pane_left + _val_pane_w,
	_val_pane_top + _val_pane_h,
	false
);

draw_set_colour(global.c_dk_gray);

draw_rectangle(
	_val_pane_left + 4,
	_val_pane_top + 4,
	_val_pane_left + _val_pane_w - 4,
	_val_pane_top + _val_pane_h - 4,
	false
);

//------//
//HEADER//
//------//
draw_set_font(fnt_medium_gui);
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

draw_text(
	x,
	_val_pane_top + 20,
	"ANCIENT CHARTS"
);

draw_set_font(fnt_small_gui);

draw_text(
	x,
	_val_pane_top + 48,
	"SELECT A UTILITY CARD"
);

draw_set_halign(fa_left);

//-------//
//MOUSE//
//-------//
var _val_mouse_x =
	device_mouse_x_to_gui(0);

var _val_mouse_y =
	device_mouse_y_to_gui(0);

//------------//
//DRAW CARDS//
//------------//
for (
	var _it_card = 0;
	_it_card < array_length(_arr_tutor_cards);
	_it_card++
){

	var _ref_card =
		_arr_tutor_cards[_it_card];

	if (!instance_exists(_ref_card)){
		continue;
	}

	if (_ref_card._str_location != "DECK"){
		continue;
	}

	//---------------------//
	//CALCULATE LIST SLOT//
	//---------------------//
	var _it_column =
		_it_card div _ct_rows_per_column;

	var _it_row =
		_it_card mod _ct_rows_per_column;

	var _val_box_x =
		_val_list_x +
		(
			_it_column *
			(_val_slot_w + _val_slot_gap_x)
		);

	var _val_box_y =
		_val_list_y +
		(
			_it_row *
			(_val_slot_h + _val_slot_gap_y)
		);

	var _flag_hover =
		(
			_val_mouse_x >= _val_box_x &&
			_val_mouse_x <= _val_box_x + _val_slot_w &&
			_val_mouse_y >= _val_box_y &&
			_val_mouse_y <= _val_box_y + _val_slot_h
		);

	//----------//
	//DRAW SLOT//
	//----------//
	draw_set_colour(
		_flag_hover
		? c_ltgray
		: c_gray
	);

	draw_rectangle(
		_val_box_x,
		_val_box_y,
		_val_box_x + _val_slot_w,
		_val_box_y + _val_slot_h,
		false
	);

	draw_set_colour(c_black);

	draw_rectangle(
		_val_box_x,
		_val_box_y,
		_val_box_x + _val_slot_w,
		_val_box_y + _val_slot_h,
		true
	);

	//----------//
	//DRAW NAME//
	//----------//
	draw_set_colour(c_black);
	draw_set_valign(fa_middle);

	draw_text(
		_val_box_x + 8,
		_val_box_y + (_val_slot_h * 0.5),
		_ref_card._ref_card._str_card_name
	);

	draw_set_valign(fa_top);

	//-------------//
	//SELECT CARD//
	//-------------//
	if (
		_flag_hover &&
		mouse_check_button_pressed(mb_left) &&
		!_flag_clicked
	){

		_flag_clicked = true;

		//-------------------//
		//DRAW SELECTED CARD//
		//-------------------//
		if (scr_draw_specific_card(_ref_card)){

			obj_battle_player_controller
				._ct_utility_tutors_pending--;

			//--------------------------------//
			//CHECK FOR ANOTHER TUTOR REQUEST//
			//--------------------------------//
			if (
				obj_battle_player_controller
					._ct_utility_tutors_pending > 0
			){

				var _arr_next_candidates =
					scr_get_tutor_candidates(
						"UTILITY"
					);

				//------------------------//
				//MORE CARDS AVAILABLE//
				//------------------------//
				if (
					array_length(
						_arr_next_candidates
					) > 0
				){

					_arr_tutor_cards =
						_arr_next_candidates;

					_flag_clicked =
						false;

					exit;
				}

				//-------------------------//
				//NO UTILITY CARDS REMAIN//
				//-------------------------//
				else{

					obj_battle_player_controller
						._ct_utility_tutors_pending = 0;

					scr_spawn_popup_scrolling(
						"TEXT",
						"NO UTILITY CARDS FOUND",
						undefined,
						c_aqua,
						room_width * 0.5,
						room_height * 0.5
					);
				}
			}

			//-------------------//
			//RETURN TO BATTLE//
			//-------------------//
			obj_battle_player_controller._state_player =
				ENUM_PLAYER_STATE.SELECT_CARD;

			obj_battle_player_controller
				.hscr_check_battle_card_oom(
					obj_battle_player_controller
						._list_battle_hand
				);

			instance_destroy();
			exit;
		}
	}
}

//--------------//
//RELEASE CLICK//
//--------------//
if (mouse_check_button_released(mb_left)){
	_flag_clicked = false;
}