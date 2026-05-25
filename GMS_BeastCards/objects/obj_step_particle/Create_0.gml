//
//
// CREATE: OBJ_STEP_PARTICLE
//
//

_pathmap = layer_tilemap_get_id("tly_paths");
_tile = tilemap_get_at_pixel(_pathmap, obj_player.x, obj_player.y);
_tile_index = tile_get_index(_tile);

if (_tile_index == 2) { // dirt
    _color = make_colour_rgb(188,152,99);
}

else if (_tile_index == 3) { // stone
    _color = make_colour_rgb(147,147,147);
}

else if (_tile_index == 7) { // wood
    _color = make_colour_rgb(137,110,73);
}

else { // grass
    _color = make_colour_rgb(134,207,128);
}

direction = irandom(359);
speed = 1;
_life = 5;