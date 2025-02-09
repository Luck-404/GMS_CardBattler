///////////////////////////////////////////////////////////////////////
//						OBJ_TRANSITION STEP							//
//																	//
// > WORK THROUGH THE STATE MACHINE TO TRANSFER TO THE PROPER ROOM	//
//////////////////////////////////////////////////////////////////////
switch(_transition_state_tracker){
	case TRANSITION_STATE.FADE_OUT:
		image_alpha += _fade_speed;
		if (image_alpha >= 1) {
			_transition_state_tracker = TRANSITION_STATE.TRANSITION;
		}
	break;
	
	case TRANSITION_STATE.TRANSITION:
		//move to new room
		room_goto(room);
		_transition_state_tracker = TRANSITION_STATE.CREATE_PIPELINE;
	break;
	
	case TRANSITION_STATE.CREATE_PIPELINE:
		//BASED ON THE ROOM, CREATE THE PROPER PIPELINE
		if (_target_room == rm_main_menu){
			//CALL SAVE?
		} else if (_target_room == rm_encounter){
			//spawn encounter pipeline
			_ref_pipeline = instance_create_layer(x,y,"GUI",obj_encounter_pipeline)
		} else {
			//spawn ow pipeline
			_ref_pipeline = instance_create_layer(x,y,"GUI",obj_overworld_pipeline)			
		}
		_transition_state_tracker = TRANSITION_STATE.LOADING;
	break;	
	
	case TRANSITION_STATE.LOADING:
		//wait here, displaying a loading bar/sprite (in the draw) until the room's pipeline sends us we're good
	break;
	
	case TRANSITION_STATE.FADE_IN:
		image_alpha -= _fade_speed;
		if (image_alpha <= 0) {
			_transition_state_tracker = TRANSITION_STATE.DELETE;
		}	
	break;
	
	case TRANSITION_STATE.DELETE:
		instance_destroy();
	break;	
}