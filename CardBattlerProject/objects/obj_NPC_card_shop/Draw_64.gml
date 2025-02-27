//////////////////////////////////////////////////////////////////////
//					OBJ_CARD_SHOP DRAW GUI							//
//																	//
// > WHEN A PLAYER PRESSES 'E', SHOW THE DISPLAY. HANDLE LEFT CLICK //
//   LOGIC WHEN INTERACTING WITH THE SHOP.							//
//////////////////////////////////////////////////////////////////////
if (instance_exists(obj_player) && global.player_ow_state == PLAYER_OW_STATE.GENERAL && distance_to_object(obj_player) < 64 && keyboard_check_pressed(ord("E"))) {
    global.flag_gui_open = !global.flag_gui_open;
	global.player_ow_state == PLAYER_OW_STATE.INTERACT;
	_interacted = true;
    obj_player._move_speed = global.flag_gui_open ? 0 : 3;
}

if (global.flag_gui_open && _interacted == true) {
    if (keyboard_check_pressed(vk_escape)) {	
		_interacted = false;
		global.player_ow_state = PLAYER_OW_STATE.GENERAL;
        global.flag_gui_open = false;
        obj_player._move_speed = 3;
    }

    // Background
    draw_set_color(c_silver);
    draw_rectangle_color(50, 50, 750, 550, c_silver, c_silver, c_silver, c_silver, false);

    // Draw cards
    var _margin = 100;
    var _card_width = 80;
    var _card_height = 120;
    var _spacing = 30;

    for (var _i = 0; _i < ds_list_size(global.card_shop_stock); _i++) {
        var _ref_card = ds_list_find_value(global.card_shop_stock, _i);
        var _sprite = _ref_card[?"sprite"];
        var _cost = _ref_card[?"goldcost"]; // GOLD COST
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
					
                    ds_list_add(global.card_inventory, _ref_card);
                    ds_list_delete(global.card_shop_stock, _i);
                    break; // Exit the loop to avoid issues with the ds_list size changing
                } else {

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