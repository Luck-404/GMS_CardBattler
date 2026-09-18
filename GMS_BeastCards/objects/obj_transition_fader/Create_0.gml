
//===============================================================================//
// CREATE: OBJ_TRANSITION_FADER
// FUNCTION: Initializes persistent room and battle transitions.
//===============================================================================//

#region VARIABLES

//----------------//
//FADE SETTINGS//
//----------------//

_val_alpha = 0;
_val_fade_speed = 0.07;
_val_battle_background_alpha = 0.35;

//----------------//
//SPINNER SETTINGS//
//----------------//

_ct_black_hold = 0;

_val_spinner_rotation = 0;
_val_spinner_speed = 10;

//----------------//
//TRANSITION STATE//
//----------------//

_str_transition_state = "FADE_OUT";

_ref_transition = undefined;

_flag_fade_out = false;
_flag_fade_in = false;

_flag_wait_for_battle_pane = false;

_flag_battle_pane_ready = false;
_flag_battle_pane_spawned = false;

_flag_battle_waiting_for_input = false;
_flag_battle_finish = false;

#endregion

#region INIT

//------------------------//
//SURVIVE ROOM TRANSITIONS//
//------------------------//

persistent = true;

//----------------//
//DRAW ABOVE ROOM//
//----------------//

depth = -15000;

// Spinner is drawn directly by this object's Draw GUI Event.
// Do not create obj_transition_spinner here.

#endregion