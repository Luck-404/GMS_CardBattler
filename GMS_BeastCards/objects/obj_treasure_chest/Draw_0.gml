//
//
// DRAW: OBJ_TREASURE_CHEST | DRAWS HIGHLIGHT WHEN CLOSE, ALLOW PLAYER TO INTERACT TO GET NEW CARDS AND GP
//
//
draw_sprite_ext(spr_decor_shadow,image_index,x,y,0.3,0.3,0,_color,1);
draw_sprite_ext(spr_treasure_chest,image_index,x,y,1,1,0,_color,1);

if (_flag_triggered == true){
	image_index = 1;	
} else {
	#region HIGHLIGHT AND INTERACT
	if (instance_exists(obj_player) && distance_to_object(obj_player) < 48){
		//DRAW HIGHLIGHT
		draw_sprite(spr_treasure_chest_highlight,0,x,y);
	
		if (keyboard_check_pressed(ord("E")) && _flag_triggered == false){
			show_debug_message("\n CHEST: PLAYER HAS PRESSED 'E' ON A CHEST");
			_flag_triggered = true;
			_cooldown = 10;
			
			//ADD CHEST TO LIST
			global.player_chests_opened[?_chest_id] = true;
		
			//AWARD TREASURE
			if (_loot_type == "RANDOM"){
				show_debug_message("\n CHEST: ROLL RANDOM LOOT");
				scr_roll_treasure_chest_reward();
			}
			else {
				show_debug_message("\n CHEST: ROLL SPECIFIC LOOT");
				scr_award_treasure_chest_loot();
			}

		}
	}
	#endregion
}