//////////////////////////////////////////////////////////////////////
//							SCR_SPAWN_CRITTER						//
//																	//
// > RANDOMLY SPAWN CRITTERS ON THE EDGES OF PLAYER'S SCREEN		//
//////////////////////////////////////////////////////////////////////
function scr_spawn_critter(){
	var _p_x = obj_player.x;
	var _p_y = obj_player.y;
	
	//get a point that is min 320px x(10 tiles) by 320px y(10 tles) away to 480px (15 tiles away)
	var _ysign = choose(-1,1)
	var _xsign = choose(-1,1)
	var _t_x = _p_x + (_xsign*irandom_range(320,480));
	var _t_y = _p_y + (_ysign*irandom_range(320,480));	
	
	instance_create_layer(_t_x,_t_y,"Player",obj_critter);	
}