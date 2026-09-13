//===============================================================================//
//
// DRAW: OBJ_OVERWORLD_VFX_PLANT_LITTER
// FUNCTION: Draws one randomized piece of plant litter.
//           Applies frame variation, scale, and rotation.
//
//===============================================================================//

//================//
//DRAW LITTER//
//================//
draw_sprite_ext(
	spr_overworld_vfx_plant_litter,
	_it_sprite_frame,
	x,
	y,
	_val_scale,
	_val_scale,
	_val_rotation,
	c_white,
	1
);