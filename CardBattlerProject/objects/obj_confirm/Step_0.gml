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
		
			//set player back where they left off
			obj_player.x = global.player_xpos;
			obj_player.y = global.player_ypos;
			
			//reset the camera! TODO
			global._cam_width = 960; // Camera width (match your viewport)
			global._cam_height = 540; // Camera height (match your viewport)
			camera_set_view_size(global._camera, global._cam_width, global._cam_height); // Set camera size
			camera_set_view_pos(global._camera, obj_player.x - global._cam_width / 2, obj_player.y - global._cam_height / 2); // Center on character
			view_set_camera(0, global._camera); // Attach camera to Viewport 0
			
			
			obj_player._move_speed = 4;
			global.current_mana = 3;			
			
			instance_destroy();
		}	
	}
}