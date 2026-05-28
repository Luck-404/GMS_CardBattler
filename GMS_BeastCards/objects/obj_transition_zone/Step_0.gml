//
//
// STEP: OBJ_TRANSITION_ZONE | ON CONTACT WITH THE PLAYER, MOVES TO THE STORED ROOM
//
//


//
// INITIAL TRIGGER | TRIGGER ON CONTACT WITH PLAYER
//
#region INITIAL TRIGGER
if (instance_place(x,y,obj_player) && _flag_triggered == false){
	_flag_triggered = true; //TRIGGER ONCE
	
	obj_player._player_speed = 0; //SET PLAYER SPEED TO 0, EFFECTIVELY FREEZING THEM
	
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
	//RETRIEVE ROOM ID
	var _room = scr_get_transition_room_info(_to_id,_from_id);
	
	//SET PLAYER POSITION APPROPRIATELY
	obj_player.x = _room[2];
	obj_player.y = _room[3];
	
	//FADE IN
	_ref_fader._flag_fade_in = true;
	
	//SPAWN ANNOUNCEMENT BANNER
	scr_spawn_popup_banner(_room[1]);
	
	//GO TO THE DESTINATION ROOM
	room_goto(_room[0]);
	
	//RESET PLAYER SPEED, GIVES CONTROL BACK
	obj_player._player_speed = 3;
}
#endregion