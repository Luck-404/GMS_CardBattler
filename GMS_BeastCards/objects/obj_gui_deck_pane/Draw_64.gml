//
//
// DRAW GUI: OBJ_GUI_DECK_PANE | DRAW DECK
//
//

// 
// SETUP
//
draw_sprite(spr_gui_deck_pane,0,x,y);
_card_count = ds_list_size(global.player_deck);
var _preview_card = undefined;
var _total_cost = 0;

//
// DRAW DECK
//
#region DRAW DECK
for (var _i = 0; _i < 30; _i++){
	#region BOX
    var _col = _i mod _cols;
    var _row = _i div _cols;

    var _box_x = _grid_start_x + (_col * (_slot_w + _spacing_x));
    var _box_y = _grid_start_y + (_row * (_slot_h + _spacing_y));

    var _center_x = _box_x + (_slot_w * 0.5);
    var _center_y = _box_y + (_slot_h * 0.5);

    draw_set_colour(c_black);
    draw_rectangle(_box_x,_box_y,_box_x + _slot_w,_box_y + _slot_h,false);

    draw_set_colour(c_dkgray);
    draw_rectangle(_box_x + 3,_box_y + 3,_box_x + _slot_w - 3,_box_y + _slot_h - 3,false);
	#endregion
	
	#region CARD
    if (_i < _card_count){
        var _card = ds_list_find_value(global.player_deck, _i);
		
        if (_card != undefined){
			_total_cost += _card[?"card_mana_cost"]; //ADD TO COST CALC
			
			//DRAW CARD
	        draw_sprite_ext(_card[?"card_sprite"],0,_center_x,_center_y,_card_scale,_card_scale,0,c_white,1);

			//HOVER HIGHLIGHT AND PREIVEW SET
	        if (device_mouse_x_to_gui(0) > _box_x && device_mouse_x_to_gui(0) < _box_x + _slot_w && device_mouse_y_to_gui(0) > _box_y && device_mouse_y_to_gui(0) < _box_y + _slot_h){
	            draw_sprite(spr_gui_deck_highlight,0,_center_x,_center_y);

	            if (keyboard_check(vk_lcontrol)){
	                _preview_card = _card;
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
if (_card_count > 0)
{
    var _avg_cost = _total_cost / _card_count;

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_colour(c_black);
	draw_set_font(fnt_medium_gui);

    draw_text(x,_pane_top + _pane_h + 24,"AVG COST: " + string_format(_avg_cost, 1, 1));
    draw_set_valign(fa_top);
}
#endregion

//
// CARD PREVIEW
//
#region CARD PREVIEW
if (_preview_card != undefined)
{
    draw_sprite_ext(_preview_card[?"card_sprite"],0,room_width * 0.5,room_height * 0.5,_preview_scale,_preview_scale,0,c_white,1);
}
#endregion