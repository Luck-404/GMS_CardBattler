//
//
// DRAW - OBJ_PLAYER
//
//
depth = 0;

//WHILE MOVING, BOUNCE THE PLAYER EVERY 1/8s (8 frames)
if (_flag_moving){
	_player_bounce_counter++;
	
	//bounce
	if (_player_bounce_counter >= 8){
		_player_bounce_counter = 0;
		_player_bounce_frame++;
		//bounce a max of 4 px high
		if (_player_bounce_frame > 4){
			_player_bounce_frame = 0;
		}
	}
}

//DRAW FOLLOWING SHADOW
draw_sprite(spr_player_shadow,0,x,y);

//DRAW SELF
draw_sprite_ext(spr_player,image_index,x,y + _player_bounce_frame,image_xscale,1,0,c_white,1);