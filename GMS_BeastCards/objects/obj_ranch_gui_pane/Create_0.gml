//
//
// CREATE: OBJ_GUI_PARTY_RANCH_PANE
//
//

//
//VARIABLES
//
depth = -1;

//PARTY AND RANCH COUNTS
_party_count = ds_list_size(global.player_party);
_ranch_count = ds_list_size(global.player_ranch);
_type = "RANCH";
//SIZING OF PANE AND PIECES
_pane_w = 800;
_pane_h = 800;
_pane_left = x - (_pane_w * 0.5);
_pane_top  = y - (_pane_h * 0.5);
_slot_h = 130;
_slot_margin = 15;
_slot_w = 370;
_party_x = _pane_left + 15;
_ranch_x = x + 15;
_start_y = _pane_top + 15;

_ranch_page = 0;
_ranch_per_page = 5;

_page_y = _pane_top + _pane_h - 50;
_page_center_x = _ranch_x + (_slot_w * 0.5);
_arrow_offset = 80;

//COOLDOWN VARIABLES
_flag_clicked = false;
_cooldown = 10;

//
//INIT
//

//ARROWS FOR NAVIGATING PAGES OF RANCH UNITS
_left_arrow = instance_create_layer(_page_center_x - _arrow_offset,_page_y,"ily_fx",obj_ranch_gui_left_arrow);
_left_arrow._ref_gui_pane = self;

_right_arrow = instance_create_layer(_page_center_x + _arrow_offset,_page_y,"ily_fx",obj_ranch_gui_right_arrow);
_right_arrow._ref_gui_pane = self;

//
//METHODS
//