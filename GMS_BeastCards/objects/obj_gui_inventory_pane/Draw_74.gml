//===============================================================================//
//
// DRAW GUI: OBJ_GUI_INVENTORY_PANE
// FUNCTION: Draws the inventory pane.
//           Refreshes cached inventory after sort, filter, or item changes.
//           Handles inventory controls and prevents input click-through.
//           Draws inventory slots, pagination, controls, and item preview.
//
//===============================================================================//

//================//
//DRAW PANE//
//================//
draw_sprite(spr_gui_inventory_pane,0,x,y);
draw_set_font(fnt_gui_small);

//================//
//STATE RESET//
//================//
_stct_preview_item = undefined;

//================//
//INPUT LOCKOUT//
//================//
hscr_gui_inventory_update_input_lockout();

//================//
//LAYOUT//
//================//
hscr_gui_inventory_update_layout();

//==================//
//SORT/FILTER INPUT//
//==================//
hscr_gui_inventory_handle_sort_filter_input();

//================//
//CACHE REFRESH//
//================//
hscr_gui_inventory_refresh_cache();

//================//
//DRAW INVENTORY//
//================//
hscr_gui_inventory_draw_slots(_list_filtered_inventory);
hscr_gui_inventory_draw_page_text(_ct_inventory_total_pages);
hscr_gui_inventory_draw_sort_filter_buttons();

//================//
//ITEM PREVIEW//
//================//
if (hscr_gui_inventory_can_accept_input()){
	hscr_gui_inventory_draw_preview_modal();
}

//================//
//CLICK COOLDOWN//
//================//
hscr_gui_inventory_update_click_cooldown();