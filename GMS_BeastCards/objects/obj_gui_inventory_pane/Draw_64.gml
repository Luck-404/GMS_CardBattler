//===============================================================================//
//
// DRAW GUI: OBJ_GUI_INVENTORY_PANE
// FUNCTION: Draws the inventory pane.
//           Refreshes cached inventory only after sort, filter, or item changes.
//           Opens item-use prompts for valid item types.
//           Prevents click-through after prompts, textboxes, and target panes close.
//           Draws cached inventory slots, page text, controls, and item preview.
//
//===============================================================================//

//----//
//DRAW//
//----//
draw_sprite(spr_gui_inventory_pane,0,x,y);
draw_set_font(fnt_small_gui);

//-----------//
//STATE RESET//
//-----------//
_stct_preview_item = undefined;

//--------------//
//INPUT LOCKOUT//
//--------------//
hscr_update_input_lockout();

//------//
//LAYOUT//
//------//
hscr_update_layout();

//------------------//
//SORT/FILTER INPUT//
//------------------//
if (hscr_can_accept_input()){
	hscr_handle_sort_filter_input();
}

//-------------//
//CACHE REFRESH//
//-------------//
hscr_refresh_inventory_cache();

//----//
//DRAW//
//----//
hscr_draw_inventory_slots(_list_filtered_inventory);
hscr_draw_page_text(_ct_inventory_total_pages);
hscr_draw_sort_filter_buttons();

if (hscr_can_accept_input()){
	hscr_draw_preview_modal();
}

//---------//
//COOLDOWN//
//---------//
hscr_update_click_cooldown();