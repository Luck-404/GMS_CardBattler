if (_flag_interacted) {
    var new_position = scr_find_valid_tile_in_tilemap();
    if (new_position != noone) {
        var new_x = new_position[0];
        var new_y = new_position[1];
        instance_create_layer(new_x, new_y, "Terrain", obj_treasure); // Replace "Instances" with your desired layer
    }
    instance_destroy(); // Remove the current treasure
}