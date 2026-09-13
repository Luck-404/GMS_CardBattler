//===============================================================================//
//
// ROOM START: OBJ_PLAYER
// FUNCTION: Resets overworld camera creation for the newly entered room.
//           Spawns the active companion Beast outside the battle room.
//
//===============================================================================//

//================//
//OVERWORLD SETUP//
//================//
if (room != rm_battle){

	_flag_camera_created = false;

	scr_overworld_spawn_companion_beast();
}