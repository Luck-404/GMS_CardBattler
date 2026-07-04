//===============================================================================//
//
// CREATE: OBJ_GUI_SCROLLING_TEXTBOX
// FUNCTION: Initializes a scrolling GUI textbox.
//           Reveals text over time.
//           Returns control to the parent inventory pane when closed.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
depth = -101;

_str_type = "SCROLLING_TEXTBOX";

_ref_parent_gui = undefined;

_str_text = "";
_str_visible_text = "";

_ct_char = 0;
_ct_text_speed = 1;

_ct_input_delay = 8;

_val_box_w = 640;
_val_box_h = 160;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//