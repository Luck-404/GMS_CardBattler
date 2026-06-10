//===============================================================================//
//
// END STEP: OBJ_PLAYER
// FUNCTION:	Maintains proper depth sorting based on player position
//				Ensures the player renders correctly behind/in front of objects
//				Updates depth every frame using the sprite's bottom bound
//
//===============================================================================//
depth = -bbox_bottom;