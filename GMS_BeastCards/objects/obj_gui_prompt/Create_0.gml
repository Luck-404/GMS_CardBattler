//===============================================================================//
//
// CREATE: OBJ_GUI_PROMPT
// FUNCTION: Initializes a reusable yes/no GUI prompt.
//           Stores prompt text, parent GUI reference, selected item, and callbacks.
//           Used by inventory item-use confirmation.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
depth = -100;

_str_type = "PROMPT";

_ref_parent_gui = undefined;
_stct_item = undefined;

_str_prompt_text = "USE ITEM?";
_str_yes_text = "YES";
_str_no_text = "NO";

_scr_yes = undefined;
_scr_no = undefined;

_val_box_w = 360;
_val_box_h = 180;

_val_button_w = 100;
_val_button_h = 36;

_flag_clicked = false;
_ct_cooldown = 8;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//