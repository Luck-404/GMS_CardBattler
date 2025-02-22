//////////////////////////////////////////////////////////////////////
//				SCR_FIND_VALID_TILE_IN_TILEMAP						//
//																	//
// > USED BY OVERWORLD PIPELINE TO PLACE 3 RANDOM TREASURES			//
//////////////////////////////////////////////////////////////////////
function scr_find_valid_tile_in_tilemap() {	
    var _tilemap_id = layer_tilemap_get_id("tl_overworld");
	var _walls_id = layer_tilemap_get_id("tl_walls");
    var _tile_width = 180;  // Width in tiles
    var _tile_height = 180; // Height in tiles
    var _tile_size = 32;  // Size of individual tiles (assuming square tiles)

    var _valid_positions = ds_list_create(); // List to store valid tiles

    // Loop through every tile in the tilemap
    for (var _x = 0; _x < _tile_width; _x++) {
        for (var _y = 0; _y < _tile_height; _y++) {
            // Convert tilemap coordinates to world coordinates
            var _world_x = _x * _tile_size;
            var _world_y = _y * _tile_size;

            // Check if the tile at this position is not blank (tile index != 0)
            var _tile_open = tilemap_get_at_pixel(_tilemap_id, _world_x, _world_y);
			var _no_wall = tilemap_get_at_pixel(_walls_id, _world_x, _world_y);
            if (_tile_open > 0 && _no_wall == 0) { // Tile index > 0 indicates a valid tile
                ds_list_add(_valid_positions, [_world_x, _world_y]);
            }
        }
    }

    // Pick a random valid tile
	randomise();
    var _chosen_position = noone;
    if (ds_list_size(_valid_positions) > 0) {
        _chosen_position = ds_list_find_value(_valid_positions, irandom(ds_list_size(_valid_positions) - 1));
    }
    ds_list_destroy(_valid_positions); // Clean up the list				
    return _chosen_position; // Return chosen tile position (world coordinates) or noone
}