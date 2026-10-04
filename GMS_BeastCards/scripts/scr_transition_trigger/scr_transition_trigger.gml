//===============================================================================//
//
// SCRIPT: SCR_TRANSITION_TRIGGER
// FUNCTION: Claims and creates one automatic room transition.
//           Assigns its destination room and returns the created Transition.
//           Rejects creation when another transition/fader already owns the
//           active room transition.
//
// ARGUMENTS: _rm_destination - Destination room asset.
// RETURNS: Created obj_transition instance, or undefined on failure.
//
//===============================================================================//

function scr_transition_trigger(_rm_destination){

	#region VALIDATION

	//======================//
	//ACTIVE TRANSITION LOCK//
	//======================//
	if (
		instance_exists(obj_transition) ||
		instance_exists(obj_transition_fader)
	){
		return undefined;
	}

	#endregion

	#region CREATE TRANSITION

	//===================//
	//CREATE TRANSITION//
	//===================//
	var _ref_transition =
		instance_create_layer(
			room_width * 0.5,
			room_height * 0.5,
			"ily_fx",
			obj_transition
		);

	if (!instance_exists(_ref_transition)){
		return undefined;
	}

	//======================//
	//SET DESTINATION ROOM//
	//======================//
	_ref_transition._rm_destination =
		_rm_destination;

	#endregion

	return _ref_transition;
}