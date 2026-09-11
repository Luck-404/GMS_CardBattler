//===============================================================================//
//
// CREATE: OBJ_GUI_BATTLE_TUTOR
// FUNCTION: Initializes the battle Tutor selection pane.
//           Stores Tutor candidate Cards, pane/list layout, and input state.
//           Defines the object-local Tutor initialization helper.
//
// USES:     Candidate battle-Card instances supplied after creation by the
//           player battle controller.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
#region VARIABLES

//-------//
//DISPLAY//
//-------//
depth = -10000;

//-------------//
//TUTOR CARDS//
//-------------//
_arr_tutor_cards = [];

//------//
//PANE//
//------//
_val_pane_w = 620;
_val_pane_h = 560;

_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

//------//
//LIST//
//------//
_ct_rows_per_column = 15;

_val_slot_w = 270;
_val_slot_h = 24;

_val_slot_gap_x = 20;
_val_slot_gap_y = 6;

_val_list_x = _val_pane_left + 30;
_val_list_y = _val_pane_top + 80;

//------//
//INPUT//
//------//
_flag_clicked = false;

#endregion

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_gui_init_tutor
// FUNCTION: Assigns the battle-Card instances currently available for selection.
// INPUT:    _arr_candidates - Candidate Card-instance array supplied by battle.
//—------------------------------------------------------------------------------//
hscr_gui_init_tutor = function(_arr_candidates){

	_arr_tutor_cards = _arr_candidates;
};

#endregion