//////////////////////
// FADE IN AND OUT //
//////////////////////
if (_is_fading) {
    if (_is_fading_in) {
        // Increase alpha (fade in)
        image_alpha += _fade_speed;

        // Check if fully opaque
        if (image_alpha >= 1) {
		show_debug_message("[[]] OBJ_TRANSITION: FADE IN COMPLETE [[]]");			
            image_alpha = 1;

            // Start fading out after fade in is complete
            _is_fading_in = false;
			if (_target_room == rm_encounter && _flag_encounter_in == false){
				show_debug_message("[[]] OBJ_TRANSITION: TRIGGERED AN ENCOUNTER, UPDATING VARIABLES... [[]]");
				_flag_overworld_in = false;
				_flag_encounter_in = true;			
				show_debug_message("[[]] OBJ_TRANSITION: PLAYER HIDDEN [[]]");				
				obj_player.visible = false;
				//destroy old camera on way into new room
				//camera_destroy(global._camera);
				show_debug_message("[[]] OBJ_TRANSITION: CAMERA DELETED [[]]");				
				global._camera = undefined; 
				global._cam_height = undefined;
				global._cam_width = undefined;
				show_debug_message("[[]] OBJ_TRANSITION: ENTERING ENCOUNTER! [[]]");				
				room_goto(_target_room);
			}

			if (_target_room == rm_overworld && _flag_overworld_in == false){
					show_debug_message("[[]] OBJ_TRANSITION: TRIGGERED OVERWORLD, UPDATING VARIABLES... [[]]");				
					_flag_encounter_in = false;
					_flag_overworld_in = true;
					//set player back where they left off
					obj_player.x = global.player_xpos;
					obj_player.y = global.player_ypos;
					obj_player._flag_created_camera = false;
					obj_player._move_speed = 4;
					global.max_mana = global.max_mana_saved;
					global.current_mana = global.max_mana;
					obj_player._flag_transition_start = false;
					obj_player._flag_can_touch = true;
					show_debug_message("[[]] OBJ_TRANSITION: PLAYER POSITION, MANA, MOVEMENT RESET [[]]");					
			
					//clear player's creature lists
					ds_list_clear(global.player_team_dead);
					ds_list_clear(global.player_team_in_play);
					show_debug_message("[[]] OBJ_TRANSITION: PLAYER SPAWNED TEAM DELETED [[]]");					
			
			
					//reset party spawned and deck created
					obj_player._flag_party_spawned = false;
					obj_player._flag_deck_created = false;
					show_debug_message("[[]] OBJ_TRANSITION: PLAYER POSITION, MANA, MOVEMENT RESET [[]]");										
				
					//reset encounter trigger variables
		            global.steps = 0;
		            global.can_encounter = false;	
					global.trigger_loss = false;
					show_debug_message("[[]] OBJ_TRANSITION: ENCOUNTER TRIGGER VARIABLES RESET [[]]");					
								
					scr_stock_card_shop(irandom_range(3,9));			
					show_debug_message("[[]] OBJ_TRANSITION: RESTOCKING CARD SHOP [[]]");	
					scr_stock_mercenary_shop(irandom_range(2,4));	
					
					show_debug_message("[[]] OBJ_TRANSITION: ENTERING OVERWORLD! [[]]");					
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
