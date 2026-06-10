//
//
// CREATE: OBJ_GUI_END_BATTLE_PANE
//
//

//
//VARIABLES
//
_confirm_button = instance_create_layer(room_width/2,room_height/2+450,"ily_fx",obj_gui_end_battle_confirm_button);
_condition = "";
_flag_finished = false;

_pane_w = 800;
_pane_h = 800;
_pane_left = x - (_pane_w * 0.5);
_pane_top  = y - (_pane_h * 0.5);
_slot_size = 100;
_spacing   = 15;
_padding_y = 15;
_unit_count = ds_list_size(obj_battle_player_controller._beasts_list);
_total_width =(_unit_count * _slot_size) + ((_unit_count - 1) * _spacing);
_row_start_x = x - (_total_width * 0.5);
_row_y = _pane_top + 500;
_rewards_list = [];

//
//INIT
//

//
//METHODS
//