//===============================================================================//
//
// CREATE: OBJ_TRANSITION_ZONE
// FUNCTION: Initializes room transition trigger state.
//           Stores fader reference for fade-out and fade-in control.
//           Waits for player contact before starting transition flow.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
_flag_triggered = false;
_flag_continue_transition = false;

_ref_fader = undefined;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//