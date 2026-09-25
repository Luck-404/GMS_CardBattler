//===============================================================================//
//
// DRAW: OBJ_OVERWORLD_TREASURE_CHEST
// FUNCTION: Draws the treasure chest and ground shadow.
//           Shows interaction feedback while the player is nearby.
//           Input, proximity audio, and loot resolution are handled in Step.
//
//===============================================================================//

//================//
//DRAW CHEST//
//================//
draw_sprite_ext(
    spr_overworld_decor_shadow,
    0,
    x,
    y,
    0.3,
    0.3,
    0,
    _c_chest,
    1
);

draw_sprite_ext(
    spr_overworld_treasure_chest,
    image_index,
    x,
    y,
    1,
    1,
    0,
    _c_chest,
    1
);

//================//
//OPENED STATE//
//================//
if (_flag_triggered){

    image_index = 1;

    return;
}

//================//
//INTERACTION HIGHLIGHT//
//================//
if (
    instance_exists(obj_player) &&
    distance_to_object(obj_player) < 48 &&
    !global.flag_pause
){

    draw_sprite(
        spr_overworld_treasure_chest_highlight,
        0,
        x,
        y
    );
}