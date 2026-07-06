//===============================================================================//
//
// ROOM START: OBJ_PLAYER
// FUNCTION: Allows for the creation of a new camera in each room entered.
//			 Does not trigger in rm_battle.
//
//===============================================================================//
if (room != rm_battle){
	_flag_created_camera = false;
	scr_spawn_player_follow_beast();
}