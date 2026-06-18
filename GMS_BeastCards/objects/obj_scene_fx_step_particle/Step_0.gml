//===============================================================================//
//
// STEP: OBJ_SCENE_FX_STEP_PARTICLE
// FUNCTION: Counts down particle lifetime.
//           Destroys the particle when its life expires.
//           Handles per-frame particle updates.
//
//===============================================================================//

if (_life <= 0){
	instance_destroy();	
} else {
	_life--;
}

if (_life <= 0){
	instance_destroy();	
} else {
	_life--;
}