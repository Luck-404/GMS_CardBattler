//===============================================================================//
//
// DRAW: OBJ_DECOR_GRASS
// FUNCTION:	Draws a ground shadow beneath decor object
//
//===============================================================================//

draw_sprite_ext(spr_decor_shadow,image_index,x,y,_shadow_scalar,_shadow_scalar,0,c_white,1);
draw_self();	
