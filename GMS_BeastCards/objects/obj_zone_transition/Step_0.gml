//
//
// STEP: OBJ_ZONE_TRANSITION
//
//

//TRIGGER ON CONTACT WITH PLAYER
if (instance_place(x,y,obj_player) && _flag_triggered == false){
	_flag_triggered = true; //TRIGGER ONCE
	
	obj_player._player_speed = 0; //SET PLAYER SPEED TO 0, EFFECTIVELY FREEZING THEM
	
	//FADE TO BLACK
	_ref_fader = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_fader);
	_ref_fader._ref_transition = self;

}

//WAIT FOR FADER TO CONFIRM TO MOVE ON
if (_flag_continue_transition == true){
	//RETRIEVE ROOM ID
	var _room = scr_get_room_id(_to_id,_from_id);
	
	//SET PLAYER POSITION APPROPRIATELY
	obj_player.x = _room[2];
	obj_player.y = _room[3];
	
	//FADE IN
	_ref_fader._flag_fade_in = true;
	
	//SPAWN ANNOUNCEMENT BANNER
	scr_create_banner(_room[1]);
	
	//GO TO THE DESTINATION ROOM
	room_goto(_room[0]);
	
	//RESET PLAYER SPEED, GIVES CONTROL BACK
	obj_player._player_speed = 3;
}