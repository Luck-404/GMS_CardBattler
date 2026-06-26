//===============================================================================//
//
// CREATE: OBJ_GUI_RANCH_PANE
// FUNCTION: Initializes the party/ranch management GUI pane.
//           Stores party and ranch layout, pagination, and click state.
//           Creates navigation arrows for ranch page movement.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
depth = -1;

// PARTY / RANCH COUNTS
_ct_party = ds_list_size(global.list_player_party);
_ct_ranch = ds_list_size(global.list_player_ranch);

_str_type = "RANCH";

// PANE LAYOUT
_val_pane_w = 800;
_val_pane_h = 800;
_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

// SLOT LAYOUT
_val_slot_h = 130;
_val_slot_margin = 15;
_val_slot_w = 370;

_val_party_x = _val_pane_left + 15;
_val_ranch_x = x + 15;
_val_start_y = _val_pane_top + 15;

// RANCH PAGE SETTINGS
_val_ranch_page = 0;
_ct_ranch_per_page = 5;

_val_page_y = _val_pane_top + _val_pane_h - 50;
_val_page_center_x = _val_ranch_x + (_val_slot_w * 0.5);
_val_arrow_offset = 80;

// CLICK COOLDOWN
_flag_clicked = false;
_val_cooldown = 10;

//----//
//INIT//
//----//
_ref_left_arrow = instance_create_layer(_val_page_center_x - _val_arrow_offset,_val_page_y,"ily_fx",obj_gui_ranch_left_arrow);
_ref_left_arrow._ref_gui_pane = self;

_ref_right_arrow = instance_create_layer(_val_page_center_x + _val_arrow_offset,_val_page_y,"ily_fx",obj_gui_ranch_right_arrow);
_ref_right_arrow._ref_gui_pane = self;

//-------//
//METHODS//
//-------//