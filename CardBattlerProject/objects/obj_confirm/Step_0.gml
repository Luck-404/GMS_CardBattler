if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x,mouse_y,obj_confirm)){
	show_debug_message("<<= OBJ_CONFIRM: CLICKED CONFIRM=>>");					
			
	if (_confirm_type == "endgame"){
		show_debug_message("<<= OBJ_CONFIRM: GAME LOSS- QUITTING GAME=>>");			
		game_end();	
	}
	
	else {
		if (_flag_transition_start == false){
			show_debug_message("<<= OBJ_CONFIRM: FIGHT WON- STARTING TRANSITION TO OVERWORLD =>>");				
			_flag_transition_start = true;			
			scr_start_transition(rm_overworld);
		}	
	}
}