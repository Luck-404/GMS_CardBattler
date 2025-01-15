if (instance_exists(obj_end_box) == true){
	visible = false;
}
if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x,mouse_y,obj_end_turn)){
	show_debug_message("\n\n[[ CLICKED END TURN, PASSING TO ENEMY ]]\n\n");			
	//flip turn	
	global.turn_tracker = obj_enemy_team;
	visible = false;
	scr_draw_cards();
}