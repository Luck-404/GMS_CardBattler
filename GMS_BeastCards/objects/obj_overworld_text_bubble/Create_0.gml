//===============================================================================//
//
// CREATE: OBJ_OVERWORLD_TEXT_BUBBLE
// FUNCTION: Initializes temporary overworld text-bubble state.
//           The bubble stores a world-space anchor but renders in Draw GUI so
//           nearby decor cannot cover it.
//
//===============================================================================//

//================//
//VARIABLES//
//================//
_str_text = "DEFAULT";

_ct_life = 60;

//================//
//TOOLTIP LAYOUT//
//================//
_val_padding_x = 12;
_val_padding_y = 8;

_val_max_text_w = 360;
_val_line_sep = 20;

//================//
//INIT//
//================//
// Above normal world/decor presentation, but below dedicated GUI panes such as
// Market/NPC panes.
depth = -8000;

//================//
//METHODS//
//================//
