//////////////////////////////////////////////////////////////////////
//					OBJ_MERC_SHOP DRAW GUI							//
//																	//
// > WHEN A PLAYER PRESSES 'E', SHOW THE DISPLAY. HANDLE LEFT CLICK //
//   LOGIC WHEN INTERACTING WITH THE SHOP.							//
//////////////////////////////////////////////////////////////////////
if (keyboard_check_pressed(ord("E")) && place_meeting(x,y,obj_player)) {
	show_debug_message("--- MERC_SHOP: ACTIVATED ---");		
    global.merc_shop_gui_open = !global.merc_shop_gui_open;
    obj_player._move_speed = global.merc_shop_gui_open ? 0 : 4;
}

if (global.merc_shop_gui_open) {
    if (keyboard_check_pressed(vk_escape)) {
		show_debug_message("--- MERC_SHOP: CLOSED ---");			
        global.merc_shop_gui_open = false;
        obj_player._move_speed = 4;
    }

    // Background
    draw_set_color(c_silver);
    draw_rectangle_color(50, 50, 900, 900, c_silver, c_silver, c_silver, c_silver, false);

    // Draw MERCS
    var _margin = 100;
    var _card_width = 128;
    var _card_height = 128;
    var _spacing = 30;

    for (var _i = 0; _i < ds_list_size(global.mercenary_shop_stock); _i++) {
        var _ref_merc = ds_list_find_value(global.mercenary_shop_stock, _i);
        var _sprite = _ref_merc[?"sprite"];
        var _cost = _ref_merc[?"goldcost"]; // GOLD COST
        var _x_pos = _margin + _i * (_card_width + _spacing);
        var _y_pos = 150;

        // Check for mouse hover
        var _hover = display_mouse_get_x() > _x_pos && display_mouse_get_x() < _x_pos + _card_width &&
                     display_mouse_get_y() > _y_pos && display_mouse_get_y() < _y_pos + _card_height;

        // Highlight selected card
        if (_hover) {
            draw_set_color(c_green);
            draw_rectangle(_x_pos, _y_pos, _x_pos + _card_width, _y_pos + _card_height, true);

            // Buy button logic
            if (mouse_check_button_pressed(mb_left)) {
                if (global.gold >= _cost) {
                    global.gold -= _cost;
					show_debug_message("--- MERC_SHOP: PURCHASED ITEM! ---");						
                    ds_list_add(global.player_team, _ref_merc);
                    ds_list_delete(global.mercenary_shop_stock, _i);
                    break; // Exit the loop to avoid issues with the ds_list size changing
                } else {
					show_debug_message("--- MERC_SHOP: NOT ENOUGH GOLD!!! ---");
					audio_play_sound(snd_menu_error,0,false);
                }
            }
        }

        // Draw card sprite
        draw_sprite_ext(_sprite, 0, _x_pos, _y_pos, 0.2, 0.2, 0, c_white, 1);

        // Draw cost *after* card graphics
        draw_set_color(c_white);
        draw_text(_x_pos + _card_width / 2, _y_pos + _card_height + 5, string(_cost) + " Gold");
    }
}