//===============================================================================//
//
// CREATE: OBJ_GUI_DECK_PANE
// FUNCTION: Initializes the deck GUI pane.
// Stores deck display layout, grid spacing, and card preview values.
// Displays the current player deck using card structs.
//
//===============================================================================//

//
// VARIABLES
//
#region VARIABLES
depth = -1;

// DECK REFERENCE
_ct_card = ds_list_size(global.player_deck);
_str_type = "DECK";

// PANE SIZING
_val_pane_w = 800;
_val_pane_h = 800;
_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

// GRID LAYOUT
_ct_cols = 6;
_ct_rows = 5;

_val_slot_w = 104;
_val_slot_h = 145;

_val_spacing_x = 10;
_val_spacing_y = 10;

_val_grid_w = (_ct_cols * _val_slot_w) + ((_ct_cols - 1) * _val_spacing_x);
_val_grid_h = (_ct_rows * _val_slot_h) + ((_ct_rows - 1) * _val_spacing_y);

_val_grid_start_x = x - (_val_grid_w * 0.5);
_val_grid_start_y = y - (_val_grid_h * 0.5);

// CARD DISPLAY
_val_card_scale = 0.23;
_val_preview_scale = 1.0;
#endregion

//
// INIT
//
#region INIT
#endregion

//
// METHODS
//
#region METHODS
#endregion