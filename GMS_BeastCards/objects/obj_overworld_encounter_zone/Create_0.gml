//===============================================================================//
//
// CREATE: OBJ_OVERWORLD_ENCOUNTER_ZONE
// FUNCTION: Initializes wild encounter variables, timers, and the logical
//           reward-zone ID used by the post-battle reward system.
//
//===============================================================================//

//================//
//VARIABLES//
//================//
_ct_encounter_attempt_cooldown = 0;
_val_encounter_chance = 10;

_ct_scene_fx_litter_timer = 0;

//----------------//
//REWARD ZONE//
//----------------//
// Override this per placed encounter-zone instance in room Instance Creation
// Code. Leaving it UNASSIGNED is safe and yields no area-specific loot.
_str_loot_zone_id = "UNASSIGNED";

//================//
//INIT//
//================//

//================//
//METHODS//
//================//