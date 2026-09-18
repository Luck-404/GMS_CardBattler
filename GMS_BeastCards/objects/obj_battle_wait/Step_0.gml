//===============================================================================//
//
// STEP: OBJ_BATTLE_WAIT
// FUNCTION: Counts down the object's lifespan.
//           Destroys the instance when its timer reaches zero.
//
//===============================================================================//

//================//
//COUNTDOWN//
//================//

_ct_life--;

if (_ct_life <= 0){
	instance_destroy();
}