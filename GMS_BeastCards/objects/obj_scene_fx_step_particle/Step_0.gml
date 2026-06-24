//===============================================================================//
//
// STEP: OBJ_SCENE_FX_STEP_PARTICLE
// FUNCTION: Counts down particle lifetime.
//           Destroys the particle when its life expires.
//           Handles per-frame particle updates.
//
//===============================================================================//

if (_ct_life <= 0){
	instance_destroy();	
} else {
	_ct_life--;
}

if (_ct_life <= 0){
	instance_destroy();	
} else {
	_ct_life--;
}