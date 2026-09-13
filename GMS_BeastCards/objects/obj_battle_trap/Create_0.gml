//===============================================================================//
//
// CREATE: OBJ_BATTLE_TRAP
// FUNCTION: Initializes a battle Trap.
//           Stores host and ownership context, Trap identity, trigger rules,
//           targeting scope, magnitude, and its activation callback.
//
//===============================================================================//

//================//
//TRAP REFERENCES//
//================//
_ref_host = undefined;
_ref_owner = undefined;
_ref_source_card = undefined;

//================//
//TRAP OWNERSHIP//
//================//
_str_owner_team = "";
_str_target_team = "";

//================//
//TRAP IDENTITY//
//================//
_str_trap_id = "";
_str_trap_name = "";

//================//
//TRIGGER RULES//
//================//
_str_trigger_type = "";
_str_trigger_phase = "BEFORE";

_flag_triggered = false;

//================//
//TRAP BEHAVIOR//
//================//
_str_trap_scope = "HOST";
_val_magnitude = 0;

_scr_trap_callback = undefined;

//================//
//PRESENTATION//
//================//
visible = false;