//===============================================================================//
//
// CREATE: OBJ_GUI_END_BATTLE_PANE
// FUNCTION: Initializes the end battle pane.
//           Stores battle result state, reward display data, and party layout.
//           Creates the confirm button used to leave the battle result screen.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//

// BUTTON
_ref_confirm_button = instance_create_layer(room_width * 0.5,room_height * 0.5 + 450,"ily_fx",obj_gui_end_battle_confirm_button);

// RESULT STATE
_str_condition = "";
_flag_finished = false;

// PANE LAYOUT
_val_pane_w = 800;
_val_pane_h = 800;
_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

// PARTY DISPLAY
_val_slot_size = 100;
_val_spacing = 15;
_val_padding_y = 15;

_ct_unit = ds_list_size(obj_battle_player_controller._list_beasts);

_val_total_width = (_ct_unit * _val_slot_size) + ((_ct_unit - 1) * _val_spacing);
_val_row_start_x = x - (_val_total_width * 0.5);
_val_row_y = _val_pane_top + 500;

// REWARDS
_arr_rewards = [];

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//