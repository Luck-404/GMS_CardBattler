//===============================================================================//
//
// CREATE: OBJ_TRANSITION_FADER
// FUNCTION: Initializes transition fade state.
//           Stores transition reference and fade direction flags.
//           Creates spinner visual while transition is processing.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
_val_alpha = 0;
_val_fade_speed = 0.07;

_ref_transition = undefined;
_ref_spinner = undefined;

_flag_fade_out = false;
_flag_fade_in = false;

//----//
//INIT//
//----//
depth = -999;

_ref_spinner = instance_create_layer(x,y,"ily_fx",obj_transition_spinner);

//-------//
//METHODS//
//-------//