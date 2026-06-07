//
//
// CREATE: OBJ_GUI_PARTY
//
//

//VARIABLES
depth = -1;
_pos = 0;
_unit_count = ds_list_size(global.player_party);
_unit_selected = ds_list_find_value(global.player_party,_pos); //SELECT UNIT 0 BY DEFAULT
_type = "PARTY";
_pane_w = 800;
_pane_h = 800;
_pane_left = x - (_pane_w * 0.5);
_pane_top  = y - (_pane_h * 0.5);
_slot_size = 100;
_spacing   = 15;
_padding_y = 15;
_total_width =(_unit_count * _slot_size) + ((_unit_count - 1) * _spacing);
_row_start_x = x - (_total_width * 0.5);
_row_y = _pane_top + _padding_y;
_arrow_offset = 60;

_flag_clicked = false;
_cooldown = 10;

//INIT
_left_arrow = instance_create_layer(_row_start_x - _arrow_offset,_row_y + (_slot_size * 0.5),"ily_fx",obj_gui_party_left_arrow);
_left_arrow._ref_gui_pane = self;

_right_arrow = instance_create_layer(_row_start_x + _total_width + _arrow_offset,_row_y + (_slot_size * 0.5),"ily_fx",obj_gui_party_right_arrow);
_right_arrow._ref_gui_pane = self;

//METHODS