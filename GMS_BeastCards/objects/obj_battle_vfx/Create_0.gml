//===============================================================================//
//
// CREATE: OBJ_BATTLE_VFX
// FUNCTION: Initializes a battle visual effect.
//           Stores anchor, persistence, delay, and synchronized SFX data.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
_ref_anchor = undefined;

_flag_follow_anchor = false;
_flag_persistent = false;

_val_offset_x = 0;
_val_offset_y = 0;

_ct_start_delay = 0;

_snd_sfx = undefined;
_flag_sfx_played = false;

//----//
//INIT//
//----//
image_index = 0;
image_speed = 1;

//-------//
//METHODS//
//-------//