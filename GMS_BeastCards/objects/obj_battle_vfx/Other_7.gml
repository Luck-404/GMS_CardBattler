//===============================================================================//
//
// ANIMATION END: OBJ_BATTLE_VFX
// FUNCTION: Resolves battle VFX behavior after an animation cycle.
//           Temporary effects destroy themselves.
//           Persistent hold effects freeze on their final frame.
//           Persistent loop effects restart from their first frame.
//
//===============================================================================//

#region PERSISTENT LOOP

//================//
//PERSISTENT LOOP//
//================//
if (_flag_persistent_loop){

	image_index = 0;
	image_speed = 1;

	exit;
}

#endregion

#region PERSISTENT HOLD

//================//
//PERSISTENT HOLD//
//================//
if (_flag_persistent){

	image_index = image_number - 1;
	image_speed = 0;

	exit;
}

#endregion

#region TEMPORARY

//===========//
//TEMPORARY//
//===========//
instance_destroy();

#endregion