//===============================================================================//
//
// DRAW: OBJ_OVERWORLD_BEAST
// FUNCTION: Draws the overworld Beast shadow and sprite.
//           Wild Beasts also display disposition-specific fog.
//
//===============================================================================//

//================//
//VALIDATE BEAST//
//================//
if (_stct_unit == undefined || _spr_beast == undefined){
	exit;
}

//================//
//DRAW SHADOW//
//================//
if (_spr_shadow != undefined){

	draw_sprite_ext(
		_spr_shadow,
		0,
		x,
		y + 24,
		0.75,
		0.75,
		0,
		c_white,
		1
	);
}

//================//
//WILD DISPOSITION//
//================//
if (_str_team == "WILD"){

	var _spr_fog = undefined;

	switch (_str_disposition){

		case "ANGRY":
			_spr_fog = spr_overworld_vfx_wild_fog_angry;
		break;

		case "SCARED":
			_spr_fog = spr_overworld_vfx_wild_fog_scared;
		break;

		case "CHILL":
			_spr_fog = spr_overworld_vfx_wild_fog_chill;
		break;
	}

	if (_spr_fog != undefined){
		draw_sprite(_spr_fog,0,x,y);
	}
}

//================//
//DRAW BEAST//
//================//
draw_sprite_ext(
	_spr_beast,
	0,
	x,
	y,
	0.1 * image_xscale,
	0.1,
	0,
	c_white,
	1
);