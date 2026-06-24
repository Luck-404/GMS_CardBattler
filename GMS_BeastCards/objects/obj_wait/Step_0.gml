//===============================================================================//
//
// STEP: OBJ_WAIT_NEXT
// FUNCTION: Counts down object lifespan.
//           Destroys the instance when its timer reaches zero.
//
//===============================================================================//

//---------//
//COUNTDOWN//
//---------//
if (_ct_life > 0){
	_ct_life--;
} else {
	instance_destroy();
}