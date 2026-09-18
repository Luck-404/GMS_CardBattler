
//===============================================================================//
// DRAW GUI END: OBJ_TRANSITION_FADER
// FUNCTION: Draws the background fade and spinner.
//===============================================================================//

//================//
//GUI DIMENSIONS//
//================//

var _val_gui_w = display_get_gui_width();
var _val_gui_h = display_get_gui_height();

//================//
//BACKGROUND//
//================//

draw_set_alpha(_val_alpha);
draw_set_colour(c_black);

draw_rectangle(
	0,
	0,
	_val_gui_w,
	_val_gui_h,
	false
);

//================//
//RESET DRAW STATE//
//================//

draw_set_alpha(1);
draw_set_colour(c_white);

//================//
//SPINNER//
//================//

var _flag_draw_spinner = (
	_str_transition_state == "BLACK_HOLD" ||
	_str_transition_state == "WAIT_BATTLE_PANE"
);

// The pane's creation immediately hides the spinner,
// even if creation happens later in the same frame.

if (_flag_draw_spinner && !_flag_battle_pane_spawned){

	draw_sprite_ext(
		spr_transition_spinner,
		0,
		_val_gui_w * 0.5,
		_val_gui_h * 0.5,
		0.75,
		0.75,
		_val_spinner_rotation,
		c_white,
		1
	);
}