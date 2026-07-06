//===============================================================================//
//
// DRAW: OBJ_BEAST_WORLD
// FUNCTION: Draws overworld beast shadow, wild disposition fog, and beast sprite.
//
//===============================================================================//

draw_sprite_ext(spr_decor_shadow,0,x,y+20,0.3,0.3,0,c_white,1);

if (_str_team == "WILD"){

	var _spr_fog = undefined;

	switch(_str_disposition){
		case "ANGRY":  _spr_fog = spr_wild_fog_angry;  break;
		case "SCARED": _spr_fog = spr_wild_fog_scared; break;
		case "CHILL":  _spr_fog = spr_wild_fog_chill;  break;
	}

	if (_spr_fog != undefined){
		draw_sprite(_spr_fog,0,x,y);
	}
}

draw_sprite_ext(_spr_beast,0,x,y,0.1 * image_xscale,0.1,0,c_white,1);