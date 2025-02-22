//////////////////////////////////////////////////////////////////////
//					OBJ_BANNER_TRIGGER STEP							//
//																	//
// > SPAWN A BANNER WHEN A PLAYER ENTERS, THEN SET TO TRIGGERED		//
//////////////////////////////////////////////////////////////////////
if (instance_place(x,y,obj_player) && _flag_triggered == false){
	show_debug_message("PLAYER HAS ENTERED TRANSITION TRIGGER");	
	//trigger this one
	_flag_triggered = true;
	obj_player._move_speed = 0;
	scr_transition("overworld","new room",_stored_room, room);
	
} if (instance_exists(obj_player) && (distance_to_object(obj_player) > 128)){
	_flag_triggered = false;
}