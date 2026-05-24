//
//
// CREATE- OBJ_FADER
//
//
depth = -999;
_alpha = 0;

_ref_transition = undefined;

//SPAWN SPINNER
_ref_spinner = instance_create_layer(x,y,"ily_fx",obj_spinner);

//FADE IN FLAG
_flag_fade_out = false;
_flag_fade_in = false;

//MODE SETUP
_mode = "DEFAULT";
_progress_tier = 0;

_fade_speed = 0.07;