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

// VISUALS
_spr_minion = undefined;

// STATS
_val_cur_hp = 2;
_val_max_hp = 2;
_val_magnitude = 0;

// FLAGS
_flag_host_greyed = false;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//