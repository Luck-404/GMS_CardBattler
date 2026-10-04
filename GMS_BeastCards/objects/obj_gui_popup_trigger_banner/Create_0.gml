//===============================================================================//
//
// CREATE: OBJ_GUI_POPUP_TRIGGER_BANNER
// FUNCTION: Initializes the dynamic GUI trigger banner.
//           Stores trigger text, owner text, stack state, layout, and lifespan.
//
//===============================================================================//

#region VARIABLES

//------//
//TEXT//
//------//
_str_text = "DEFAULT";
_str_owner = "";

_font_banner = fnt_gui_party_small;
_font_owner = fnt_gui_party_small;

//--------//
//LAYOUT//
//--------//
_val_anchor_y = 740;

_val_border = 3;

_val_padding_x = 12;
_val_padding_y = 8;

_val_owner_gap = 4;

//----------------//
//VERTICAL STACKING//
//----------------//
_val_stack_order = -1;
_val_stack_index = 0;

_val_stack_spacing = 5;
_val_stack_step = 58;

//----------//
//LIFESPAN//
//----------//
_ct_life = 120;

#endregion

#region INIT

//----------------//
//DISABLE SPRITE//
//----------------//
sprite_index = -1;

#endregion