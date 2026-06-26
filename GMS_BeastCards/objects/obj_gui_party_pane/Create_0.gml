//===============================================================================//
//
// CREATE: OBJ_GUI_PARTY_PANE
// FUNCTION: Initializes the party GUI pane.
//           Stores party selection, layout, and navigation arrow references.
//           Displays beast structs from the player party.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
depth = -1;

_val_pos = 0;

_ct_unit = ds_list_size(global.list_player_party);
_stct_unit_selected = ds_list_find_value(global.list_player_party,_val_pos);

_str_type = "PARTY";

_val_pane_w = 800;
_val_pane_h = 800;
_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

_val_slot_size = 100;
_val_spacing = 15;
_val_padding_y = 15;

_val_total_width = (_ct_unit * _val_slot_size) + ((_ct_unit - 1) * _val_spacing);
_val_row_start_x = x - (_val_total_width * 0.5);
_val_row_y = _val_pane_top + _val_padding_y;

_val_arrow_offset = 60;

_flag_clicked = false;
_val_cooldown = 10;

//----//
//INIT//
//----//
_ref_left_arrow = instance_create_layer(_val_row_start_x - _val_arrow_offset,_val_row_y + (_val_slot_size * 0.5),"ily_fx",obj_gui_party_left_arrow);
_ref_left_arrow._ref_gui_pane = self;

_ref_right_arrow = instance_create_layer(_val_row_start_x + _val_total_width + _val_arrow_offset,_val_row_y + (_val_slot_size * 0.5),"ily_fx",obj_gui_party_right_arrow);
_ref_right_arrow._ref_gui_pane = self;

//-------//
//METHODS//
//-------//