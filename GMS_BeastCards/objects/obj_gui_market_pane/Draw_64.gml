//===============================================================================//
//
// DRAW GUI: OBJ_GUI_MARKET_PANE
// FUNCTION: Draws the beast egg market GUI.
//           Displays three persistent egg offers.
//           Allows left-click purchase and right-click close.
//
//===============================================================================//

//---------//
//COOLDOWN//
//---------//
hscr_update_click_cooldown();

//------------//
//RIGHT CLOSE//
//------------//
if (mouse_check_button_pressed(mb_right)){
	obj_gui_controller.hscr_destroy_gui_open();
	obj_gui_controller.hscr_toggle_gui_pause(false);
	global.ref_active_gui = undefined;
	instance_destroy();
	exit;
}

//----//
//DRAW//
//----//
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_sprite(spr_gui_market_pane,0,x,y);

//--------//
//HEADER//
//--------//
draw_set_font(fnt_medium_gui);
draw_set_colour(c_white);
draw_set_halign(fa_center);

draw_text(x,_val_pane_top + 28,_str_header_text);

draw_set_font(fnt_small_gui);
draw_text(x,_val_pane_top + 58,"Gold: " + string(global.val_player_gold) + " gp | Right click to close");

//--------//
//OFFERS//
//--------//
var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

for (var _it_offer = 0; _it_offer < _ct_offers; _it_offer++){

	var _val_col = _it_offer mod _ct_cols;
	var _val_row = _it_offer div _ct_cols;

	var _ct_row_offers = min(_ct_cols,_ct_offers - (_val_row * _ct_cols));
	var _val_row_total_w = (_ct_row_offers * _val_panel_w) + ((_ct_row_offers - 1) * _val_panel_gap);
	var _val_row_start_x = x - (_val_row_total_w * 0.5);

	var _val_panel_x = _val_row_start_x + (_val_col * (_val_panel_w + _val_panel_gap));
	var _val_panel_y_current = _val_panel_y + (_val_row * (_val_panel_h + _val_panel_row_gap));

	hscr_draw_offer_panel(
		_it_offer,
		_val_panel_x,
		_val_panel_y_current,
		_val_mouse_x,
		_val_mouse_y
	);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);