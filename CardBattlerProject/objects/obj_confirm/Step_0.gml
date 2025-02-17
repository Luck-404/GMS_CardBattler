if (mouse_check_button_pressed(mb_left) && position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_confirm)){
	show_debug_message("<<= OBJ_CONFIRM: CLICKED CONFIRM=>>");					
			
	if (_confirm_type == "endgame"){
		show_debug_message("<<= OBJ_CONFIRM: GAME LOSS- QUITTING GAME=>>");			
		game_end();	
	}
	
	else {
		if (_flag_transition_start == false){
			show_debug_message("<<= OBJ_CONFIRM: FIGHT WON- STARTING TRANSITION TO OVERWORLD =>>");				
			_flag_transition_start = true;			
			scr_start_transition(global.saved_room);
		}	
	}
}