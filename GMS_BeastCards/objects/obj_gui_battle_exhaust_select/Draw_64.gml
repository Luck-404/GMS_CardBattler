//===============================================================================//
//
// DRAW GUI: OBJ_GUI_BATTLE_EXHAUST_SELECT
// FUNCTION: Displays eligible exhausted Cards.
//           Handles Card selection and pagination.
//           Resolves queued Rekindle recoveries before returning to battle.
//
//===============================================================================//

//================//
//VALIDATE BATTLE//
//================//
if (!instance_exists(obj_battle_player_controller)){
	instance_destroy();
	exit;
}

//================//
//BACKGROUND//
//================//
#region BACKGROUND

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

//------//
//PANE//
//------//
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

#endregion

//================//
//HEADER//
//================//
#region HEADER

draw_set_font(fnt_gui_medium);
draw_set_colour(c_white);

draw_set_halign(fa_center);
draw_set_valign(fa_top);

draw_text(x,_val_pane_top + 20,"REKINDLE");

draw_set_font(fnt_gui_small);

draw_text(
	x,
	_val_pane_top + 50,
	"SELECT AN EXHAUSTED " + _str_color + " CARD"
);

draw_set_halign(fa_left);

#endregion

//================//
//INPUT//
//================//
#region INPUT

var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

var _flag_mouse_pressed = (
	mouse_check_button_pressed(mb_left) &&
	!_flag_clicked
);

#endregion

//================//
//PAGE DATA//
//================//
#region PAGE DATA

var _ct_candidates = array_length(_arr_candidates);

var _ct_pages = max(
	1,
	ceil(_ct_candidates / _ct_page_size)
);

_ct_page = clamp(_ct_page,0,_ct_pages - 1);

var _it_start = _ct_page * _ct_page_size;

var _it_end = min(
	_ct_candidates,
	_it_start + _ct_page_size
);

#endregion

//================//
//CANDIDATE CARDS//
//================//
#region CANDIDATE CARDS

for (var _it_card = _it_start;_it_card < _it_end;_it_card++){

	var _ref_card = _arr_candidates[_it_card];

	if (!instance_exists(_ref_card)){
		continue;
	}

	if (_ref_card._str_location != "EXHAUST"){
		continue;
	}

	if (!is_struct(_ref_card._ref_card)){
		continue;
	}

	//================//
	//SLOT POSITION//
	//================//
	var _it_slot = _it_card - _it_start;

	var _it_column = _it_slot div _ct_rows_per_column;
	var _it_row = _it_slot mod _ct_rows_per_column;

	var _val_box_x =
		_val_list_x +
		(_it_column * (_val_slot_w + _val_slot_gap_x));

	var _val_box_y =
		_val_list_y +
		(_it_row * (_val_slot_h + _val_slot_gap_y));

	//================//
	//CHECK HOVER//
	//================//
	var _flag_hover = (
		_val_mouse_x >= _val_box_x &&
		_val_mouse_x <= _val_box_x + _val_slot_w &&
		_val_mouse_y >= _val_box_y &&
		_val_mouse_y <= _val_box_y + _val_slot_h
	);

	//================//
	//DRAW SLOT//
	//================//
	draw_set_colour(_flag_hover ? c_ltgray : c_gray);

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

	//================//
	//DRAW CARD NAME//
	//================//
	draw_set_colour(c_black);
	draw_set_valign(fa_middle);

	draw_text(
		_val_box_x + 8,
		_val_box_y + (_val_slot_h * 0.5),
		_ref_card._ref_card._str_card_name
	);

	draw_set_valign(fa_top);

	//================//
	//SELECT CARD//
	//================//
	if (_flag_hover && _flag_mouse_pressed){

		_flag_clicked = true;

		var _str_recovered_name = _ref_card._ref_card._str_card_name;

		if (
			scr_battle_recover_specific_exhausted_card(
				_ref_card,
				_str_color,
				_ref_excluded_card
			)
		){

			//================//
			//RECOVERY FEEDBACK//
			//================//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"RECOVERED: " + _str_recovered_name,
				undefined,
				c_green,
				room_width * 0.5,
				room_height * 0.5
			);

			//================//
			//UPDATE QUEUE//
			//================//
			obj_battle_player_controller._ct_rekindle_pending = max(
				0,
				obj_battle_player_controller._ct_rekindle_pending - 1
			);

			//====================//
			//MORE RECOVERIES//
			//====================//
			if (obj_battle_player_controller._ct_rekindle_pending > 0){

				_arr_candidates = scr_battle_get_exhausted_color_candidates(
					_str_color,
					_ref_excluded_card
				);

				_ct_page = 0;

				if (array_length(_arr_candidates) > 0){

					_flag_clicked = false;

					exit;
				}

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"NO EXHAUSTED " + _str_color + " CARDS REMAIN",
					undefined,
					c_ltgray,
					room_width * 0.5,
					room_height * 0.5
				);
			}

			//================//
			//FINISH SELECTION//
			//================//
			hscr_gui_finish_exhaust_select();

			exit;
		}
	}
}

#endregion

//================//
//PAGINATION//
//================//
#region PAGINATION

var _val_nav_y = _val_pane_top + _val_pane_h - 46;

draw_set_font(fnt_gui_small);
draw_set_colour(c_white);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

//----------------//
//PAGE INDICATOR//
//----------------//
draw_text(
	x,
	_val_nav_y,
	"PAGE " + string(_ct_page + 1) + " / " + string(_ct_pages)
);

//================//
//PREVIOUS PAGE//
//================//
var _val_prev_x1 = _val_pane_left + 30;
var _val_prev_x2 = _val_prev_x1 + 130;

var _flag_prev_hover = (
	_val_mouse_x >= _val_prev_x1 &&
	_val_mouse_x <= _val_prev_x2 &&
	_val_mouse_y >= _val_nav_y - 15 &&
	_val_mouse_y <= _val_nav_y + 15
);

draw_set_colour(
	_ct_page > 0
	? (_flag_prev_hover ? c_white : c_ltgray)
	: c_gray
);

draw_text(
	(_val_prev_x1 + _val_prev_x2) * 0.5,
	_val_nav_y,
	"PREVIOUS"
);

if (
	_ct_page > 0 &&
	_flag_prev_hover &&
	_flag_mouse_pressed
){

	_ct_page--;
	_flag_clicked = true;
}

//================//
//NEXT PAGE//
//================//
var _val_next_x2 = _val_pane_left + _val_pane_w - 30;
var _val_next_x1 = _val_next_x2 - 130;

var _flag_next_hover = (
	_val_mouse_x >= _val_next_x1 &&
	_val_mouse_x <= _val_next_x2 &&
	_val_mouse_y >= _val_nav_y - 15 &&
	_val_mouse_y <= _val_nav_y + 15
);

draw_set_colour(
	_ct_page < _ct_pages - 1
	? (_flag_next_hover ? c_white : c_ltgray)
	: c_gray
);

draw_text(
	(_val_next_x1 + _val_next_x2) * 0.5,
	_val_nav_y,
	"NEXT"
);

if (
	_ct_page < _ct_pages - 1 &&
	_flag_next_hover &&
	_flag_mouse_pressed &&
	!_flag_clicked
){

	_ct_page++;
	_flag_clicked = true;
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);

#endregion

//================//
//INPUT RESET//
//================//
#region INPUT RESET

if (mouse_check_button_released(mb_left)){
	_flag_clicked = false;
}

#endregion