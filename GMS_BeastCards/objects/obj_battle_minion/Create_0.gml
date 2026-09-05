//===============================================================================//
//
// CREATE: OBJ_BATTLE_MINION
// FUNCTION: Initializes a battle minion.
//           Stores host, team, health, effect magnitude, sprite,
//           and display state.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//

// REFERENCES
_ref_host = undefined;

// IDENTITY
_str_name = "DEFAULT";
_str_team = "PLAYER";
_str_minion_tag = "NONE";

// VISUALS
_spr_minion = undefined;

//-------------------//
//SUMMON VFX MOTION//
//-------------------//
_val_vfx_scale = 1;
_str_vfx_motion = "NONE";

_ct_vfx_motion = 0;
_ct_vfx_motion_duration = 1;

_val_vfx_motion_intensity = 0;

_val_vfx_offset_x = 0;
_val_vfx_offset_y = 0;

// STATS
_val_cur_hp = 2;
_val_max_hp = 2;
_val_magnitude = 0;


//----------------//
//BASE SPAWN STATS//
//----------------//
_val_base_max_hp = 0;
_val_base_magnitude = 0;

_ct_age = 0;

// FLAGS
_flag_host_greyed = false;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//