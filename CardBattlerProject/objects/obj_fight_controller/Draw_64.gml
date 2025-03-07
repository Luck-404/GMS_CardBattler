draw_set_color(c_white);
draw_set_font(fnt_fanwood);
draw_text(room_width/2,50,"Turn: " + string(global.turn_counter));
if (global.fight_controller_state == FIGHT_CONTROLLER_STATE.PLAYER_TURN){
	draw_set_color(c_aqua);
	draw_set_font(fnt_fanwood);
	draw_text(room_width/2-50,100,"PLAYER TURN");
} else if (global.fight_controller_state == FIGHT_CONTROLLER_STATE.ENEMY_TURN){
	draw_set_color(c_red);
	draw_set_font(fnt_fanwood);
	draw_text(room_width/2-50,100,"ENEMY TURN");
}
