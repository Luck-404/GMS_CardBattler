//===============================================================================//
//
// DRAW: OBJ_PLAYER
// FUNCTION: Updates walking and sprinting bounce animation.
//           Draws the player shadow and movement-adjusted player sprite.
//
//===============================================================================//

//================//
//UPDATE BOUNCE//
//================//
if (_flag_player_moving){

	_ct_player_bounce_timer++;

	var _ct_bounce_interval = _flag_player_sprinting ? 4 : 12;

	if (_ct_player_bounce_timer >= _ct_bounce_interval){

		_ct_player_bounce_timer = 0;

		_val_player_bounce_offset++;

		if (_val_player_bounce_offset > 4){
			_val_player_bounce_offset = 0;
		}
	}
}

//================//
//DRAW SHADOW//
//================//
draw_sprite(
	spr_player_shadow,
	0,
	x,
	y
);

//================//
//DRAW PLAYER//
//================//
draw_sprite_ext(
	spr_player,
	image_index,
	x,
	y + _val_player_bounce_offset,
	image_xscale,
	1,
	0,
	c_white,
	1
);