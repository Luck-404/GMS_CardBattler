//////////////////////////////////////////////////////////////////////
//						OBJ_TREASURE STEP							//
//																	//
// > UPON INTERACTION, MAKE A NEW TREASURE IN A RANDOM SPOT			//
//////////////////////////////////////////////////////////////////////
if (_flag_interacted) {
    var _new_position = scr_find_valid_tile_in_tilemap();
    if (_new_position != noone) {
        var _new_x = _new_position[0];
        var _new_y = _new_position[1];
        instance_create_layer(_new_x, _new_y, "Terrain", obj_treasure); // Replace "Instances" with your desired layer
    }
    instance_destroy(); // Remove the current treasure
}