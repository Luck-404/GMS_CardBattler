//===============================================================================//
//
// SCRIPT: SCR_INIT_BATTLE_WAIT
// FUNCTION: Creates a temporary wait object.
//           Prevents battle flow from continuing until the timer expires.
//           Assigns the specified lifespan to the wait object.
//
//===============================================================================//
function scr_init_battle_wait(_ct_lifespan){
	var _ref_new_waiter = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_wait);
	_ref_new_waiter._ct_life = _ct_lifespan;
}