//===============================================================================//
//
// DRAW: OBJ_OVERWORLD_VFX_STEP_PARTICLE
// FUNCTION: Draws the footstep particle.
//           Applies its terrain-based color and movement direction.
//
//===============================================================================//

//================//
//DRAW PARTICLE//
//================//
draw_sprite_ext(
	spr_overworld_vfx_step_particle,
	0,
	x,
	y,
	1,
	1,
	direction,
	_c_color,
	1
);