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
_ct_life = 5;
_c_color = c_white;
_ref_owner = obj_player;

//----//
//INIT//
//----//
_ref_pathmap = layer_tilemap_get_id("tly_paths");
_tile_under_owner = tilemap_get_at_pixel(_ref_pathmap, _ref_owner.x, _ref_owner.y);
_val_tile_index = tile_get_index(_tile_under_owner);

if (_val_tile_index == 2) { // dirt
    _c_color = make_colour_rgb(102,82,53);
}

else if (_val_tile_index == 3) { // stone
    _c_color = make_colour_rgb(102,102,102);
}

else if (_val_tile_index == 7) { // wood
    _c_color = make_colour_rgb(204,163,108);
}

else { // grass
    _c_color = make_colour_rgb(82,127,78);
}

//-------//
//METHODS//
//-------//