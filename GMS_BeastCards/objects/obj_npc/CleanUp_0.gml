//===============================================================================//
//
// CLEANUP: OBJ_NPC
// FUNCTION: Clears global references pointing to this NPC.
//           Prevents stale interaction references after destruction or room changes.
//
//===============================================================================//

//================//
//CLEAR INTERACTION REF//
//================//
if (variable_global_exists("ref_interacting_npc") && global.ref_interacting_npc == self){
	global.ref_interacting_npc = undefined;
}