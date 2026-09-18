//===============================================================================//
//
// CREATE: OBJ_GUI_BATTLE_TUTOR
// FUNCTION: Initializes the battle Tutor selection pane.
//           Supports configurable Card Types and Tutor titles.
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

_str_tutor_card_type = "UTILITY";
_str_tutor_title = "ANCIENT CHARTS";

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
#region INIT
#endregion

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_gui_init_tutor
// FUNCTION: Assigns the eligible Card instances and Tutor configuration.
//—------------------------------------------------------------------------------//
hscr_gui_init_tutor = function(_arr_candidates,_str_primary_card_type="UTILITY",_str_title="ANCIENT CHARTS"){

	_arr_tutor_cards = _arr_candidates;

	_str_tutor_card_type = _str_primary_card_type;
	_str_tutor_title = _str_title;
};

#endregion