//===============================================================================//
//
// STEP: OBJ_GUI_WORLD_EVENT_BANNER
// FUNCTION: Advances the World Event banner lifetime and removes it after the
//           configured display duration.
//
//===============================================================================//

_ct_life++;

if (_ct_life >= _ct_life_max){
	instance_destroy();
}
