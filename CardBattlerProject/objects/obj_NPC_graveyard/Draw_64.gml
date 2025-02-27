//////////////////////////////////////////////////////////////////////
//					OBJ_GRAVEYARD DRAW GUI							//
//																	//
// > WHEN A PLAYER PRESSES 'E', SHOW THE DISPLAY.					//
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
    draw_rectangle_color(50, 50, 900, 900, c_silver, c_silver, c_silver, c_silver, false);

    // Draw units
    var _margin = 100;
    var _card_width = 128;
    var _card_height = 128;
    var _spacing = 100;

    for (var _i = 0; _i < ds_list_size(global.graveyard); _i++) {
        var _ref_unit = ds_list_find_value(global.graveyard, _i);
        var _name = _ref_unit[?"name"];				
        var _sprite = _ref_unit[?"sprite"];

        // Position of the sprite
        var _x_pos = _margin + _i * (_card_width + _spacing);
        var _y_pos = 150;

        // Mouse position
        var _mouse_x = window_mouse_get_x();
        var _mouse_y = window_mouse_get_y();
       
        //// Draw card sprite
        //draw_sprite_ext(_sprite, 0, _x_pos, _y_pos, 0.2, 0.2, 0, c_white, 1);
        // Draw card sprite
        draw_sprite_ext(_sprite, 0, _x_pos+64, _y_pos+64, 1, 1, 0, c_white, 1);
		draw_set_color(c_white);
		draw_text(_x_pos, _y_pos+150,"Here lies...\n    " + _name);

    }
}