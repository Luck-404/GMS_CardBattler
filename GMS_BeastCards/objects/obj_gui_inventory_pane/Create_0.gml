//===============================================================================//
//
// CREATE: OBJ_GUI_INVENTORY_PANE
// FUNCTION: Inventory UI container. Handles paging,
//           sorting/filter state, arrow setup,
//           layout constants, and interaction flags.
//
//===============================================================================//

//----------------//
// CORE SETTINGS
//----------------//
depth = -1;

_type = "INVENTORY";

//----------------//
// PANE LAYOUT
//----------------//
_pane_w = 800;
_pane_h = 800;

_pane_left = x - (_pane_w * 0.5);
_pane_top  = y - (_pane_h * 0.5);

//----------------//
// SLOT LAYOUT
//----------------//
_slot_h = 60;
_slot_spacing = 3;
_slot_margin = 0;
_slot_w = 770;

_inventory_x = _pane_left + 15;
_start_y = _pane_top + 20;

//----------------//
// PAGING
//----------------//
_inventory_per_page = 10;   // single column (IMPORTANT)
_inventory_page = 0;

_page_y = _pane_top + _pane_h - 35;
_page_center_x = _pane_left + (_pane_w * 0.5);
_arrow_offset = 80;

//----------------//
// PREVIEW
//----------------//
_preview_item = undefined;
_preview_scale = 4;

//----------------//
// SORT / FILTER
//----------------//
_sort_mode = "RECENT"; // RECENT, ALPHABETICAL, TYPE
_filter_mode = "ALL";  // ALL, QUEST, CONSUMABLE, PRISM, HELD, EGG

//----------------//
// INPUT LOCK
//----------------//
_flag_clicked = false;
_cooldown = 10;
_flag_prompt_active = false;

//----------------//
// ARROWS
//----------------//
_left_arrow = instance_create_layer(
    _page_center_x - _arrow_offset,
    _page_y,
    "ily_fx",
    obj_gui_inventory_left_arrow
);
_left_arrow._ref_gui_pane = self;

_right_arrow = instance_create_layer(
    _page_center_x + _arrow_offset,
    _page_y,
    "ily_fx",
    obj_gui_inventory_right_arrow
);
_right_arrow._ref_gui_pane = self;