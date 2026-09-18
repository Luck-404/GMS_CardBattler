//===============================================================================//
//
// STEP: OBJ_GUI_BATTLE_START_PANE
// FUNCTION: Handles the Start Battle confirmation button.
//           Releases the battle turn controller when confirmed.
//
//===============================================================================//

//================//
//VALIDATE BATTLE//
//================//

if (!instance_exists(_ref_turn_controller)){
	instance_destroy();
	exit;
}

if (
	_ref_turn_controller._flag_started_game ||
	_ref_turn_controller._flag_battle_ended
){
	instance_destroy();
	exit;
}



//========================//
//WAIT FOR BATTLE REVEAL//
//========================//

if (instance_exists(obj_transition_fader)){

	var _ref_fader = instance_find(
		obj_transition_fader,
		0
	);

	if (instance_exists(_ref_fader)){

		if (
			_ref_fader._flag_wait_for_battle_pane &&
			!_ref_fader._flag_battle_waiting_for_input
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

//================//
//BUTTON LAYOUT//
//================//

var _val_pane_bottom = y + (_val_pane_h * 0.5);

var _val_button_x1 = x - (_val_button_w * 0.5);
var _val_button_x2 = x + (_val_button_w * 0.5);

var _val_button_y1 = _val_pane_bottom - 78;
var _val_button_y2 = _val_button_y1 + _val_button_h;

//================//
//MOUSE//
//================//

var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

var _flag_button_hover =
	_val_mouse_x >= _val_button_x1 &&
	_val_mouse_x <= _val_button_x2 &&
	_val_mouse_y >= _val_button_y1 &&
	_val_mouse_y <= _val_button_y2;

//================//
//CONFIRM//
//================//

if (
	(_flag_button_hover && mouse_check_button_pressed(mb_left)) ||
	keyboard_check_pressed(vk_enter)
){

	audio_play_sound(snd_gui_press,0,false);

	_ref_turn_controller._flag_start_confirmation_accepted = true;

	instance_destroy();
}