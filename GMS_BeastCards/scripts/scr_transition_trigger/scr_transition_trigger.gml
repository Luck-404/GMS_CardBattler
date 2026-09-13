//===============================================================================//
//
// SCRIPT: SCR_TRANSITION_TRIGGER
// FUNCTION: Creates an automatic transition object.
//           Assigns its destination room.
//           The transition flow begins on the object's next Step event.
//
// ARGUMENTS: _rm_destination is the destination room asset.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_transition_trigger(_rm_destination){

	//===================//
	//CREATE TRANSITION//
	//===================//
	var _ref_transition = instance_create_layer(room_width / 2,room_height / 2,"ily_fx",obj_transition);

	//======================//
	//SET DESTINATION ROOM//
	//======================//
	_ref_transition._rm_destination = _rm_destination;
}