//
//
// CREATE: OBJ_COLLECTION_GUI_PANE
//
//

//
// VARIABLES
//
#region VARIABLES
depth = -1;

// COUNTS
_deck_count = ds_list_size(global.player_deck);
_collection_count = ds_list_size(global.player_card_collection);

_deck_max = 30;
_type = "COLLECTION";
// PANE AND SLOT SPACING AND LAYOUT
_pane_w = 800;
_pane_h = 800;
_pane_left = x - (_pane_w * 0.5);
_pane_top  = y - (_pane_h * 0.5);
_slot_h = 22;
_slot_margin = 2;
_slot_w = 370;
_deck_x = _pane_left + 15;
_collection_x = x + 15;
_start_y = _pane_top + 20;
_deck_visible = 30;
_collection_per_page = 30;
_collection_page = 0;
_page_y = _pane_top + _pane_h - 35;
_page_center_x = _collection_x + (_slot_w * 0.5);
_arrow_offset = 80;
_preview_card = undefined;
_card_icon_scale = 0.022;

//COOLDOWN FLAGS
_flag_clicked = false;
_cooldown = 10;
#endregion

//
// INIT
//
#region INIT
_left_arrow = instance_create_layer(
    _page_center_x - _arrow_offset,
    _page_y,
    "ily_fx",
    obj_collection_gui_left_arrow
);
_left_arrow._ref_gui_pane = self;

_right_arrow = instance_create_layer(
    _page_center_x + _arrow_offset,
    _page_y,
    "ily_fx",
    obj_collection_gui_right_arrow
);
_right_arrow._ref_gui_pane = self;
#endregion

//
// METHODS
//