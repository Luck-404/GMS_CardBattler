//
//
// DRAW GUI: OBJ_COLLECTION_GUI_PANE | DISPLAY THE PLAYER'S DECK AND COLLECTION, ALLOW FOR ADDING TO AND FROM BOTH AND DELETING CARDS
//
//

//DRAW SELF
draw_self();

//SETUP AND COUNT TRACKERS
_preview_card = undefined;
_deck_count = ds_list_size(global.player_deck);
_collection_count = ds_list_size(global.player_card_collection);

//
// HEADER
//
#region HEADER
draw_set_font(fnt_gui_medium);
draw_set_colour(c_white);

draw_text(_pane_left + 135, _pane_top - 25, "DECK");
draw_text(_pane_left + 575, _pane_top - 25, "COLLECTION");

draw_set_font(fnt_gui_small);
#endregion

//
// DECK
//
#region DRAW DECK
for (var _i = 0; _i < _deck_visible; _i++){
    var _card = ds_list_find_value(global.player_deck, _i);

	//
	// DRAW SLOT
	//
	#region DRAW SLOT
    var _box_x = _deck_x;
    var _box_y = _start_y + (_i * (_slot_h + _slot_margin));

    draw_set_colour(c_black);
    draw_rectangle(_box_x,_box_y,_box_x + _slot_w,_box_y + _slot_h,false);

    draw_set_colour(c_gray);
    draw_rectangle(_box_x+2,_box_y+2,_box_x+_slot_w-2,_box_y+_slot_h-2,false);
	#endregion
	
	//
	// DRAW CARD INFO
	//
	#region CARD
    if (_card != undefined){
		
		//
		// INFO
		//
		#region INFO
        draw_sprite_ext(_card[?"card_sprite"],0,_box_x + 10,_box_y + 11,_card_icon_scale,_card_icon_scale,0,c_white,1);

		draw_set_colour(c_black);

		var _colors = _card[?"card_colors"];

		var _color_text = "";

		//GET COLORS FROM STORED CARD COLORS
		if (is_array(_colors)){
		    var _color1 = _colors[0];

		    if (array_length(_colors) > 1 && _colors[1] != undefined){
		        var _color2 = _colors[1];
		        _color_text = string(_color1) + " / " + string(_color2);
		    } else {
		        _color_text = string(_color1);
		    }
		} else {
		    _color_text = string(_colors);
		}

		//DRAW CARD NAME, COLOR, AND MANA COST
		var _display_text = _card[?"card_name"] + " - " + _color_text + " - " + string(_card[?"card_mana_cost"]);

		draw_text(_box_x + 24,_box_y + 3,_display_text);
		#endregion

		//
		// HOVER LOGIC AND CLICKING
		//
		#region HOVER AND CLICK
        if (mouse_x > _box_x && mouse_x < _box_x + _slot_w && mouse_y > _box_y && mouse_y < _box_y + _slot_h){
			//DRAW HIGHLIGHT
            draw_sprite(spr_collection_gui_highlight, 0, _box_x + 185, _box_y + 11);

			//CTRL PREVIEW
            if (keyboard_check(vk_lcontrol))
                _preview_card = _card;

			//CLICKING ATTEMPTS TO SEND TO COLLECTION
            if (mouse_check_button_pressed(mb_left) && !_flag_clicked && _deck_count > 1) {
                _flag_clicked = true;
                _cooldown = 10;

                ds_list_add(global.player_card_collection,_card);
                ds_list_delete(global.player_deck,_i);
            }
        }
		#endregion
    }
	#endregion
}
#endregion

//
// COLLECTION
//
#region DRAW COLLECTION
var _start_index = _collection_page * _collection_per_page;

for (var _i = 0; _i < _collection_per_page; _i++){
    var _collection_index = _start_index + _i;
    var _card = ds_list_find_value(global.player_card_collection,_collection_index);

	//
	// DRAW SLOT
	//
	#region SLOT
    var _box_x = _collection_x;
    var _box_y = _start_y + (_i * (_slot_h + _slot_margin));

    draw_set_colour(c_black);
    draw_rectangle(_box_x,_box_y,_box_x + _slot_w,_box_y + _slot_h,false);

    draw_set_colour(c_gray);
    draw_rectangle(_box_x+2,_box_y+2,_box_x+_slot_w-2,_box_y+_slot_h-2,false);
	#endregion
	
	//
	// CARD
	//
	#region CARD
    if (_card != undefined){
		//DRAW SPRITE
        draw_sprite_ext(_card[?"card_sprite"],0,_box_x + 10,_box_y + 11,_card_icon_scale,_card_icon_scale,0,c_white,1);

		//
		// CARD INFO
		//
		#region INFO
		draw_set_colour(c_black);

		var _colors = _card[?"card_colors"];

		var _color_text = "";

		//GET COLORS STORED
		if (is_array(_colors)){
		    var _color1 = _colors[0];

		    if (array_length(_colors) > 1 && _colors[1] != undefined){
		        var _color2 = _colors[1];
		        _color_text = string(_color1) + " / " + string(_color2);
		    } else {
		        _color_text = string(_color1);
		    }
		} else {
		    _color_text = string(_colors);
		}

		//DRAW NAME, COLOR, MANA COST
		var _display_text = _card[?"card_name"] + " - " + _color_text + " - " + string(_card[?"card_mana_cost"]);

		draw_text(_box_x + 24,_box_y + 3,_display_text);
		#endregion
		
		//
		// HOVER AND CLICK
		//
		#region HOVER AND CLICK
        if (mouse_x > _box_x && mouse_x < _box_x + _slot_w && mouse_y > _box_y && mouse_y < _box_y + _slot_h){
            //HIGHLGIHT
			draw_sprite(spr_collection_gui_highlight,0,_box_x + 185,_box_y + 11);

			//QUEUE PREVIEW
            if (keyboard_check(vk_lcontrol))
                _preview_card = _card;

			//LEFT CLICK TRIES TO SEND TO DECK IF THERE IS SPACE
            if (mouse_check_button_pressed(mb_left) && !_flag_clicked && _deck_count < _deck_max){
				//COOLDOWN
                _flag_clicked = true;
                _cooldown = 10;

				//ADD TO DECK
                ds_list_add(global.player_deck,_card);
                ds_list_delete(global.player_card_collection,_collection_index);
            }

            if (keyboard_check_pressed(vk_delete)&& !_flag_clicked){
				//COOLDOWN
                _flag_clicked = true;
                _cooldown = 10;

				//DELETE CARD
                ds_list_delete(global.player_card_collection,_collection_index);
            }
        }
		#endregion
    }
	#endregion
}
#endregion

//
// AVG DECK COST
//
#region AVERAGE DECK COST
var _total_cost = 0;

//CALCULATE
for (var _i = 0; _i < _deck_count; _i++){
    var _card = ds_list_find_value(global.player_deck,_i);

    if (_card != undefined)
        _total_cost += _card[?"card_mana_cost"];
}

var _avg = 0;

if (_deck_count > 0)
    _avg = _total_cost / _deck_count;

//PRINT
draw_set_colour(c_black);
draw_text(_deck_x,_pane_top + _pane_h - 30,"AVG COST: " + string_format(_avg,1,2));
#endregion

//
// PAGE DISPLAY
//
#region PAGE DISPLAY
var _total_pages = max(1, ceil(_collection_count / _collection_per_page));

draw_set_halign(fa_center);
draw_set_colour(c_black);
draw_text(_page_center_x,_page_y,"PAGE " + string(_collection_page + 1)+ "/" + string(_total_pages));

draw_set_halign(fa_left);
#endregion

//
// CLICK COOLDOWN
//
#region CLICK COOLDOWN
if (_flag_clicked){
    if (_cooldown > 0)
        _cooldown--;
    else {
        _cooldown = 0;
        _flag_clicked = false;
    }
}
#endregion

//
// PREVIEW CARD W CTRL
//
#region PREVIEW CARD
if (_preview_card != undefined){
    draw_sprite_ext(_preview_card[?"card_sprite"],0,room_width * 0.5,room_height * 0.5,0.95,0.95,0,c_white,1);
}
#endregion