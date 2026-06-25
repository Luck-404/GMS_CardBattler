//===============================================================================//
//
// CREATE: OBJ_GUI_INVENTORY_RIGHT_ARROW
// FUNCTION: Initializes the inventory page right arrow.
//           Stores a reference to the inventory pane.
//           Handles click cooldown state.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
depth = -2;

_ref_gui_pane = obj_gui_inventory_pane;

_ct_cooldown = 0;

_flag_clicked = false;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//