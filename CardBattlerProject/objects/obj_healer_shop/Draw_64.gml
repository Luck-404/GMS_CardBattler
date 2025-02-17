//////////////////////////////////////////////////////////////////////
//					OBJ_HEAL_SHOP DRAW GUI							//
//																	//
// > WHEN A PLAYER PRESSES 'E', SHOW THE DISPLAY. HANDLE LEFT CLICK //
//   LOGIC WHEN INTERACTING WITH THE SHOP.							//
//////////////////////////////////////////////////////////////////////
if (keyboard_check_pressed(ord("E")) && place_meeting(x,y,obj_player)) {
    show_debug_message("+=+=+ HEALER_SHOP: ACTIVATED +=+=+");
    global.healer_shop_gui_open = !global.healer_shop_gui_open;
    obj_player._move_speed = global.healer_shop_gui_open ? 0 : 4;
}

if (global.healer_shop_gui_open) {
    if (keyboard_check_pressed(vk_escape)) {
        show_debug_message("+=+=+ HEALER_SHOP: CLOSED +=+=+");
        global.healer_shop_gui_open = false;
        obj_player._move_speed = 4;
    }

    // Background
    draw_set_color(c_silver);
    draw_rectangle_color(50, 50, 900, 900, c_silver, c_silver, c_silver, c_silver, false);

    // Draw unit cards
    var _margin = 100;
    var _card_width = 128;
    var _card_height = 128;
    var _spacing = 100;
    var _button_spacing = 60; // Increased vertical spacing between buttons
    var _button_x_offset = -50; // Move buttons slightly to the left

    for (var _i = 0; _i < ds_list_size(global.player_team); _i++) {
        var _ref_unit = ds_list_find_value(global.player_team, _i);
        var _sprite = _ref_unit[?"sprite"];
        var _curhp = _ref_unit[?"curhp"];
        var _maxhp = _ref_unit[?"hp"];

        // Calculate cost for full heal
        var _diff = _maxhp - _curhp;
        var _maxcost = ceil(_diff / 10) * 18;

        // Position of the sprite
        var _x_pos = _margin + _i * (_card_width + _spacing);
        var _y_pos = 150;

        // Button positions
        var _button_10_y = _y_pos + _card_height + 5;
        var _button_max_y = _button_10_y + _button_spacing;

        // Mouse position
        var _mouse_x = window_mouse_get_x();
        var _mouse_y = window_mouse_get_y();

        // Check hover for buttons
        var _hover_10_hp = _mouse_x > _x_pos + _button_x_offset &&
                           _mouse_x < _x_pos + _button_x_offset + 30 &&
                           _mouse_y > _button_10_y &&
                           _mouse_y < _button_10_y + 30;

        var _hover_max_hp = _mouse_x > _x_pos + _button_x_offset &&
                            _mouse_x < _x_pos + _button_x_offset + 30 &&
                            _mouse_y > _button_max_y &&
                            _mouse_y < _button_max_y + 30;

        // Check if unit is at full HP
        var _is_full_hp = _curhp >= _maxhp;

        // Highlight the unit box if hovering over either button
        if (_hover_10_hp || _hover_max_hp) {
            draw_set_color(c_yellow);
            draw_rectangle(_x_pos - 10, _y_pos - 10, _x_pos + _card_width + 10, _y_pos + _card_height + 10, true);
        }

        //// Draw card sprite
        //draw_sprite_ext(_sprite, 0, _x_pos, _y_pos, 0.2, 0.2, 0, c_white, 1);
        // Draw card sprite
        draw_sprite_ext(_sprite, 0, _x_pos+64, _y_pos+64, 1, 1, 0, c_white, 1);


        // Draw HP above buttons
        draw_set_color(c_white);
        draw_text(_x_pos + _button_x_offset - 10, _button_10_y - 25, string(_curhp) + " / " + string(_maxhp));

        // Draw buttons
        if (_is_full_hp) {
            // Grey out buttons if at full HP
            draw_set_color(c_gray);
        } else if (_hover_10_hp) {
            draw_set_color(c_lime);
        } else {
            draw_set_color(c_teal);
        }
        draw_circle(_x_pos + _button_x_offset + 15, _button_10_y + 15, 15, false);
        draw_text(_x_pos + _button_x_offset, _button_10_y + 15, "10HP");

        if (_is_full_hp) {
            draw_set_color(c_gray);
        } else if (_hover_max_hp) {
            draw_set_color(c_yellow);
        } else {
            draw_set_color(c_orange);
        }
        draw_circle(_x_pos + _button_x_offset + 15, _button_max_y + 15, 15, false);
        draw_text(_x_pos + _button_x_offset, _button_max_y + 15, "MAX");

        // Handle button clicks
        if (!_is_full_hp && _hover_10_hp && mouse_check_button_pressed(mb_left)) {
            if (global.gold >= 10) {
                global.gold -= 10;
                show_debug_message("+=+=+ HEALER_SHOP: PURCHASED 10HP HEAL! +=+=+");
                _ref_unit[?"curhp"] = min(_ref_unit[?"curhp"] + 10, _ref_unit[?"hp"]);
            } else {
                show_debug_message("+=+=+ HEALER_SHOP: NOT ENOUGH GOLD!!! +=+=+");
				audio_play_sound(snd_menu_error,0,false);
            }
        }

        if (!_is_full_hp && _hover_max_hp && mouse_check_button_pressed(mb_left)) {
            if (global.gold >= _maxcost) {
                global.gold -= _maxcost;
                show_debug_message("+=+=+ HEALER_SHOP: PURCHASED MAX HEAL! +=+=+");
                _ref_unit[?"curhp"] = _ref_unit[?"hp"];
            } else {
                show_debug_message("+=+=+ HEALER_SHOP: NOT ENOUGH GOLD!!! +=+=+");
				audio_play_sound(snd_menu_error,0,false);
            }
        }
    }
}