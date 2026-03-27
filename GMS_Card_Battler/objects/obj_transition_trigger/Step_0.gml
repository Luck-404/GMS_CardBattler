//////////////////////////////////////////////////////////////////////
//					OBJ_BANNER_TRIGGER STEP							//
//																	//
// > When a player enters the region, trigger it once- sending to	//
//   the programmed room.											//
//////////////////////////////////////////////////////////////////////
if (instance_place(x,y,obj_player) && _flag_triggered == false){
	//trigger this one
	_flag_triggered = true;
	obj_player._move_speed = 0;
	show_debug_message("			TRANSITION TO NEW ROOM FROM OTHER ROOM ");		
	scr_transition("overworld","new room",_stored_room, room);
	
}