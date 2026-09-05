//===============================================================================//
//
// CREATE: OBJ_GUI_BATTLE_TUTOR
// FUNCTION: Initializes the battle Tutor selection pane.
//           Stores Tutor candidates and list-layout settings.
//           Defines initialization and refresh methods.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//

depth = -10000;

_arr_tutor_cards = [];

// PANE
_val_pane_w = 620;
_val_pane_h = 560;

_val_pane_left =
	x - (_val_pane_w * 0.5);

_val_pane_top =
	y - (_val_pane_h * 0.5);

// LIST
_ct_rows_per_column = 15;
_ct_columns = 2;

_val_slot_w = 270;
_val_slot_h = 24;

_val_slot_gap_x = 20;
_val_slot_gap_y = 6;

_val_list_x =
	_val_pane_left + 30;

_val_list_y =
	_val_pane_top + 80;

// INPUT
_flag_clicked = false;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//

//—------------------------------------------------------------------------------//
// hscr_tutor_init
// FUNCTION: Assigns the currently selectable battle-card instances.
//—------------------------------------------------------------------------------//

hscr_tutor_init = function(_arr_candidates){

	_arr_tutor_cards =
		_arr_candidates;
};