//
//
// DRAW: OBJ_TREASURE_SPARKLE | DRAWS HIGHLIGHT WHEN CLOSE, ALLOW PLAYER TO INTERACT TO GET NEW CARDS AND GP, ALSO REROLL FOR VISIBILITY EVERY 5MIN
//
//

draw_sprite_ext(spr_treasure_sparkle,image_index,x,y,1,1,0,_color,1);

#region VISIBILITY TIMER AND REROLL
if (!visible){
	if(_visibility_timer > 0){
		_visibility_timer--;
	} else {
		scr_roll_treasure_sparkle_visibility();
	}
}
#endregion

#region HIGHLIGHT AND INTERACT
if (instance_exists(obj_player) && distance_to_object(obj_player) < 48){
	//DRAW HIGHLIGHT
	draw_sprite(spr_treasure_sparkle_highlight,0,x,y);
	
	if (keyboard_check_pressed(ord("E")) && _flag_triggered == false){
		_flag_triggered = true;
		_cooldown = 10;
		
		//AWARD TREASURE
		scr_roll_treasure_sparkle_reward();
		
		//ROLL NEW TREASURE
		scr_roll_treasure_sparkle_rarity();
		scr_roll_treasure_sparkle_position()
		scr_roll_treasure_sparkle_visibility();
	}
}
#endregion

#region CLICK COOLDOWNS
if (_cooldown > 0){
    _cooldown--;

    if (_cooldown <= 0){
        _cooldown = 0;
        _flag_triggered = false;
    }
}
#endregion