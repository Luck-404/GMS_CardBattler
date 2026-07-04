//===============================================================================//
//
// DRAW GUI: OBJ_GUI_END_BATTLE_PANE
// FUNCTION: Draws battle result text, rewards, and party outcome.
//           Applies win/loss results once.
//           Handles confirm button transition out of battle.
//
//===============================================================================//

switch(_str_condition){

	//
	// LOSS
	//
	#region LOSS
	case "LOSS":

		draw_set_font(fnt_large_gui);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_colour(c_red);

		draw_text(room_width * 0.5 - (string_width("DEFEATED...") * 0.5),room_height * 0.5 - 75,"DEFEATED...");
		draw_text(room_width * 0.5 - (string_width("YOU LIMP BACK TO THE RANCH") * 0.5),room_height * 0.5,"YOU LIMP BACK TO THE RANCH");

		draw_set_colour(c_black);

		#region APPLY LOSS ONCE
		if (!_flag_finished){

			_flag_finished = true;

			for (var _it_unit = 0; _it_unit < ds_list_size(global.list_player_party); _it_unit++){

				var _stct_unit = ds_list_find_value(global.list_player_party,_it_unit);

				if (_stct_unit == undefined){
					continue;
				}

				_stct_unit._val_beast_hp_cur = 0;
			}
		}
		#endregion

		#region PARTY DRAW
		var _val_display_index = 0;

		for (var _it_unit = 0; _it_unit < ds_list_size(global.list_player_party); _it_unit++){

			var _stct_unit = ds_list_find_value(global.list_player_party,_it_unit);

			if (_stct_unit == undefined){
				continue;
			}

			var _ref_battle_unit = noone;

			for (var _it_battle_unit = 0; _it_battle_unit < ds_list_size(obj_battle_player_controller._list_beasts); _it_battle_unit++){

				var _ref_check_beast = ds_list_find_value(obj_battle_player_controller._list_beasts,_it_battle_unit);

				if (_ref_check_beast._uid_beast == _stct_unit._uid_beast){
					_ref_battle_unit = _ref_check_beast;
					break;
				}
			}

			if (!instance_exists(_ref_battle_unit)){
				continue;
			}

			var _flag_dead = (_ref_battle_unit._val_cur_hp <= 0);

			var _val_box_x = _val_row_start_x + ((_val_slot_size + _val_spacing) * _val_display_index);
			var _val_box_y = _val_row_y;

			_val_display_index++;

			draw_set_colour(c_black);
			draw_rectangle(_val_box_x,_val_box_y,_val_box_x + _val_slot_size,_val_box_y + _val_slot_size,false);

			draw_set_colour(_flag_dead ? c_maroon : c_gray);
			draw_rectangle(_val_box_x + 5,_val_box_y + 5,_val_box_x + 95,_val_box_y + 95,false);

			var _val_unit_x = _val_box_x + (_val_slot_size * 0.5);
			var _val_unit_y = _val_box_y + (_val_slot_size * 0.5);

			var _spr_shadow = scr_get_beast_type_shadow(_stct_unit._str_beast_color_type);
			draw_sprite_ext(_spr_shadow,0,_val_unit_x,_val_unit_y + 25,1,1,0,c_white,1);

			var _c_unit = _flag_dead ? c_ltgray : c_white;
			draw_sprite_ext(_stct_unit._spr_beast,0,_val_unit_x,_val_unit_y,0.125,0.125,0,_c_unit,1);

			draw_set_font(fnt_small_gui);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_set_colour(c_black);

			var _str_hp = "";

			if (_flag_dead){
				_str_hp = "DEAD";
			}
			else{
				_str_hp = "HP: " + string(_ref_battle_unit._val_cur_hp) + "/" + string(_ref_battle_unit._val_max_hp);
			}

			var _val_text_x = _val_unit_x;
			var _val_text_y = _val_box_y + _val_slot_size + 15;

			draw_text(_val_text_x - (string_width(_str_hp) * 0.5),_val_text_y,_str_hp);
		}
		#endregion

		#region CONFIRM
		if (mouse_check_button_pressed(mb_left) && position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_gui_end_battle_confirm_button)){

			scr_market_register_battle_complete();
	
			var _ref_transition = instance_create_layer(room_width * 0.5,room_height * 0.5,"ily_fx",obj_transition);
			_ref_transition._rm_destination = rm_ow_ranch;

			scr_spawn_popup_banner("RANCH ROOM");

			obj_player.x = 530;
			obj_player.y = 980;

			scr_toggle_player_movement("START");
			obj_player.visible = true;
		}
		#endregion

	break;
	#endregion

	//
	// WIN
	//
	#region WIN
	case "WIN":

		draw_set_font(fnt_large_gui);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_colour(c_black);

		draw_text(room_width * 0.5 - (string_width("YOU WON!") * 0.5),150,"YOU WON!");
		draw_text(room_width * 0.5 - (string_width("REWARDS:") * 0.5),200,"REWARDS:");

		#region APPLY WIN ONCE
		if (!_flag_finished){

			_flag_finished = true;

			scr_heal_ranch_units(0.33);

			var _val_gold_reward = irandom_range(25,100);
			global.val_player_gold += _val_gold_reward;

			array_push(_arr_rewards,["GOLD",_val_gold_reward]);

			for (var _it_reward = 0; _it_reward < 3; _it_reward++){

				var _str_reward_type = choose("ITEM","CARD");

				if (_str_reward_type == "CARD"){

					var _list_pool = choose(
						global.list_pool_cards_rarity_I,
						global.list_pool_cards_rarity_I,
						global.list_pool_cards_rarity_I,
						global.list_pool_cards_rarity_I,
						global.list_pool_cards_rarity_I,
						global.list_pool_cards_rarity_I,
						global.list_pool_cards_rarity_II,
						global.list_pool_cards_rarity_II,
						global.list_pool_cards_rarity_II,
						global.list_pool_cards_rarity_III
					);

					var _val_card_roll = irandom_range(0,ds_list_size(_list_pool) - 1);
					var _str_card_name = ds_list_find_value(_list_pool,_val_card_roll);
					var _stct_new_card = scr_get_card_info(_str_card_name);

					scr_add_card_to_deck(_stct_new_card);

					show_debug_message("RANDOM BATTLE REWARD + " + _str_card_name);

					array_push(_arr_rewards,["CARD",_stct_new_card]);
				}
				else{

					var _str_new_item = scr_get_random_item(global.list_pool_items);
					var _stct_fake_item = scr_get_item_info(_str_new_item);

					scr_add_item_to_inventory(_str_new_item,1);

					show_debug_message("RANDOM BATTLE REWARD + " + _str_new_item);

					array_push(_arr_rewards,["ITEM",_stct_fake_item]);
				}
			}

			for (var _it_unit = 0; _it_unit < ds_list_size(global.list_player_party); _it_unit++){

				var _stct_unit = ds_list_find_value(global.list_player_party,_it_unit);

				if (_stct_unit == undefined){
					continue;
				}

				var _ref_battle_unit = noone;

				for (var _it_battle_unit = 0; _it_battle_unit < ds_list_size(obj_battle_player_controller._list_beasts); _it_battle_unit++){

					var _ref_check_beast = ds_list_find_value(obj_battle_player_controller._list_beasts,_it_battle_unit);

					if (_ref_check_beast._uid_beast == _stct_unit._uid_beast){
						_ref_battle_unit = _ref_check_beast;
						break;
					}
				}

				if (instance_exists(_ref_battle_unit)){
					_stct_unit._val_beast_hp_cur = _ref_battle_unit._val_cur_hp;
				}

				if (_stct_unit._val_beast_hp_cur > 0){

					_stct_unit._val_beast_exp += 2;

					while (_stct_unit._val_beast_exp >= 10){
						_stct_unit._val_beast_exp -= 10;
						scr_level_up_beast(_stct_unit);
					}
				}
			}

			array_push(_arr_rewards,["EXP",2]);
		}
		#endregion

		#region DRAW REWARDS
		draw_set_font(fnt_small_gui);
		draw_set_colour(c_black);

		var _val_reward_x = room_width * 0.5;
		var _val_reward_y = room_width * 0.5 - 150;

		var _val_card_x = room_width * 0.5 - 150;
		var _val_card_y = _val_reward_y;

		for (var _it_reward = 0; _it_reward < array_length(_arr_rewards); _it_reward++){

			if (_arr_rewards[_it_reward][0] == "CARD"){

				var _stct_card = _arr_rewards[_it_reward][1];

				draw_sprite_ext(_stct_card._spr_card,0,_val_card_x,_val_card_y,0.2,0.2,0,c_white,1);

				draw_set_halign(fa_center);
				draw_text(_val_card_x,_val_card_y + 60,string(_stct_card._str_card_name));
				draw_set_halign(fa_left);

				_val_card_x += 150;
			}
			else if (_arr_rewards[_it_reward][0] == "ITEM"){

				var _stct_item = _arr_rewards[_it_reward][1];

				draw_sprite_ext(_stct_item._spr_item,0,_val_card_x,_val_card_y,2,2,0,c_white,1);

				draw_set_halign(fa_center);
				draw_text(_val_card_x,_val_card_y + 60,string(_stct_item._str_item_name));
				draw_set_halign(fa_left);

				_val_card_x += 150;
			}
		}

		_val_reward_y += 90;

		for (var _it_reward = 0; _it_reward < array_length(_arr_rewards); _it_reward++){

			if (_arr_rewards[_it_reward][0] == "GOLD"){

				draw_text(_val_reward_x - 100,_val_reward_y,"Gained " + string(_arr_rewards[_it_reward][1]) + " Gold");

				_val_reward_y += 30;
			}
		}

		for (var _it_reward = 0; _it_reward < array_length(_arr_rewards); _it_reward++){

			if (_arr_rewards[_it_reward][0] == "EXP"){

				draw_text(_val_reward_x - 100,_val_reward_y,"Each Beast Gained " + string(_arr_rewards[_it_reward][1]) + " EXP");

				_val_reward_y += 30;
			}
		}
		#endregion

		#region PARTY DRAW
		var _val_display_index = 0;

		for (var _it_unit = 0; _it_unit < ds_list_size(global.list_player_party); _it_unit++){

			var _stct_unit = ds_list_find_value(global.list_player_party,_it_unit);

			if (_stct_unit == undefined){
				continue;
			}

			var _ref_battle_unit = noone;

			for (var _it_battle_unit = 0; _it_battle_unit < ds_list_size(obj_battle_player_controller._list_beasts); _it_battle_unit++){

				var _ref_check_beast = ds_list_find_value(obj_battle_player_controller._list_beasts,_it_battle_unit);

				if (_ref_check_beast._uid_beast == _stct_unit._uid_beast){
					_ref_battle_unit = _ref_check_beast;
					break;
				}
			}

			if (!instance_exists(_ref_battle_unit)){
				continue;
			}

			var _flag_dead = (_ref_battle_unit._val_cur_hp <= 0);

			var _val_box_x = _val_row_start_x + ((_val_slot_size + _val_spacing) * _val_display_index);
			var _val_box_y = _val_row_y;

			_val_display_index++;

			draw_set_colour(c_black);
			draw_rectangle(_val_box_x,_val_box_y,_val_box_x + _val_slot_size,_val_box_y + _val_slot_size,false);

			draw_set_colour(_flag_dead ? c_maroon : c_gray);
			draw_rectangle(_val_box_x + 5,_val_box_y + 5,_val_box_x + 95,_val_box_y + 95,false);

			var _val_unit_x = _val_box_x + (_val_slot_size * 0.5);
			var _val_unit_y = _val_box_y + (_val_slot_size * 0.5);

			var _spr_shadow = scr_get_beast_type_shadow(_stct_unit._str_beast_color_type);
			draw_sprite_ext(_spr_shadow,0,_val_unit_x,_val_unit_y + 25,1,1,0,c_white,1);

			var _c_unit = _flag_dead ? c_ltgray : c_white;
			draw_sprite_ext(_stct_unit._spr_beast,0,_val_unit_x,_val_unit_y,0.125,0.125,0,_c_unit,1);

			draw_set_font(fnt_small_gui);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_set_colour(c_black);

			var _str_hp = "";

			if (_flag_dead){
				_str_hp = "DEAD";
			}
			else{
				_str_hp = "HP: " + string(_ref_battle_unit._val_cur_hp) + "/" + string(_ref_battle_unit._val_max_hp);
			}

			var _val_text_x = _val_unit_x;
			var _val_text_y = _val_box_y + _val_slot_size + 15;

			draw_text(_val_text_x - (string_width(_str_hp) * 0.5),_val_text_y,_str_hp);

			var _str_level = "Level: " + string(_stct_unit._val_beast_level);
			draw_text(_val_text_x - (string_width(_str_level) * 0.5),_val_text_y + 30,_str_level);
		}
		#endregion

		#region CONFIRM
		if (mouse_check_button_pressed(mb_left) && position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_gui_end_battle_confirm_button)){

			scr_market_register_battle_complete();
			
			var _ref_transition = instance_create_layer(room_width * 0.5,room_height * 0.5,"ily_fx",obj_transition);
			_ref_transition._rm_destination = global.rm_last_player;

			scr_spawn_popup_banner(global.str_last_player_banner);

			obj_player.x = global.val_last_player_x;
			obj_player.y = global.val_last_player_y;

			scr_toggle_player_movement("START");
			obj_player.visible = true;
		}
		#endregion

	break;
	#endregion
}