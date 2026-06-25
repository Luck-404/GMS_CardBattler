//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_TRANSITION
// FUNCTION: Creates an automatic transition object.
//           Assigns the destination room.
//           Begins the transition sequence immediately.
//
//===============================================================================//
function scr_trigger_transition(_rm_destination){
	var _ref_transition = instance_create_layer(room_width / 2,room_height / 2,"ily_fx",obj_transition);
	_ref_transition._rm_destination = _rm_destination;
}