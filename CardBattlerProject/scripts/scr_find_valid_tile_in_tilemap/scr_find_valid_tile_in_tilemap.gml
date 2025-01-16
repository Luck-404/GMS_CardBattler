function scr_find_valid_tile_in_tilemap() {
	show_debug_message("!!=== SCR_FIND_TILE: FINDING A TILE ===!!");		
    var tilemap_id = layer_tilemap_get_id("ts_overworld");
    var tile_width = 32;  // Width in tiles
    var tile_height = 32; // Height in tiles
    var tile_size = 32;  // Size of individual tiles (assuming square tiles)

    var valid_positions = ds_list_create(); // List to store valid tiles

    // Loop through every tile in the tilemap
    for (var _x = 0; _x < tile_width; _x++) {
        for (var _y = 0; _y < tile_height; _y++) {
            // Convert tilemap coordinates to world coordinates
            var world_x = _x * tile_size;
            var world_y = _y * tile_size;

            // Check if the tile at this position is not blank (tile index != 0)
            var tile = tilemap_get_at_pixel(tilemap_id, world_x, world_y);
            if (tile > 0) { // Tile index > 0 indicates a valid tile
                ds_list_add(valid_positions, [world_x, world_y]);
            }
        }
    }

    // Pick a random valid tile
    var chosen_position = noone;
    if (ds_list_size(valid_positions) > 0) {
        chosen_position = ds_list_find_value(valid_positions, irandom(ds_list_size(valid_positions) - 1));
    }
    ds_list_destroy(valid_positions); // Clean up the list
	show_debug_message("!!=== SCR_FIND_TILE: FINDING A TILE ===!!");				
    return chosen_position; // Return chosen tile position (world coordinates) or noone
}