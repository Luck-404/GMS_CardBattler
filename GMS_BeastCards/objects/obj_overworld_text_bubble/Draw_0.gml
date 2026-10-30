//===============================================================================//
//
// DRAW: OBJ_OVERWORLD_TEXT_BUBBLE
// FUNCTION: Updates temporary text-bubble lifetime and distance cleanup.
//           Rendering is owned by Draw GUI so scenery cannot cover the bubble.
//
//===============================================================================//

//================//
//LIFESPAN//
//================//
if (_ct_life > 0){

	_ct_life--;

	if (_ct_life <= 0){
		instance_destroy();
		exit;
	}
}

//================//
//DISTANCE KILL//
//================//
if (
	instance_exists(obj_player) &&
	distance_to_object(obj_player) > 256
){
	instance_destroy();
}
