//===============================================================================//
//
// SCRIPT: SCR_OVERWORLD_BEAST_RESOLVE_WALL_COLLISION
// FUNCTION: Prevents OBJ_OVERWORLD_BEAST movement from entering
//           OBJ_OVERWORLD_WALL. Resolves X and Y separately so diagonal movement
//           may slide along a wall instead of always snapping fully backward.
//
//           This helper is intended to be called from OBJ_OVERWORLD_BEAST Step and
//           therefore operates on the calling Beast instance's x/y/collision mask.
//
// ARGUMENTS: _val_old_x / _val_old_y - Beast position before this movement pass.
// RETURNS: True when movement was blocked or adjusted by a wall.
//
//===============================================================================//

function scr_overworld_beast_resolve_wall_collision(
	_val_old_x,
	_val_old_y
){

	if (!object_exists(obj_overworld_wall)){
		return false;
	}

	var _val_target_x = x;
	var _val_target_y = y;

	if (!place_meeting(x,y,obj_overworld_wall)){
		return false;
	}

	//================//
	//X AXIS//
	//================//
	x = _val_target_x;
	y = _val_old_y;

	if (place_meeting(x,y,obj_overworld_wall)){
		x = _val_old_x;
	}

	//================//
	//Y AXIS//
	//================//
	y = _val_target_y;

	if (place_meeting(x,y,obj_overworld_wall)){
		y = _val_old_y;
	}

	//================//
	//FINAL SAFETY//
	//================//
	if (place_meeting(x,y,obj_overworld_wall)){
		x = _val_old_x;
		y = _val_old_y;
	}

	return (
		abs(x - _val_target_x) > 0.001 ||
		abs(y - _val_target_y) > 0.001
	);
}
