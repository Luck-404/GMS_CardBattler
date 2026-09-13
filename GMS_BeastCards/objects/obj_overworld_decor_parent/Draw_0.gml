//===============================================================================//
//
// DRAW: OBJ_OVERWORLD_DECOR_PARENT
// FUNCTION: Draws a shared ground shadow beneath decor objects.
//           Fades decorations while overlapping the player.
//           Preserves normal child decor drawing behavior.
//
//===============================================================================//

//================//
//DRAW SHADOW//
//================//
draw_sprite_ext(
	spr_overworld_decor_shadow,
	0,
	x,
	y,
	_val_shadow_scale,
	_val_shadow_scale,
	0,
	c_white,
	1
);

//================//
//DRAW DECOR//
//================//
if (instance_place(x,y - 12,obj_player) != noone){

	draw_set_alpha(0.75);
	draw_self();
	draw_set_alpha(1);
}
else{
	draw_self();
}