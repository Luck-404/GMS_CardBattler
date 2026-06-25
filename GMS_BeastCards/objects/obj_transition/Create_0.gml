//===============================================================================//
//
// CREATE: OBJ_TRANSITION
// FUNCTION: Initializes automatic transition state.
//           Stores destination room and fader reference.
//           Begins transition flow on the next Step event.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
_flag_triggered = false;
_flag_continue_transition = false;

_ref_fader = undefined;

_rm_destination = rm_ow_center;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//