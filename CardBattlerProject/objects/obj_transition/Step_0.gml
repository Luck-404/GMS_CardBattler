//////////////////////
// FADE IN AND OUT //
//////////////////////
if (_is_fading) {
    if (_is_fading_in) {
        // Increase alpha (fade in)
        image_alpha += _fade_speed;

        // Check if fully opaque
        if (image_alpha >= 1) {
            image_alpha = 1;

            // Start fading out after fade in is complete
            _is_fading_in = false;
			if (_target_room == rm_encounter && _flag_encounter_in == false){
				_flag_overworld_in = false;
				_flag_encounter_in = true;				
				obj_player.visible = false;
				//destroy old camera on way into new room
				//camera_destroy(global._camera);
				global._camera = undefined; 
				global._cam_height = undefined;
				global._cam_width = undefined;
				room_goto(_target_room);				
			}

			if (_target_room == rm_overworld && _flag_overworld_in == false){
					_flag_encounter_in = false;
					_flag_overworld_in = true;
					//set player back where they left off
					obj_player.x = global.player_xpos;
					obj_player.y = global.player_ypos;
					obj_player._flag_created_camera = false;
					obj_player._move_speed = 4;
					global.current_mana = 3;			
					show_debug_message("RESET PLAYER'S POSITION, MOVEMENT AND CAMERA");
			
					//clear player's creature lists
					ds_list_clear(global.player_team_dead);
					ds_list_clear(global.player_team_in_play);
					show_debug_message("RESET PLAYER'S PARTY");
			
					//reset party spawned and deck created
					obj_player._flag_party_spawned = false;
					obj_player._flag_deck_created = false;
					show_debug_message("RESET PLAYER'S PARTY SPAWN AND DECK CREATED VALUES");
				
					//reset encounter trigger variables
		            global.steps = 0;
		            global.can_encounter = false;	
					room_goto(_target_room);
				}
            _is_fading_out = true;
        }
    } else if (_is_fading_out) {
        // Decrease alpha (fade out)
        image_alpha -= _fade_speed;

        // Check if fully transparent
        if (image_alpha <= 0) {
            image_alpha = 0;

            // Transition to the target room and clean up
            if (_target_room != -1) 
				
				//destroy self
                instance_destroy();
            }
        }
    }
