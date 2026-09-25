//===============================================================================//
//
// DRAW: OBJ_OVERWORLD_TREASURE_SPARKLE
// FUNCTION: Draws the active treasure sparkle.
//           Displays an interaction highlight while the player is nearby.
//           Proximity audio and interaction are handled in Step.
//
//===============================================================================//

//================//
//DRAW SPARKLE//
//================//
draw_sprite_ext(
    spr_overworld_treasure_sparkle,
    image_index,
    x,
    y,
    1,
    1,
    0,
    _c_sparkle,
    1
);

//================//
//INTERACTION HIGHLIGHT//
//================//
if (
    instance_exists(obj_player) &&
    distance_to_object(obj_player) < 48 &&
    !_flag_triggered &&
    !global.flag_pause
){

    draw_sprite(
        spr_overworld_treasure_sparkle_highlight,
        0,
        x,
        y
    );
}