if (_life > 0){
	_life--;	
}
else {
	show_debug_message("VVV OBJ_TIMER: ENEMY TURN OVER, PASSING TO PLAYER VVV");			
	global.turn_tracker = obj_player;
	global.current_mana = global.max_mana;
	instance_destroy();
}