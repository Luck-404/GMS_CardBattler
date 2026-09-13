//===============================================================================//
//
// CREATE: OBJ_OVERWORLD_DECOR_SIGN
// FUNCTION: Initializes sign interaction state.
//           Inherits shared overworld decor behavior.
//           Applies the sign sprite assigned to this instance.
//
//===============================================================================//

//================//
//INHERIT PARENT//
//================//
event_inherited();

//================//
//VARIABLES//
//================//
_flag_triggered = false;
_ct_interaction_cooldown = 60;

//================//
//INIT//
//================//
sprite_index = _spr_sign;

//================//
//METHODS//
//================//