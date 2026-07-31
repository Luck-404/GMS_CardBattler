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
_str_status_command = "WAIT";

// SCRIPT
_scr_status = undefined;

// HOST
_ref_host = undefined;

// STATUS DATA
_str_status_type = "DEFAULT";
_str_status_name = "NONE";
_str_status_desc = "NONE";
_spr_status = undefined;

// STACKS / TRIGGER
_ct_status_stacks = 1;
_val_status_damage = 0;
_str_trigger_region = "START"; // START, END, or undefined

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//