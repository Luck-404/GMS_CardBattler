//===============================================================================//
//
// CREATE: OBJ_TRANSITION_ZONE
// FUNCTION: Initializes room transition trigger state.
//           Stores the fader reference used during transition flow.
//           Waits for player contact before beginning the transition.
//
//===============================================================================//

//================//
//VARIABLES//
//================//
_flag_triggered = false;
_flag_continue_transition = false;

_ref_fader = undefined;

//================//
//INIT//
//================//

//================//
//METHODS//
//================//