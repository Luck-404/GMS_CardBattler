//===============================================================================//
//
// STEP: OBJ_GUI_LIBRARY_RIGHT_ARROW
// FUNCTION: Moves the assigned Deck/Library page forward.
//
//===============================================================================//

if (!instance_exists(_ref_gui_pane)){
	instance_destroy();
	exit;
}

var _str_target =
	string_upper(
		string(
			_str_page_target
		)
	);

var _ct_total_pages = 1;

switch (_str_target){

	case "DECK":

		_ct_total_pages =
			max(
				1,
				ceil(
					ds_list_size(
						global.list_player_deck
					) /
					_ref_gui_pane._ct_deck_per_page
				)
			);

	break;

	default:

		_str_target = "LIBRARY";

		_ct_total_pages =
			max(
				1,
				ceil(
					ds_list_size(
						global.list_player_library
					) /
					_ref_gui_pane._ct_library_per_page
				)
			);

	break;
}

visible =
	_ct_total_pages > 1;

if (!visible){
	image_index = 0;
	exit;
}

if (
	position_meeting(
		device_mouse_x_to_gui(0),
		device_mouse_y_to_gui(0),
		self
	)
){

	image_index = 1;

	if (
		mouse_check_button_pressed(mb_left) &&
		!_flag_clicked
	){

		audio_play_sound(
			snd_gui_press,
			0,
			false
		);

		_flag_clicked = true;
		_ct_cooldown = 10;

		if (_str_target == "DECK"){

			_ref_gui_pane._it_deck_page =
				min(
					_ct_total_pages - 1,
					_ref_gui_pane._it_deck_page +
					1
				);
		}
		else{

			_ref_gui_pane._it_library_page =
				min(
					_ct_total_pages - 1,
					_ref_gui_pane._it_library_page +
					1
				);
		}
	}
}
else{
	image_index = 0;
}

if (_flag_clicked){

	if (_ct_cooldown > 0){
		_ct_cooldown--;
	}
	else{
		_ct_cooldown = 0;
		_flag_clicked = false;
	}
}