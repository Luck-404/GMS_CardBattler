show_debug_message("|\/| OBJ_ENCOUNTER: CREATED AND ALIVE |\/|");
///////////////
// VARIABLES //
///////////////
global.steps = 0;
global.can_encounter = false;
_previous_tile_x = obj_player.x div 32; // Initialize previous tile position to the player's starting position
_previous_tile_y = obj_player.y div 32;