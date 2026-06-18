//===============================================================================//
//
// CREATE: OBJ_SCENE_FX_STEP_PARTICLE
// FUNCTION: Initializes a short-lived footstep particle.
//           Detects terrain beneath the player and assigns
//           an appropriate particle color.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
direction = irandom(359);
speed = 1;
_life = 5;
_color = c_white;
_owner = obj_player;

//----//
//INIT//
//----//
_pathmap = layer_tilemap_get_id("tly_paths");
_tile = tilemap_get_at_pixel(_pathmap, _owner.x, _owner.y);
_tile_index = tile_get_index(_tile);

if (_tile_index == 2) { // dirt
    _color = make_colour_rgb(102,82,53);
}

else if (_tile_index == 3) { // stone
    _color = make_colour_rgb(102,102,102);
}

else if (_tile_index == 7) { // wood
    _color = make_colour_rgb(204,163,108);
}

else { // grass
    _color = make_colour_rgb(82,127,78);
}

//-------//
//METHODS//
//-------//