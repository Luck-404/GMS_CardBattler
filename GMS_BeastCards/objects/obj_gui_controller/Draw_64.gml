//===============================================================================//
//
// DRAW GUI: OBJ_UI_CONTROLLER
// FUNCTION: Draws overworld HUD elements.
//           Displays pause text, party strip, gold counter, and deck button.
//           Handles clickable HUD shortcuts when no GUI pane is active.
//
//===============================================================================//

if (room != rm_battle){

	//--------------//
	//PAUSE NOTIFIER//
	//--------------//
	if (global.pause){
		draw_set_colour(c_white);
		draw_set_font(fnt_large_gui);
		draw_text((room_width / 2) - string_width("GAME PAUSED") / 2,room_height / 8 - 100,"GAME PAUSED");
	}

	//----------//
	//PARTY DRAW//
	//----------//
	if (global.active_gui == undefined){
		var _ct_party = ds_list_size(global.player_party);

		var _val_slot_w = 70;
		var _val_slot_h = 70;
		var _val_spacing = -5;

		var _val_base_x = 5;
		var _val_base_y = room_height - 10 - (_ct_party * (_val_slot_h + _val_spacing));

		var _val_ui_x1 = _val_base_x;
		var _val_ui_y1 = _val_base_y;
		var _val_ui_x2 = _val_base_x + _val_slot_w;
		var _val_ui_y2 = room_height - 10;

		var _flag_hover_any = false;

		if (instance_exists(obj_player)){
			if (obj_player.x >= _val_ui_x1 && obj_player.x <= _val_ui_x2 && obj_player.y >= _val_ui_y1 && obj_player.y <= _val_ui_y2){
				_flag_hover_any = true;
			}
		}

		var _val_alpha = _flag_hover_any ? 0.25 : 1;

		draw_set_alpha(_val_alpha);

		for (var _it_party = 0; _it_party < _ct_party; _it_party++){
			var _map_unit = ds_list_find_value(global.player_party,_it_party);

			var _val_box_x = _val_base_x;
			var _val_box_y = _val_base_y + (_it_party * (_val_slot_h + _val_spacing));

			draw_set_colour(c_black);
			draw_rectangle(_val_box_x,_val_box_y,_val_box_x + _val_slot_w,_val_box_y + _val_slot_h,false);

			if (_map_unit[? "beast_hp_cur"] <= 0){
				draw_set_colour(c_maroon);
			} else {
				draw_set_colour(c_gray);
			}

			draw_rectangle(_val_box_x + 3,_val_box_y + 3,_val_box_x + _val_slot_w - 3,_val_box_y + _val_slot_h - 3,false);

			var _val_center_x = _val_box_x + (_val_slot_w * 0.5);
			var _val_center_y = _val_box_y + (_val_slot_h * 0.5);

			var _spr_shadow = scr_get_beast_type_shadow(_map_unit[? "beast_color_type"]);

			draw_sprite_ext(_spr_shadow,0,_val_center_x,_val_center_y + 10,1,1,0,c_white,1);
			draw_sprite_ext(_map_unit[? "beast_sprite"],0,_val_center_x,_val_center_y,0.10,0.10,0,c_white,1);
		}

		draw_set_alpha(1);

		if (device_mouse_x_to_gui(0) >= _val_ui_x1 && device_mouse_x_to_gui(0) <= _val_ui_x2 && device_mouse_y_to_gui(0) >= _val_ui_y1 && device_mouse_y_to_gui(0) <= _val_ui_y2 && mouse_check_button_pressed(mb_left)){
			draw_set_colour(c_fuchsia);
			draw_rectangle(_val_ui_x1 + 5,_val_ui_y1 + 5,_val_ui_x2 - 5,_val_ui_y2 - 5,true);
			draw_set_colour(c_white);

			hscr_destroy_gui_open();
			hscr_toggle_gui_pause(true);

			global.active_gui = instance_create_layer(room_width / 2,room_height / 2,"ily_fx",obj_gui_party_pane);

			global.active_gui._pos = 0;
			global.active_gui._unit_selected = ds_list_find_value(global.player_party,0);
		}
	}

	//---------//
	//GOLD DRAW//
	//---------//
	if (global.active_gui == undefined){
		var _str_gold_text = string(global.player_gold) + " gp";

		draw_set_font(fnt_medium_gui);

		var _val_pad_x = 12;
		var _val_pad_y = 8;

		var _val_text_w = string_width(_str_gold_text);
		var _val_text_h = string_height(_str_gold_text);

		var _val_box_w = _val_text_w + (_val_pad_x * 2);
		var _val_box_h = _val_text_h + (_val_pad_y * 2);

		var _val_x1 = room_width - _val_box_w - 10;
		var _val_y1 = 10;
		var _val_x2 = room_width - 10;
		var _val_y2 = 10 + _val_box_h;

		var _val_gold_alpha = 1;

		if (instance_exists(obj_player)){
			if (obj_player.x >= _val_x1 && obj_player.x <= _val_x2 && obj_player.y >= _val_y1 && obj_player.y <= _val_y2){
				_val_gold_alpha = 0.25;
			}
		}

		draw_set_alpha(_val_gold_alpha);

		draw_set_colour(c_black);
		draw_rectangle(_val_x1,_val_y1,_val_x2,_val_y2,false);

		draw_set_colour(c_gray);
		draw_rectangle(_val_x1 + 3,_val_y1 + 3,_val_x2 - 3,_val_y2 - 3,false);

		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		draw_set_colour(c_yellow);
		draw_text(_val_x1 + _val_pad_x,_val_y1 + _val_pad_y,_str_gold_text);

		draw_set_alpha(1);
	}

	//---------//
	//DECK ICON//
	//---------//
	if (global.active_gui == undefined){
		var _val_icon_x1 = 40;
		var _val_icon_y1 = 40;
		var _val_icon_x2 = 80;
		var _val_icon_y2 = 120;

		var _flag_hover = false;

		if (device_mouse_x_to_gui(0) >= 0 && device_mouse_x_to_gui(0) <= _val_icon_x2 && device_mouse_y_to_gui(0) >= 0 && device_mouse_y_to_gui(0) <= _val_icon_y2){
			_flag_hover = true;
		}

		var _val_deck_alpha = 1;

		if (instance_exists(obj_player)){
			if (obj_player.x >= _val_icon_x1 - 40 && obj_player.x <= _val_icon_x2 && obj_player.y >= _val_icon_y1 - 40 && obj_player.y <= _val_icon_y2){
				_val_deck_alpha = 0.25;
			}
		}

		draw_set_alpha(_val_deck_alpha);

		draw_set_colour(c_white);
		draw_sprite(spr_gui_deck_icon,_flag_hover ? 1 : 0,_val_icon_x1,_val_icon_y1);

		draw_set_alpha(1);

		if (_flag_hover && mouse_check_button_pressed(mb_left)){
			hscr_destroy_gui_open();
			hscr_toggle_gui_pause(true);
			global.active_gui = instance_create_layer(room_width / 2,room_height / 2,"ily_fx",obj_gui_deck_pane);
		}
	}
}

//-----------//
//FPS COUNTER//
//-----------//
draw_text(room_width - 50,room_height - 50,string(fps_real));