//===============================================================================//
//
// CREATE: OBJ_GUI_INVENTORY_RIGHT_ARROW
// FUNCTION: Initializes the inventory page right arrow.
//           Stores a reference to its owning inventory pane.
//           Handles click cooldown state.
//
//===============================================================================//

//================//
//VARIABLES//
//================//
_ref_gui_pane = undefined;

_ct_cooldown = 0;

_flag_clicked = false;

//================//
//INIT//
//================//
depth = -2;

//================//
//METHODS//
//================//