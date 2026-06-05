//
//
// STEP: OBJ_TRANSITION | WHEN SPAWNED, EXECUTES A TRANSITION
//
//


//
// INITIAL TRIGGER | TRIGGER ON CONTACT WITH PLAYER
//
#region INITIAL TRIGGER
if (_flag_triggered == false){
	_flag_triggered = true; //TRIGGER ONCE
	
	//FADE TO BLACK
	_ref_fader = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_transition_fader);
	_ref_fader._ref_transition = self;

}
#endregion

//
// FINALIZE AND MOVE | WAIT FOR CONTINUE VARIABLE TO MVOE ON
//
#region FINALIZE AND MOVE
if (_flag_continue_transition == true){
	//FADE IN
	_ref_fader._flag_fade_in = true;

	//GO TO THE DESTINATION ROOM
	room_goto(_destination);
}
#endregion