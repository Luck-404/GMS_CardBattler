//===============================================================================//
//
// CREATE: OBJ_GUI_BATTLE_START_PANE
// FUNCTION: Initializes the pre-battle confirmation pane.
//           Displays both teams, Speed information, opening initiative,
//           and the Start Battle confirmation button.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//

#region REFERENCES

_ref_turn_controller = undefined;

_ref_player_controller = undefined;
_ref_enemy_controller = undefined;

#endregion

#region INITIATIVE

_val_player_avg_speed = 0;
_val_enemy_avg_speed = 0;

_str_first_team = "";

#endregion

#region LAYOUT

_val_pane_w = 900;
_val_pane_h = 610;

_val_button_w = 300;
_val_button_h = 54;

_val_row_h = 52;
_val_row_spacing = 6;

#endregion

#region INPUT

_ct_input_delay = 8;

#endregion

//----//
//INIT//
//----//

depth = -15001;