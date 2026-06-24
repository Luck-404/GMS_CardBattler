//
//
// CREATE: OBJ_TRANSITION_FADER
//
//

//VARIABLES
_alpha = 0;
_ref_transition_obj = undefined;
_flag_fade_out = false;
_flag_fade_in = false;
_fade_speed = 0.07;

//INIT
depth = -999;
_ref_spinner = instance_create_layer(x,y,"ily_fx",obj_transition_spinner); //SPAWN SPINNER

//METHODS