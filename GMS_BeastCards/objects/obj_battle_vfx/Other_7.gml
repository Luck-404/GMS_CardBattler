//===============================================================================//
//
// ANIMATION END: OBJ_BATTLE_VFX
// FUNCTION: Resolves battle VFX behavior after an animation cycle finishes.
//           Temporary effects destroy themselves.
//           Persistent hold effects freeze on their final frame.
//           Persistent loop effects continue looping.
//
//===============================================================================//

//================//
//PERSISTENT LOOP//
//================//
if (_flag_persistent_loop){

	image_index =
		0;

	image_speed =
		1;

	exit;
}

//================//
//PERSISTENT HOLD//
//================//
if (_flag_persistent){

	image_index =
		image_number - 1;

	image_speed =
		0;

	exit;
}

//===========//
//TEMPORARY//
//===========//
instance_destroy();