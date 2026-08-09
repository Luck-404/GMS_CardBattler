//===============================================================================//
//
// CREATE: OBJ_BATTLE_STATUS
// FUNCTION: Initializes a battle status instance.
//           Stores lifetime, command state, script callback, host reference,
//           display data, stack count, and trigger timing.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//

// STATE
_val_status_lifetime = 3;
_val_status_lifetime_max = 3;

_flag_status_stackable = false;
_flag_status_infinite = false;

_str_status_command = "WAIT";

// SCRIPT
_scr_status = undefined;

// HOST / LINK
_ref_host = undefined;
_ref_status_target = undefined;
_ref_source_minion = undefined;

// STATUS DATA
_str_status_type = "DEFAULT";
_str_status_name = "NONE";
_str_status_desc = "NONE";
_spr_status = undefined;

//----------------//
//STATUS CLEANSE//
//----------------//
_flag_status_uncleansable = false;

//------------------//
//STATUS MAGNITUDES//
//------------------//
_ct_status_stacks = 1;

_val_status_magnitude = 0;
_val_status_damage = 0;

//---------//
//TRIGGER//
//---------//
_str_trigger_region = "START"; // START, END, or undefined

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//