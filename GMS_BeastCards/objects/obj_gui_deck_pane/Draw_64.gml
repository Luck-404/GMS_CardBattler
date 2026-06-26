//===============================================================================//
//
// DRAW GUI: OBJ_GUI_DECK_PANE
// FUNCTION: Draws the current player deck in a 6 by 5 grid.
// Calculates and displays the average deck mana cost.
// Allows ctrl-hover card preview using card structs.
//
//===============================================================================//

//
// SETUP
//
#region SETUP
draw_sprite(spr_gui_deck_pane,0,x,y);

_ct_card = ds_list_size(global.list_player_deck);

var _stct_preview_card = undefined;
var _val_total_cost = 0;

var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);
#endregion

//
// DRAW DECK
//
#region DRAW DECK
for (var _it_card = 0; _it_card < 30; _it_card++){
	#region BOX
	var _ct_col = _it_card mod _ct_cols;
	var _ct_row = _it_card div _ct_cols;

	var _val_box_x = _val_grid_start_x + (_ct_col * (_val_slot_w + _val_spacing_x));
	var _val_box_y = _val_grid_start_y + (_ct_row * (_val_slot_h + _val_spacing_y));

	var _val_center_x = _val_box_x + (_val_slot_w * 0.5);
	var _val_center_y = _val_box_y + (_val_slot_h * 0.5);

	draw_set_colour(c_black);
	draw_rectangle(_val_box_x,_val_box_y,_val_box_x + _val_slot_w,_val_box_y + _val_slot_h,false);

	draw_set_colour(c_dkgray);
	draw_rectangle(_val_box_x + 3,_val_box_y + 3,_val_box_x + _val_slot_w - 3,_val_box_y + _val_slot_h - 3,false);
	#endregion
	
	#region CARD
	if (_it_card < _ct_card){
		var _stct_card = ds_list_find_value(global.list_player_deck,_it_card);
		
		if (_stct_card != undefined){
			_val_total_cost += _stct_card._val_card_mana_cost;
			
			draw_sprite_ext(_stct_card._spr_card,0,_val_center_x,_val_center_y,_val_card_scale,_val_card_scale,0,c_white,1);

			if (_val_mouse_x > _val_box_x && _val_mouse_x < _val_box_x + _val_slot_w && _val_mouse_y > _val_box_y && _val_mouse_y < _val_box_y + _val_slot_h){
				draw_sprite(spr_gui_deck_highlight,0,_val_center_x,_val_center_y);

				if (keyboard_check(vk_lcontrol)){
					_stct_preview_card = _stct_card;
				}
			}
		}
	}
	#endregion
}
#endregion

//
// AVERAGE DECK COST
//
#region DECK COST
if (_ct_card > 0){
	var _val_avg_cost = _val_total_cost / _ct_card;

	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_colour(c_black);
	draw_set_font(fnt_medium_gui);

	draw_text(x,_val_pane_top + _val_pane_h + 24,"AVG COST: " + string_format(_val_avg_cost,1,1));
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}
#endregion

//
// CARD PREVIEW
//
#region CARD PREVIEW
if (_stct_preview_card != undefined){
	draw_sprite_ext(_stct_preview_card._spr_card,0,room_width * 0.5,room_height * 0.5,_val_preview_scale,_val_preview_scale,0,c_white,1);
}
#endregion