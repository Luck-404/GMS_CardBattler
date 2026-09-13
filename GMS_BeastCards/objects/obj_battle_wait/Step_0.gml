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
if (_ct_life > 0){
	_ct_life--;
}
else{
	instance_destroy();
}