//===============================================================================//
//
// CLEAN UP: OBJ_NPC
// FUNCTION: Clears global references pointing to this NPC.
//           Prevents stale interaction references after room changes or destruction.
//
//===============================================================================//

if (
	variable_global_exists("ref_interacting_npc") &&
	global.ref_interacting_npc == self
){
	global.ref_interacting_npc = undefined;
}