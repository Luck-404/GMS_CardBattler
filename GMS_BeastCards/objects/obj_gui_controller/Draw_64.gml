//
//
// DRAW GUI: OBJ_UI_CONTROLLER | DRAW GUI INFO
//
//
if (room != rm_battle){
#region PAUSE NOTIFIER
	if (global.pause){
	draw_set_colour(c_white);
	draw_set_font(fnt_gui_large);
	draw_text((room_width/2)-string_width("GAME PAUSED")/2,(room_height/8-100),"GAME PAUSED");
	}
#endregion

//
// PARTY DRAW | DRAWS PLAYER'S PARTY IN OVERWORLD
//
#region PARTY DRAW
if (global.active_gui == undefined)
{
    var _count = ds_list_size(global.player_party);

    var _slot_w = 70;
    var _slot_h = 70;
    var _spacing = -5;

    var _base_x = 5;
    var _base_y = room_height - 10 - (_count * (_slot_h + _spacing));

    var _ui_x1 = _base_x;
    var _ui_y1 = _base_y;
    var _ui_x2 = _base_x + _slot_w;
    var _ui_y2 = room_height - 10;

    //var _hover_any = false;

    //if (instance_exists(obj_player))
    //{
    //    if (obj_player.x >= _ui_x1 && obj_player.x <= _ui_x2
    //    && obj_player.y >= _ui_y1 && obj_player.y <= _ui_y2)
    //    {
    //        _hover_any = true;
    //    }
    //}

    //var _alpha = _hover_any ? 0.25 : 1;

    //draw_set_alpha(_alpha);

    for (var _i = 0; _i < _count; _i++)
    {
        var _unit = ds_list_find_value(global.player_party, _i);

        var _box_x = _base_x;
        var _box_y = _base_y + (_i * (_slot_h + _spacing));

        // SLOT BACKGROUND
		if (_unit[?"beast_hp_cur"] <= 0)
		{
		    draw_set_colour(c_black);
			draw_rectangle(_box_x, _box_y, _box_x + _slot_w, _box_y + _slot_h, false);

			// inner fill (keep neutral regardless of state)
			draw_set_colour(c_maroon);
			draw_rectangle(
			    _box_x + 3,
			    _box_y + 3,
			    _box_x + _slot_w - 3,
			    _box_y + _slot_h - 3,
			    false
			);			
		}
		else
		{
		    draw_set_colour(c_black);
			draw_rectangle(_box_x, _box_y, _box_x + _slot_w, _box_y + _slot_h, false);

			// inner fill (keep neutral regardless of state)
			draw_set_colour(c_gray);
			draw_rectangle(
			    _box_x + 3,
			    _box_y + 3,
			    _box_x + _slot_w - 3,
			    _box_y + _slot_h - 3,
			    false
			);			
		}



        // ICON
        var _cx = _box_x + (_slot_w * 0.5);
        var _cy = _box_y + (_slot_h * 0.5);

        var _shadow = scr_get_beast_type_shadow(_unit[?"beast_color_type"]);

        draw_sprite_ext(_shadow, 0, _cx, _cy + 10, 1, 1, 0, c_white, 1);

        draw_sprite_ext(
            _unit[?"beast_sprite"],
            0,
            _cx,
            _cy,
            0.10,
            0.10,
            0,
            c_white,
            1
        );
    }

    draw_set_alpha(1);

    // CLICK ANYWHERE ON PARTY STRIP -> OPEN PARTY PANE (unit 0 focus)
    if (device_mouse_x_to_gui(0) >= _ui_x1 && device_mouse_x_to_gui(0) <= _ui_x2
    && device_mouse_y_to_gui(0) >= _ui_y1 && device_mouse_y_to_gui(0) <= _ui_y2) && mouse_check_button_pressed(mb_left){
		draw_set_colour(c_fuchsia);
		draw_rectangle(_ui_x1+5,_ui_y1+5,_ui_x2-5,_ui_y2-5,true);
		draw_set_colour(c_white);
		
        scr_destroy_gui_open();
        scr_toggle_gui_pause();

        global.active_gui = instance_create_layer(
            room_width/2,
            room_height/2,
            "ily_fx",
            obj_gui_party_pane
        );

        // force reset selection to unit 0
        global.active_gui._pos = 0;
        global.active_gui._unit_selected =
            ds_list_find_value(global.player_party, 0);
    }
}

#endregion

//
// GOLD DRAW | TOP RIGHT HUD ELEMENT
//
#region GOLD DRAW
if (global.active_gui == undefined)
{
    var _text = string(global.player_gold) + " gp";

    draw_set_font(fnt_gui_medium);

    var _pad_x = 12;
    var _pad_y = 8;

    var _text_w = string_width(_text);
    var _text_h = string_height(_text);

    var _box_w = _text_w + (_pad_x * 2);
    var _box_h = _text_h + (_pad_y * 2);

    var _x1 = room_width - _box_w - 10;
    var _y1 = 10;
    var _x2 = room_width - 10;
    var _y2 = 10 + _box_h;

    //// OPACITY WHEN PLAYER OVERLAPS
    //var _gold_alpha = 1;

    //if (instance_exists(obj_player))
    //{
    //    if (obj_player.x >= _x1 && obj_player.x <= _x2
    //    && obj_player.y >= _y1 && obj_player.y <= _y2)
    //    {
    //        _gold_alpha = 0.25;
    //    }
    //}

    //draw_set_alpha(_gold_alpha);

    // BACKGROUND
    draw_set_colour(c_black);
    draw_rectangle(_x1, _y1, _x2, _y2, false);

    draw_set_colour(c_gray);
    draw_rectangle(_x1 + 3, _y1 + 3, _x2 - 3, _y2 - 3, false);

    // TEXT
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
    draw_set_colour(c_yellow);
    draw_text(_x1 + _pad_x, _y1 + _pad_y, _text);

    draw_set_alpha(1);
}
#endregion

//
// DECK ICON | TOP LEFT HUD BUTTON
//
#region DECK ICON
if (global.active_gui == undefined)
{
    var _icon_x1 = 40;
    var _icon_y1 = 40;
    var _icon_x2 = 80;
    var _icon_y2 = 120;

    var _hover = false;

    if (device_mouse_x_to_gui(0) >= 0 && device_mouse_x_to_gui(0) <= _icon_x2
    && device_mouse_y_to_gui(0) >= 0 && device_mouse_y_to_gui(0) <= _icon_y2)
    {
        _hover = true;
    }

    //// OPACITY WHEN PLAYER OVERLAPS
    //var _deck_alpha = 1;

    //if (instance_exists(obj_player))
    //{
    //    if (obj_player.x >= _icon_x1 && obj_player.x <= _icon_x2
    //    && obj_player.y >= _icon_y1 && obj_player.y <= _icon_y2)
    //    {
    //        _deck_alpha = 0.25;
    //    }
    //}

    //draw_set_alpha(_deck_alpha);

    // DRAW ICON
    draw_set_colour(c_white);
    draw_sprite(spr_deck_icon, _hover ? 1 : 0, _icon_x1, _icon_y1);

    draw_set_alpha(1);

    // CLICK -> OPEN DECK (same as K)
    if (_hover && mouse_check_button_pressed(mb_left))
    {
        scr_destroy_gui_open();
        scr_toggle_gui_pause();
        global.active_gui = instance_create_layer(
            room_width/2,
            room_height/2,
            "ily_fx",
            obj_gui_deck_pane
        );
    }
}
#endregion
}