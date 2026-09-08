//===============================================================================//
//
// CREATE: OBJ_BATTLE_VFX
// FUNCTION: Initializes a battle visual effect.
//           Supports temporary VFX, persistent final-frame VFX,
//           persistent looping VFX, delayed starts, synchronized SFX,
//           and optional anchor following.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//

//------//
//ANCHOR//
//------//
_ref_anchor = undefined;

_flag_follow_anchor = false;

_val_offset_x = 0;
_val_offset_y = 0;

//----------------//
//PERSISTENT MODE//
//----------------//
_flag_persistent = false;
_flag_persistent_loop = false;

//-----------//
//START DELAY//
//-----------//
_ct_start_delay = 0;

//-----//
//SFX//
//-----//
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