//===============================================================================//
//
// DRAW: OBJ_PLAYER
// FUNCTION:	Animates player bounce movement while walking or sprinting
//				Draws the player's shadow beneath the character
//				Draws the player sprite with movement-based visual offset
//
//===============================================================================//
#region CALCULATE BOUNCE WHILE MOVING
	//—------------------------------------------------------------------------------//
	// CALCULATE BOUNCE WHILE MOVING
	//—------------------------------------------------------------------------------//
	if (_flag_player_moving ){ //WHILE MOVING, BOUNCE THE PLAYER EVERY 1/8s (8 frames)
		_player_bounce_counter++;
		if (!_flag_player_sprinting && _player_bounce_counter >= 12){ //NOT SPRINTING
			_player_bounce_counter = 0;
			_player_bounce_frame++;
			if (_player_bounce_frame > 4){
				_player_bounce_frame = 0;
			}
		} else if (_player_bounce_counter >= 4){ //SPRINTING
			_player_bounce_counter = 0;
			_player_bounce_frame++;
			if (_player_bounce_frame > 4){
				_player_bounce_frame = 0;
			}
		}
	}
#endregion

//DRAW FOLLOWING SHADOW
draw_sprite(spr_player_shadow,0,x,y);

//DRAW SELF
draw_sprite_ext(spr_player,image_index,x,y + _player_bounce_frame,image_xscale,1,0,c_white,1);