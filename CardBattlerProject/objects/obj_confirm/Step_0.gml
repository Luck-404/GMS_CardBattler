if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x,mouse_y,obj_confirm)){
	show_debug_message("\n\n[[ CLICKED CONFIRM ]]\n\n");
	
	if (_confirm_type == "endgame"){
		game_end();	
	}
	
	else {
		if (_flag_transition_start == false){
			_flag_transition_start = true;
		
			show_debug_message("\n\n===STARTING TRANSITION TO OVERWORLD===\n\n");				
			scr_start_transition(rm_overworld);
		}	
	}
}