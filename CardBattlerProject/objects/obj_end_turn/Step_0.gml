if (instance_exists(obj_end_box) == true){
	visible = false;
}
if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x,mouse_y,obj_end_turn)){
	show_debug_message("=-= OBJ_END_TURN: CLICKED END TURN, PASSING TURN TO ENEMY TEAM =-=");			
	//flip turn	
	global.turn_tracker = obj_enemy_team;
	visible = false;
	show_debug_message("=-= OBJ_END_TURN: DRAWING NEW CARDS... =-=");	
	scr_draw_cards();
}