show_debug_message("[[]] OBJ_TRANSITION: CREATED [[]]");	

///////////////
// VARIABLES //
///////////////
image_alpha = 0;         // Start fully transparent
_fade_speed = 0.06;      // Adjust fade speed
_target_room = -1;       // Room to transition to
_is_fading = false;      // Controls if fade is active
_is_fading_in = true;    // Start with fade in
_is_fading_out = false;  // Fade out state
_flag_encounter_in = false;
_flag_overworld_in = false;
depth = -10000;