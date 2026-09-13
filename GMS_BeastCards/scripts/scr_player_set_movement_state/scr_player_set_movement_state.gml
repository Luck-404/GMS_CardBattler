//===============================================================================//
//
// SCRIPT: SCR_PLAYER_SET_MOVEMENT_STATE
// FUNCTION: Sets the player's movement state.
//           STOP disables movement and sprinting.
//           START restores movement using the current speed scalar.
//
// ARGUMENTS: _str_state is the requested movement state.
// RETURNS: True for a valid state change request; otherwise false.
//
//===============================================================================//

function scr_player_set_movement_state(_str_state){

	//================//
	//VALIDATE PLAYER//
	//================//
	if (!instance_exists(obj_player)){
		return false;
	}

	//================//
	//SET MOVEMENT STATE//
	//================//
	switch (_str_state){

		//======//
		//STOP//
		//======//
		case "STOP":

			obj_player._val_player_speed = 0;

			obj_player._flag_player_moving = false;
			obj_player._flag_player_sprinting = false;

			return true;

		//=======//
		//START//
		//=======//
		case "START":

			obj_player._val_player_speed =
				3 *
				global.val_bonus_speed_scalar;

			return true;

		//=======//
		//INVALID//
		//=======//
		default:

			scr_debug_log(
				"PLAYER",
				"MOVEMENT_STATE",
				obj_player,
				"INVALID PLAYER MOVEMENT STATE" +
				" | STATE: " +
				string_upper(_str_state),
				"ERROR",
				"SCR_PLAYER_SET_MOVEMENT_STATE"
			);

			return false;
	}
}