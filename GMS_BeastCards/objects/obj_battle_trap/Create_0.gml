//===============================================================================//
//
// CREATE: OBJ_BATTLE_TRAP
// FUNCTION: Initializes a battle Trap.
//           Stores its host, owner, trigger condition, identity,
//           and callback used when the Trap activates.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//

// REFERENCES
_ref_host = undefined;
_ref_owner = undefined;
_ref_source_card = undefined;

_str_owner_team = "";

_str_trap_id = "";
_str_trap_name = "";

_str_trigger_type = "";

_scr_trap = undefined;

_val_magnitude = 0;

_flag_triggered = false;

//----//
//INIT//
//----//

visible = false;

//-------//
//METHODS//
//-------//