//===============================================================================//
//
// STEP: OBJ_OVERWORLD_VFX_STEP_PARTICLE
// FUNCTION: Updates the footstep particle lifetime.
//           Destroys the particle when its lifetime expires.
//
//===============================================================================//

//================//
//LIFETIME//
//================//
_ct_lifetime--;

if (_ct_lifetime <= 0){
	instance_destroy();
}