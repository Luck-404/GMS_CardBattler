//===============================================================================//
//
// DRAW GUI: OBJ_GUI_CONTROLLER
// FUNCTION: Draws overworld HUD elements.
//           Displays pause text, Party strip, Gold counter, and Deck shortcut.
//           Handles clickable Party/Deck HUD shortcuts and logs GUI openings.
//
//===============================================================================//

//================//
//GUI DIMENSIONS//
//================//
var _val_gui_width = display_get_gui_width();
var _val_gui_height = display_get_gui_height();

//================//
//OVERWORLD HUD//
//================//
if (room != rm_battle){

	//================//
	//PAUSE NOTIFIER//
	//================//
	if (global.flag_pause){

		draw_set_colour(c_white);
		draw_set_font(fnt_gui_large);

		draw_text(
			(_val_gui_width * 0.5) -
				(string_width("GAME PAUSED") * 0.5),
			(_val_gui_height * 0.125) - 100,
			"GAME PAUSED"
		);
	}

	//================//
	//PARTY DRAW//
	//================//
	if (!instance_exists(global.ref_active_gui)){

		var _ct_party = ds_list_size(global.list_player_party);

		var _val_slot_w = 70;
		var _val_slot_h = 70;
		var _val_spacing = -5;

		var _val_base_x = 5;

		var _val_base_y =
			_val_gui_height -
			10 -
			(_ct_party * (_val_slot_h + _val_spacing));

		var _val_ui_x1 = _val_base_x;
		var _val_ui_y1 = _val_base_y;
		var _val_ui_x2 = _val_base_x + _val_slot_w;
		var _val_ui_y2 = _val_gui_height - 10;

		var _flag_hover_any = false;

		if (instance_exists(obj_player)){

			if (
				obj_player.x >= _val_ui_x1 &&
				obj_player.x <= _val_ui_x2 &&
				obj_player.y >= _val_ui_y1 &&
				obj_player.y <= _val_ui_y2
			){
				_flag_hover_any = true;
			}
		}

		var _val_alpha = _flag_hover_any ? 0.25 : 1;

		draw_set_alpha(_val_alpha);

		//================//
		//DRAW PARTY SLOTS//
		//================//
		for (var _it_party = 0;_it_party < _ct_party;_it_party++){

			var _stct_unit = ds_list_find_value(
				global.list_player_party,
				_it_party
			);

			if (!is_struct(_stct_unit)){
				continue;
			}

			var _val_box_x = _val_base_x;

			var _val_box_y =
				_val_base_y +
				(_it_party * (_val_slot_h + _val_spacing));

			//----------------//
			//SLOT BORDER//
			//----------------//
			draw_set_colour(c_black);

			draw_rectangle(
				_val_box_x,
				_val_box_y,
				_val_box_x + _val_slot_w,
				_val_box_y + _val_slot_h,
				false
			);

			//----------------//
			//SLOT BACKGROUND//
			//----------------//
			if (_stct_unit._val_beast_hp_cur <= 0){
				draw_set_colour(c_maroon);
			}
			else{
				draw_set_colour(global.c_dk_gray);
			}

			draw_rectangle(
				_val_box_x + 3,
				_val_box_y + 3,
				_val_box_x + _val_slot_w - 3,
				_val_box_y + _val_slot_h - 3,
				false
			);

			//----------------//
			//DRAW BEAST//
			//----------------//
			var _val_center_x = _val_box_x + (_val_slot_w * 0.5);
			var _val_center_y = _val_box_y + (_val_slot_h * 0.5);

			var _spr_shadow = scr_beast_get_type_shadow(
				_stct_unit._str_beast_color_type
			);

			if (_spr_shadow != undefined){

				draw_sprite_ext(
					_spr_shadow,
					0,
					_val_center_x,
					_val_center_y + 24,
					1,
					1,
					0,
					c_white,
					1
				);
			}

			draw_sprite_ext(
				_stct_unit._spr_beast,
				0,
				_val_center_x,
				_val_center_y,
				0.10,
				0.10,
				0,
				c_white,
				1
			);
		}

		draw_set_alpha(1);

		//================//
		//PARTY HUD CLICK//
		//================//
		if (
			device_mouse_x_to_gui(0) >= _val_ui_x1 &&
			device_mouse_x_to_gui(0) <= _val_ui_x2 &&
			device_mouse_y_to_gui(0) >= _val_ui_y1 &&
			device_mouse_y_to_gui(0) <= _val_ui_y2 &&
			mouse_check_button_pressed(mb_left)
		){

			audio_play_sound(
				snd_gui_open,
				0,
				false
			);

			draw_set_colour(c_fuchsia);

			draw_rectangle(
				_val_ui_x1 + 5,
				_val_ui_y1 + 5,
				_val_ui_x2 - 5,
				_val_ui_y2 - 5,
				true
			);

			draw_set_colour(c_white);

			hscr_gui_destroy_active("PARTY HUD");
			hscr_gui_set_pause(true,"PARTY HUD");

			global.ref_active_gui = instance_create_layer(
				_val_gui_width * 0.5,
				_val_gui_height * 0.5,
				"ily_fx",
				obj_gui_party_pane
			);

			//----------------//
			//INITIAL SELECTION//
			//----------------//
			if (instance_exists(global.ref_active_gui)){

				global.ref_active_gui._val_pos = 0;

				global.ref_active_gui._stct_unit_selected =
					ds_list_find_value(
						global.list_player_party,
						0
					);
			}

			//================//
			//DEBUG GUI OPEN//
			//================//
			scr_debug_log(
				"GUI",
				"PANE",
				self,
				"GUI OPENED" +
				" | TYPE: PARTY" +
				" | SOURCE: PARTY HUD",
				"INFO",
				"OBJ_GUI_CONTROLLER:DRAW_GUI"
			);
		}
	}

	//================//
	//GOLD DRAW//
	//================//
	if (!instance_exists(global.ref_active_gui)){

		var _str_gold_text =
			string(global.val_player_gold) +
				" gp";

		draw_set_font(fnt_gui_medium);

		var _val_pad_x = 12;
		var _val_pad_y = 8;

		var _val_text_w = string_width(_str_gold_text);
		var _val_text_h = string_height(_str_gold_text);

		var _val_box_w = _val_text_w + (_val_pad_x * 2);
		var _val_box_h = _val_text_h + (_val_pad_y * 2);

		var _val_x1 = _val_gui_width - _val_box_w - 10;
		var _val_y1 = 10;

		var _val_x2 = _val_gui_width - 10;
		var _val_y2 = 10 + _val_box_h;

		var _val_gold_alpha = 1;

		if (instance_exists(obj_player)){

			if (
				obj_player.x >= _val_x1 &&
				obj_player.x <= _val_x2 &&
				obj_player.y >= _val_y1 &&
				obj_player.y <= _val_y2
			){
				_val_gold_alpha = 0.25;
			}
		}

		draw_set_alpha(_val_gold_alpha);

		draw_set_colour(c_black);

		draw_rectangle(
			_val_x1,
			_val_y1,
			_val_x2,
			_val_y2,
			false
		);

		draw_set_colour(global.c_dk_gray);

		draw_rectangle(
			_val_x1 + 3,
			_val_y1 + 3,
			_val_x2 - 3,
			_val_y2 - 3,
			false
		);

		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		draw_set_colour(c_yellow);

		draw_text(
			_val_x1 + _val_pad_x,
			_val_y1 + _val_pad_y,
			_str_gold_text
		);

		draw_set_alpha(1);
	}

	//================//
	//DECK ICON//
	//================//
	if (!instance_exists(global.ref_active_gui)){

		var _val_icon_x1 = 40;
		var _val_icon_y1 = 40;
		var _val_icon_x2 = 80;
		var _val_icon_y2 = 120;

		var _flag_hover =
			device_mouse_x_to_gui(0) >= 0 &&
			device_mouse_x_to_gui(0) <= _val_icon_x2 &&
			device_mouse_y_to_gui(0) >= 0 &&
			device_mouse_y_to_gui(0) <= _val_icon_y2;

		var _val_deck_alpha = 1;

		if (instance_exists(obj_player)){

			if (
				obj_player.x >= _val_icon_x1 - 40 &&
				obj_player.x <= _val_icon_x2 &&
				obj_player.y >= _val_icon_y1 - 40 &&
				obj_player.y <= _val_icon_y2
			){
				_val_deck_alpha = 0.25;
			}
		}

		draw_set_alpha(_val_deck_alpha);

		draw_set_colour(c_white);

		draw_sprite(
			spr_gui_deck_icon,
			_flag_hover ? 1 : 0,
			_val_icon_x1,
			_val_icon_y1
		);

		draw_set_alpha(1);

		//================//
		//DECK HUD CLICK//
		//================//
		if (
			_flag_hover &&
			mouse_check_button_pressed(mb_left)
		){

			audio_play_sound(
				snd_gui_open,
				0,
				false
			);

			hscr_gui_destroy_active("DECK HUD");
			hscr_gui_set_pause(true,"DECK HUD");

			global.ref_active_gui = instance_create_layer(
				_val_gui_width * 0.5,
				_val_gui_height * 0.5,
				"ily_fx",
				obj_gui_deck_pane
			);

			//================//
			//DEBUG GUI OPEN//
			//================//
			scr_debug_log(
				"GUI",
				"PANE",
				self,
				"GUI OPENED" +
				" | TYPE: DECK" +
				" | SOURCE: DECK HUD",
				"INFO",
				"OBJ_GUI_CONTROLLER:DRAW_GUI"
			);
		}
	}
}

//================//
//FPS COUNTER//
//================//

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
draw_set_font(fnt_gui_party_small);
var _val_fps = clamp(fps_real,0,240);
draw_text(
	1015,
	0,
	"FPS: " + string(_val_fps)
);