//===============================================================================//
//
// DRAW: OBJ_SCENE_FX_STEP_PARTICLE
// FUNCTION: Draws the footstep particle.
//           Applies terrain-based color tinting.
//           Rotates sprite using particle direction.
//
//===============================================================================//

draw_sprite_ext(spr_scene_fx_step_particle,0,x,y,1,1,direction,_color,1);