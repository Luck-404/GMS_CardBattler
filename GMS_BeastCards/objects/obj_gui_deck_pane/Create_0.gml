//
//
// CREATE: OBJ_GUI_DECK_PANE
//
//

//
// VARIABLES
//
depth = -1;

// DECK REFERENCE
_card_count = ds_list_size(global.player_deck);
_type = "DECK";
// PANE SIZING
_pane_w = 800;
_pane_h = 800;
_pane_left = x - (_pane_w * 0.5);
_pane_top  = y - (_pane_h * 0.5);
_cols = 6;
_rows = 5;
_slot_w = 104;
_slot_h = 145;
_spacing_x = 10;
_spacing_y = 10;
_grid_w = (_cols * _slot_w) + ((_cols - 1) * _spacing_x);
_grid_h = (_rows * _slot_h) + ((_rows - 1) * _spacing_y);
_grid_start_x = x - (_grid_w * 0.5);
_grid_start_y = y - (_grid_h * 0.5);
_card_scale = 0.23;
_preview_scale = 1.0;

//
// INIT
//

//
// METHODS
//

