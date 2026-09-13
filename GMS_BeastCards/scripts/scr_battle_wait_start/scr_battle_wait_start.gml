//===============================================================================//
//
// SCRIPT: SCR_BATTLE_INIT_WAIT
// FUNCTION: Creates a temporary battle wait object.
//           Prevents battle flow from continuing until its timer expires.
//           Assigns the specified lifespan to the wait object.
//
// ARGUMENTS: _ct_lifespan is the wait duration in frames.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_battle_init_wait(_ct_lifespan){

	//================//
	//CREATE WAIT//
	//================//
	var _ref_wait = instance_create_layer(room_width / 2,room_height / 2,"ily_fx",obj_battle_wait);

	//================//
	//SET LIFESPAN//
	//================//
	_ref_wait._ct_life = _ct_lifespan;
}