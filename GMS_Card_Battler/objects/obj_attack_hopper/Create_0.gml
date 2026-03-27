//////////////////////////////////////////////////////////////////////
//					OBJ_ERROR_SHAKER CREATE							//
//																	//
// > INIT VARIABLES													//
//////////////////////////////////////////////////////////////////////
_target = noone;   // The object to shake (set on creation)
_shake_amount = 4; // Maximum pixels to move left/right
_shake_speed = 10; // Speed of shaking
_shake_timer = 0;  // Keeps track of time
_shaking = false;  // Is the target shaking?
_origin_y = 0;     // Stores original X position of target