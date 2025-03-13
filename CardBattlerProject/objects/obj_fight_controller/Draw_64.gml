//////////////////////////////////////////////////////////////////////
//					OBJ_FIGHT_CONTROLLER DRAW GUI					//
//																	//
// > DRAW TURN STATE													//
//////////////////////////////////////////////////////////////////////
draw_set_color(c_white);
draw_set_font(fnt_fanwood);
draw_text(room_width/2-20,50,"Turn: " + string(global.turn_counter));
if (global.fight_controller_state == FIGHT_CONTROLLER_STATE.PLAYER_TURN){
	draw_set_color(c_aqua);
	draw_set_font(fnt_fanwood);
	draw_text(room_width/2-300,25,"PLAYER TURN");
} else if (global.fight_controller_state == FIGHT_CONTROLLER_STATE.ENEMY_TURN){
	draw_set_color(c_red);
	draw_set_font(fnt_fanwood);
	draw_text(room_width/2+300,25,"ENEMY TURN");
}

///////////////////
// MOVE STATUSES //
///////////////////
for (var _i = 0; _i < ds_list_size(global.encounter_statuses); _i++){
	var _counter = ds_list_find_value(global.encounter_statuses,_i);
	_counter._counter_index = _i;	
	_counter.x = (16*_i)+5;
	_counter.y = 21;
}