function scr_find_valid_tile_in_tilemap() {
	show_debug_message("!!=== SCR_FIND_TILE: FINDING A TILE ===!!");		
    var _tilemap_id = layer_tilemap_get_id("ts_overworld");
    var _tile_width = 32;  // Width in tiles
    var _tile_height = 32; // Height in tiles
    var _tile_size = 32;  // Size of individual tiles (assuming square tiles)

    var _valid_positions = ds_list_create(); // List to store valid tiles

    // Loop through every tile in the tilemap
    for (var _x = 0; _x < _tile_width; _x++) {
        for (var _y = 0; _y < _tile_height; _y++) {
            // Convert tilemap coordinates to world coordinates
            var _world_x = _x * _tile_size;
            var _world_y = _y * _tile_size;

            // Check if the tile at this position is not blank (tile index != 0)
            var _tile = tilemap_get_at_pixel(_tilemap_id, _world_x, _world_y);
            if (_tile > 0) { // Tile index > 0 indicates a valid tile
                ds_list_add(_valid_positions, [_world_x, _world_y]);
            }
        }
    }

    // Pick a random valid tile
    var _chosen_position = noone;
    if (ds_list_size(valid_positions) > 0) {
        _chosen_position = ds_list_find_value(_valid_positions, irandom(ds_list_size(_valid_positions) - 1));
    }
    ds_list_destroy(_valid_positions); // Clean up the list
	show_debug_message("!!=== SCR_FIND_TILE: FINDING A TILE ===!!");				
    return _chosen_position; // Return chosen tile position (world coordinates) or noone
}