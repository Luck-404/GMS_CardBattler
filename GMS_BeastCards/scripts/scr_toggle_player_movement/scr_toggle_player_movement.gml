//===============================================================================//
//
// SCR_TOGGLE_PLAYER_MOVEMENT
// FUNCTION:	Toggles player movement based on input state tag.
//				Stop reduces movement to 0 and stops any relevant animations.
//				Start will return the player's move speed to 3, allowing movement.
// RETURNS: VOID
//
//===============================================================================//
function scr_toggle_player_movement(_str_state){
	if (_str_state == "STOP"){	//STOP
		obj_player._val_player_speed = 0;
		obj_player._flag_player_moving = false;	
		obj_player._flag_player_sprinting = false;
	} else {	//START
		obj_player._val_player_speed = 3 * global._val_bonus_speed_scalar;
	}
}