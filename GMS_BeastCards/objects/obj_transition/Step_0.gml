
//===============================================================================//
// STEP: OBJ_TRANSITION
// FUNCTION: Creates a persistent fade and changes rooms at full black.
//===============================================================================//

//================//
//INITIAL TRIGGER//
//================//

if (!_flag_triggered){

	_flag_triggered = true;

	_ref_fader = instance_create_layer(
		room_width * 0.5,
		room_height * 0.5,
		"ily_fx",
		obj_transition_fader
	);

	_ref_fader._ref_transition = self;

	_ref_fader._flag_wait_for_battle_pane =
		(_rm_destination == rm_battle);
}

//================//
//CHANGE ROOM//
//================//

if (_flag_continue_transition){

	_flag_continue_transition = false;

	if (instance_exists(_ref_fader)){

		// Ordinary rooms may fade in after the timer.
		// Battles must wait for their Start Battle pane.

		if (_rm_destination != rm_battle){
			_ref_fader._flag_fade_in = true;
		}
	}

	// The destination room creates its own 180-frame
	// encounter lock in obj_player's Room Start Event.

	room_goto(_rm_destination);
}