//===============================================================================//
//
// STEP: OBJ_TRANSITION
// FUNCTION: Starts an automatic room transition.
//           Waits for fader signal before changing to destination room.
//           Adds battle wait protection when returning from battle.
//
//===============================================================================//

//---------------//
//INITIAL TRIGGER//
//---------------//
if (!_flag_triggered){
	_flag_triggered = true;

	_ref_fader = instance_create_layer(room_width / 2,room_height / 2,"ily_fx",obj_transition_fader);
	_ref_fader._ref_transition = self;
}

//-----------------//
//FINALIZE AND MOVE//
//-----------------//
if (_flag_continue_transition){
	_flag_continue_transition = false;

	_ref_fader._flag_fade_in = true;

	if (_rm_destination != rm_battle){
		scr_init_battle_wait(180);
	}

	room_goto(_rm_destination);
}