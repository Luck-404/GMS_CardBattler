//===============================================================================//
//
// CREATE: OBJ_GUI_POPUP
// FUNCTION: Initializes standard popup state.
//
//           RANDOM uses the original supplied popup position.
//
//           CLEAN retains standard popup behavior but organizes simultaneous
//           entries into a list above their associated anchor.
//
//           Standard popups never become scrolling popups.
//
//===============================================================================//

#region VARIABLES

//================//
//POPUP DATA//
//================//
_str_type = "DEFAULT";
_str_text = "DEFAULT";

_spr_icon = undefined;

_c_popup = c_white;

_ct_life = 60;

//================//
//PRINTOUT//
//================//
_flag_printout = false;

_flag_clean_printout = false;
_flag_printout_stacking = false;

_ref_printout_anchor = undefined;

_val_printout_anchor_x = x;
_val_printout_anchor_y = y;

_str_printout_group_key = "";
_str_printout_event_key = "";

_ct_printout_stack = 1;
_ct_printout_life_max = 60;

_val_printout_order = 0;

//================//
//CLEAN POSITION//
//================//
_val_printout_push_offset = 0;

_val_printout_spacing = 26;
_val_printout_head_offset = 48;

#endregion

#region INIT

#endregion

#region METHODS

#endregion