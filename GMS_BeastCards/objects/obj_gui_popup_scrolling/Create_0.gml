//===============================================================================//
//
// CREATE: OBJ_POPUP_SCROLLING
// FUNCTION: Initializes scrolling popup state.
//           Stores popup type, text, icon sprite, color, and lifespan.
//           Moves upward while displaying temporary popup feedback.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
_str_type = "DEFAULT";
_str_text = "DEFAULT";

_spr_icon = undefined;

_c_popup = c_white;

_ct_life = 60;

_val_y_speed = 2;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//