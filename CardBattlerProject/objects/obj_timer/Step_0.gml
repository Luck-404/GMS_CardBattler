if (_life > 0){
	_life--;	
}
else {		
	global.turn_tracker = obj_player;
	global.cur_mana  = global.max_mana;
	instance_destroy();
}