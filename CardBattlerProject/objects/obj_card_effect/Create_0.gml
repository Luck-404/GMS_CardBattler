//////////////////////////////////////////////////////////////////////
//					OBJ_CARD_EFFECT CREATE							//
//																	//
// > ESTABLISH VARIABLES											//
//////////////////////////////////////////////////////////////////////
_life = 120;
_color = c_white;
_xscale = 1;
_yscale = 1;
_sprite = undefined;
_x2 = 1920;
_y2 = 540;
_proj_speed = 1;
_motion_type = "Stationary";
_secondary_script = undefined;
_move = false;

_psys = part_system_create(ps_verdant_projectile);
_psys2 = part_system_create(ps_deadseed_beam);

if (x > 960){
 part_system_angle(_psys,0);
 part_system_angle(_psys2,0); 
}