if (_life > 0){
	_life--;	
}
else {
	show_debug_message("\n\n[[ ENEMY TURN OVER, PASSING TO PLAYER ]]\n\n");			
	global.turn_tracker = obj_player;
	global.current_mana = global.max_mana;
	instance_destroy();
}