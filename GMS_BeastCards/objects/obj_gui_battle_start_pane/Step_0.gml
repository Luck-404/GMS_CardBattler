//===============================================================================//
//
// STEP: OBJ_GUI_BATTLE_START_PANE
// FUNCTION: Handles the Start Battle confirmation button.
//           Releases the battle turn controller when confirmed.
//           Registers the Start Battle hover tooltip.
//
//===============================================================================//

//================//
//VALIDATE BATTLE//
//================//
if (
	!instance_exists(
		_ref_turn_controller
	)
){

	instance_destroy();

	exit;
}

if (
	_ref_turn_controller
		._flag_started_game ||
	_ref_turn_controller
		._flag_battle_ended
){

	instance_destroy();

	exit;
}

//========================//
//WAIT FOR BATTLE REVEAL//
//========================//
if (
	instance_exists(
		obj_transition_fader
	)
){

	var _ref_fader =
		instance_find(
			obj_transition_fader,
			0
		);

	if (
		instance_exists(
			_ref_fader
		)
	){

		if (
			_ref_fader
				._flag_wait_for_battle_pane &&
			!_ref_fader
				._flag_battle_waiting_for_input
		){

			exit;
		}
	}
}

//================//
//INPUT DELAY//
//================//
if (_ct_input_delay > 0){

	_ct_input_delay--;

	exit;
}

//====================//
//PLAYER PARTY REORDER//
//====================//
if (
	instance_exists(_ref_player_controller) &&
	ds_exists(_ref_player_controller._list_beasts_alive,ds_type_list)
){

	var _ct_reorder_beasts = min(5,ds_list_size(_ref_player_controller._list_beasts_alive));

	var _val_reorder_pane_left = x - (_val_pane_w * 0.5);
	var _val_reorder_pane_top = y - (_val_pane_h * 0.5);
	var _val_reorder_team_top = _val_reorder_pane_top + 60;
	var _val_reorder_player_x1 = _val_reorder_pane_left + 25;
	var _val_reorder_player_x2 = x - 25;
	var _val_reorder_row_start_y = _val_reorder_team_top + 110;

	var _val_reorder_mouse_x = device_mouse_x_to_gui(0);
	var _val_reorder_mouse_y = device_mouse_y_to_gui(0);

	for (var _it_reorder_beast = 0;_it_reorder_beast < _ct_reorder_beasts;_it_reorder_beast++){

		var _val_reorder_row_y =
			_val_reorder_row_start_y +
			(_it_reorder_beast * (_val_row_h + _val_row_spacing));

		var _flag_reorder_hover =
			point_in_rectangle(
				_val_reorder_mouse_x,
				_val_reorder_mouse_y,
				_val_reorder_player_x1 + 12,
				_val_reorder_row_y,
				_val_reorder_player_x2 - 12,
				_val_reorder_row_y + _val_row_h
			);

		if (!_flag_reorder_hover){
			continue;
		}

		var _ref_reorder_beast =
			ds_list_find_value(
				_ref_player_controller._list_beasts_alive,
				_it_reorder_beast
			);

		if (!instance_exists(_ref_reorder_beast)){
			continue;
		}

//====================//
//NUMBER KEY REORDER//
//====================//
		for (var _it_reorder_key = 1;_it_reorder_key <= 5;_it_reorder_key++){

			if (!keyboard_check_pressed(ord(string(_it_reorder_key)))){
				continue;
			}

			var _val_key_target = _it_reorder_key - 1;

			if (
				_val_key_target >= 0 &&
				_val_key_target < _ct_reorder_beasts &&
				_val_key_target != _it_reorder_beast
			){

				var _ref_key_target =
					ds_list_find_value(
						_ref_player_controller._list_beasts_alive,
						_val_key_target
					);

				if (
					instance_exists(_ref_key_target) &&
					scr_battle_swap_beast_positions(
						_ref_reorder_beast,
						_ref_key_target,
						"OBJ_GUI_BATTLE_START_PANE:STEP"
					)
				){
					audio_play_sound(snd_gui_press,0,false);
					exit;
				}
			}

			break;
		}

//================//
//ARROW HITBOXES//
//================//
		var _flag_can_move_up = _it_reorder_beast > 0;
		var _flag_can_move_down = _it_reorder_beast < _ct_reorder_beasts - 1;

		var _val_arrow_right_x = _val_reorder_player_x2 - 28;
		var _val_arrow_left_x = _val_reorder_player_x2 - 54;

		var _val_up_arrow_x =
			_flag_can_move_down ?
			_val_arrow_left_x :
			_val_arrow_right_x;

		var _val_down_arrow_x = _val_arrow_right_x;
		var _val_arrow_y = _val_reorder_row_y + 11;

		var _flag_up_arrow_hover =
			_flag_can_move_up &&
			point_in_rectangle(
				_val_reorder_mouse_x,
				_val_reorder_mouse_y,
				_val_up_arrow_x - 9,
				_val_arrow_y - 9,
				_val_up_arrow_x + 9,
				_val_arrow_y + 9
			);

		var _flag_down_arrow_hover =
			_flag_can_move_down &&
			point_in_rectangle(
				_val_reorder_mouse_x,
				_val_reorder_mouse_y,
				_val_down_arrow_x - 9,
				_val_arrow_y - 9,
				_val_down_arrow_x + 9,
				_val_arrow_y + 9
			);

		if (
			mouse_check_button_pressed(mb_left) &&
			(_flag_up_arrow_hover || _flag_down_arrow_hover)
		){

			var _val_arrow_target = _flag_up_arrow_hover ? _it_reorder_beast - 1 : _it_reorder_beast + 1;
			var _ref_arrow_target = ds_list_find_value(_ref_player_controller._list_beasts_alive,_val_arrow_target);

			if (
				instance_exists(_ref_arrow_target) &&
				scr_battle_swap_beast_positions(
					_ref_reorder_beast,
					_ref_arrow_target,
					"OBJ_GUI_BATTLE_START_PANE:STEP"
				)
			){
				audio_play_sound(snd_gui_press,0,false);
			}

			exit;
		}

		break;
	}
}

//================//
//BUTTON LAYOUT//
//================//
var _val_pane_bottom =
	y +
	(
		_val_pane_h *
		0.5
	);

var _val_button_x1 =
	x -
	(
		_val_button_w *
		0.5
	);

var _val_button_x2 =
	x +
	(
		_val_button_w *
		0.5
	);

var _val_button_y1 =
	_val_pane_bottom -
	78;

var _val_button_y2 =
	_val_button_y1 +
	_val_button_h;

//================//
//MOUSE//
//================//
var _val_mouse_x =
	device_mouse_x_to_gui(0);

var _val_mouse_y =
	device_mouse_y_to_gui(0);

var _flag_button_hover =
	_val_mouse_x >=
		_val_button_x1 &&
	_val_mouse_x <=
		_val_button_x2 &&
	_val_mouse_y >=
		_val_button_y1 &&
	_val_mouse_y <=
		_val_button_y2;

//================//
//HOVER TOOLTIP//
//================//
if (
	_flag_button_hover &&
	!scr_gui_check_cheats_active()
){

	scr_gui_set_hover_tooltip(
		"START BATTLE",
		"",
		10
	);
}

//================//
//CONFIRM//
//================//
if (
	(
		_flag_button_hover &&
		mouse_check_button_pressed(
			mb_left
		)
	) ||
	keyboard_check_pressed(
		vk_enter
	)
){

	audio_play_sound(
		snd_gui_press,
		0,
		false
	);

	_ref_turn_controller
		._flag_start_confirmation_accepted =
		true;

	instance_destroy();
}
