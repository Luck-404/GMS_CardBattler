//===============================================================================//
//
// CREATE: OBJ_BATTLE_STATUS
// FUNCTION: Initializes a battle Status instance.
//           Defines shared lifetime, ownership, callback, presentation,
//           stacking, cleanse, restriction, and trigger defaults.
//
//===============================================================================//

//================//
//STATUS IDENTITY//
//================//
_str_status_type = "DEFAULT";
_str_status_name = "NONE";
_str_status_desc = "NONE";

_spr_status = undefined;
_scr_status = undefined;

//================//
//HOST / OWNERSHIP//
//================//
_ref_host = undefined;
_ref_status_target = undefined;
_ref_source_minion = undefined;

_str_team = undefined;

_flag_status_requires_live_source_minion = false;

//================//
//STATUS LIFETIME//
//================//
_flag_status_permanent = false;

_val_status_lifetime = 3;
_val_status_lifetime_max = 3;

_flag_status_infinite = false;
_str_status_command = "WAIT";

//================//
//STATUS STACKING//
//================//
_ct_status_stacks = 1;

_flag_status_stackable = false;

//===================//
//STATUS MAGNITUDES//
//===================//
_val_status_magnitude = 0;
_val_status_damage = 0;

//================//
//STATUS CLEANSE//
//================//
_flag_status_uncleansable = false;

//================//
//TRIGGER TIMING//
//================//
_str_trigger_region = "START"; // START, END, or undefined
_str_buff_trigger = undefined;

//================//
//AURA SETTINGS//
//================//
_str_aura_scope = undefined;   // SELF, TEAMWIDE, GLOBAL
_str_aura_trigger = undefined; // HEALED, future trigger types

//===================//
//CC RESTRICTIONS//
//===================//
_flag_status_cc_immunity = false;

//===================//
//DODGE MODIFIERS//
//===================//
_flag_status_ignore_dodge = false;

//=======================//
//MOVEMENT RESTRICTIONS//
//=======================//
_flag_status_prevent_reposition = false;

//=========================//
//PERSISTENT PRESENTATION//
//=========================//
_ref_persistent_vfx = undefined;
_val_persistent_audio = -1;