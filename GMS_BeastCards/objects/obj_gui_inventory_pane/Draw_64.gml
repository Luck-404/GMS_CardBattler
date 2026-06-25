//===============================================================================//
//
// DRAW GUI: OBJ_GUI_INVENTORY_PANE
// FUNCTION: Draws the inventory pane.
//           Runs filter, sort, pagination, slot drawing, and preview display.
//           Destroys temporary filtered inventory list after drawing.
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

//--------//
//PIPELINE//
//--------//
var _list_filtered = hscr_build_filtered_inventory();

hscr_sort_inventory(_list_filtered);

var _ct_filtered = ds_list_size(_list_filtered);
var _ct_total_pages = max(1,ceil(_ct_filtered / _ct_inventory_per_page));

_ct_inventory_page = clamp(_ct_inventory_page,0,_ct_total_pages - 1);

hscr_update_layout();

hscr_draw_inventory_slots(_list_filtered);
hscr_draw_page_text(_ct_total_pages);
hscr_draw_sort_filter_buttons();
hscr_draw_preview_modal();

ds_list_destroy(_list_filtered);