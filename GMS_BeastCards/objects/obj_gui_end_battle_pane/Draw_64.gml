//===============================================================================//
// DRAW GUI: OBJ_GUI_END_BATTLE_PANE
// FUNCTION: Draws battle result text, rewards, and party outcome.
//           Applies win/loss results once.
//           Logs and grants battle rewards.
//           Handles the confirmed transition out of battle.
//
//===============================================================================//

//----------------------//
//VALIDATE BATTLE STATE//
//----------------------//
if (!instance_exists(obj_battle_player_controller)){
	exit;
}

if (!ds_exists(global.list_player_party,ds_type_list)){
	exit;
}

if (!ds_exists(obj_battle_player_controller._list_beasts,ds_type_list)){
	exit;
}

//---------------------//
//CHECK CONFIRM INPUT//
//---------------------//
var _flag_confirm_pressed = false;

if (instance_exists(_ref_confirm_button)){

	_flag_confirm_pressed =
		mouse_check_button_pressed(mb_left) &&
		position_meeting(
			device_mouse_x_to_gui(0),
			device_mouse_y_to_gui(0),
			_ref_confirm_button
		);
}

//================//
//BATTLE RESULT//
//================//
switch (_str_condition){

	//======//
	//LOSS//
	//======//
	#region LOSS

	case "LOSS":

		//-------------//
		//RESULT TEXT//
		//-------------//
		draw_set_font(fnt_gui_large);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_colour(c_red);

		draw_text(
			room_width * 0.5 - (string_width("DEFEATED...") * 0.5),
			room_height * 0.5 - 75,
			"DEFEATED..."
		);

		draw_text(
			room_width * 0.5 - (string_width("YOU LIMP BACK TO THE RANCH") * 0.5),
			room_height * 0.5,
			"YOU LIMP BACK TO THE RANCH"
		);

		draw_set_colour(c_black);

		//-----------------//
		//APPLY LOSS ONCE//
		//-----------------//
		if (!_flag_finished){

			_flag_finished = true;

			for (var _it_beast = 0;_it_beast < ds_list_size(global.list_player_party);_it_beast++){

				var _stct_beast = ds_list_find_value(
					global.list_player_party,
					_it_beast
				);

				if (!is_struct(_stct_beast)){
					continue;
				}

				_stct_beast._val_beast_hp_cur = 0;
			}

			//===================//
			//DEBUG LOSS RESULT//
			//===================//
			scr_debug_log(
				"BATTLE",
				"RESULT",
				self,
				"LOSS RESULT APPLIED | PARTY HP SET TO 0" +
				" | PARTY: " + string(ds_list_size(global.list_player_party)),
				"BATTLE",
				"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI"
			);
		}

		//============//
		//DRAW PARTY//
		//============//
		var _val_display_index = 0;

		for (var _it_beast = 0;_it_beast < ds_list_size(global.list_player_party);_it_beast++){

			var _stct_beast = ds_list_find_value(
				global.list_player_party,
				_it_beast
			);

			if (!is_struct(_stct_beast)){
				continue;
			}

			var _ref_battle_beast = noone;

			//-------------------//
			//FIND BATTLE BEAST//
			//-------------------//
			for (var _it_battle_beast = 0;_it_battle_beast < ds_list_size(obj_battle_player_controller._list_beasts);_it_battle_beast++){

				var _ref_check_beast = ds_list_find_value(
					obj_battle_player_controller._list_beasts,
					_it_battle_beast
				);

				if (!instance_exists(_ref_check_beast)){
					continue;
				}

				if (_ref_check_beast._uid_beast == _stct_beast._uid_beast){

					_ref_battle_beast = _ref_check_beast;

					break;
				}
			}

			if (!instance_exists(_ref_battle_beast)){
				continue;
			}

			var _flag_dead = _ref_battle_beast._val_cur_hp <= 0;

			//---------------//
			//SLOT POSITION//
			//---------------//
			var _val_box_x =
				_val_row_start_x +
				((_val_slot_size + _val_spacing) * _val_display_index);

			var _val_box_y = _val_row_y;

			_val_display_index++;

			//-----------//
			//DRAW SLOT//
			//-----------//
			draw_set_colour(c_black);

			draw_rectangle(
				_val_box_x,
				_val_box_y,
				_val_box_x + _val_slot_size,
				_val_box_y + _val_slot_size,
				false
			);

			draw_set_colour(
				_flag_dead ?
					c_maroon :
					global.c_dk_gray
			);

			draw_rectangle(
				_val_box_x + 5,
				_val_box_y + 5,
				_val_box_x + 95,
				_val_box_y + 95,
				false
			);

			//-----------//
			//DRAW BEAST//
			//-----------//
			var _val_beast_x = _val_box_x + (_val_slot_size * 0.5);
			var _val_beast_y = _val_box_y + (_val_slot_size * 0.5);

			var _spr_shadow = scr_beast_get_type_shadow(
				_stct_beast._str_beast_color_type
			);

			draw_sprite_ext(
				_spr_shadow,
				0,
				_val_beast_x,
				_val_beast_y + 24,
				1,
				1,
				0,
				c_white,
				1
			);

			var _c_beast = _flag_dead ? c_ltgray : c_white;

			draw_sprite_ext(
				_stct_beast._spr_beast,
				0,
				_val_beast_x,
				_val_beast_y,
				0.125,
				0.125,
				0,
				_c_beast,
				1
			);

			//--------//
			//DRAW HP//
			//--------//
			draw_set_font(fnt_gui_small);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_set_colour(c_black);

			var _str_hp = "";

			if (_flag_dead){
				_str_hp = "DEAD";
			}
			else{

				_str_hp =
					"HP: " +
					string(_ref_battle_beast._val_cur_hp) +
					"/" +
					string(_ref_battle_beast._val_max_hp);
			}

			var _val_text_x = _val_beast_x;
			var _val_text_y = _val_box_y + _val_slot_size + 15;

			draw_text(
				_val_text_x - (string_width(_str_hp) * 0.5),
				_val_text_y,
				_str_hp
			);
		}

		//---------//
		//CONFIRM//
		//---------//
		if (_flag_confirm_pressed){

			audio_play_sound(
				snd_gui_press,
				0,
				false
			);

			scr_market_register_battle_completion();

			//=================//
			//DEBUG BATTLE EXIT//
			//=================//
			scr_debug_log(
				"BATTLE",
				"EXIT",
				self,
				"BATTLE EXIT CONFIRMED | RESULT: LOSS" +
				" | DESTINATION: " + room_get_name(rm_ow_ranch) +
				" | POSITION: (530,980)",
				"BATTLE",
				"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI"
			);

			var _ref_transition = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_fx",
				obj_transition
			);

			_ref_transition._rm_destination = rm_ow_ranch;

			scr_gui_spawn_popup_banner("RANCH ROOM");

			obj_player.x = 530;
			obj_player.y = 980;

			scr_player_set_movement_state("START");

			obj_player.visible = true;
		}

	break;

	#endregion

	//=====//
	//WIN//
	//=====//
	#region WIN

	case "WIN":

		//-------------//
		//RESULT TEXT//
		//-------------//
		draw_set_font(fnt_gui_large);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_colour(c_black);

		draw_text(
			room_width * 0.5 - (string_width("YOU WON!") * 0.5),
			150,
			"YOU WON!"
		);

		draw_text(
			room_width * 0.5 - (string_width("REWARDS:") * 0.5),
			200,
			"REWARDS:"
		);

		//----------------//
		//APPLY WIN ONCE//
		//----------------//
		if (!_flag_finished){

			_flag_finished = true;

			//-------------------//
			//HEAL RANCH BEASTS//
			//-------------------//
			scr_ranch_heal_beasts(0.33);

			//=============//
			//GOLD REWARD//
			//=============//
			var _val_gold_base = 100;
			var _val_gold_reward = _val_gold_base;
			var _val_gold_bonus = 0;

			//----------------------//
			//BATTLE EXIT ITEM BONUS//
			//----------------------//
			for (var _it_beast = 0;_it_beast < ds_list_size(obj_battle_player_controller._list_beasts);_it_beast++){

				var _ref_beast = ds_list_find_value(
					obj_battle_player_controller._list_beasts,
					_it_beast
				);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				var _stct_item = _ref_beast._stct_held_item;

				if (
					_stct_item == undefined ||
					_stct_item == "EMPTY"
				){
					continue;
				}

				if (_stct_item._str_item_trigger_type != "BATTLE_EXIT"){
					continue;
				}

				if (_stct_item._scr_item == undefined){
					continue;
				}

				var _val_item_bonus = script_execute(
					_stct_item._scr_item,
					"TRIGGER",
					_stct_item
				);

				_val_gold_bonus += _val_item_bonus;
			}

			//----------------//
			//APPLY GOLD BONUS//
			//----------------//
			if (_val_gold_bonus > 0){

				_val_gold_reward = ceil(
					_val_gold_reward *
					(1 + _val_gold_bonus)
				);
			}

			global.val_player_gold += _val_gold_reward;

			array_push(
				_arr_rewards,
				["GOLD",_val_gold_reward]
			);

			//================//
			//DEBUG GOLD REWARD//
			//================//
			scr_debug_log(
				"BATTLE",
				"REWARD",
				self,
				"BATTLE REWARD | GOLD: +" + string(_val_gold_reward) +
				" | BASE: " + string(_val_gold_base) +
				" | BONUS: " + string(round(_val_gold_bonus * 100)) + "%" +
				" | PLAYER GOLD: " + string(global.val_player_gold),
				"REWARD",
				"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI"
			);

			//=======================//
			//GENERATE RANDOM REWARDS//
			//=======================//
			for (var _it_reward = 0;_it_reward < 3;_it_reward++){

				var _str_reward_type = choose(
					"ITEM",
					"CARD"
				);

				switch (_str_reward_type){

					//======//
					//CARD//
					//======//
					case "CARD":

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

						if (!ds_exists(_list_pool,ds_type_list)){
							continue;
						}

						if (ds_list_size(_list_pool) <= 0){

							scr_debug_log(
								"BATTLE",
								"REWARD",
								self,
								"BATTLE CARD REWARD FAILED" +
								" | SLOT: " + string(_it_reward + 1) +
								"/3 | REASON: EMPTY CARD POOL",
								"WARNING",
								"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI"
							);

							continue;
						}

						var _it_card_roll = irandom_range(
							0,
							ds_list_size(_list_pool) - 1
						);

						var _str_card_name = ds_list_find_value(
							_list_pool,
							_it_card_roll
						);

						var _stct_new_card = scr_card_get_info(
							_str_card_name
						);

						if (!is_struct(_stct_new_card)){

							scr_debug_log(
								"BATTLE",
								"REWARD",
								self,
								"BATTLE CARD REWARD FAILED" +
								" | SLOT: " + string(_it_reward + 1) +
								"/3 | CARD: " + string_upper(_str_card_name) +
								" | REASON: INVALID CARD DATA",
								"ERROR",
								"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI"
							);

							continue;
						}

						scr_deck_add_card(_stct_new_card);

						array_push(
							_arr_rewards,
							["CARD",_stct_new_card]
						);

						//================//
						//DEBUG CARD REWARD//
						//================//
						scr_debug_log(
							"BATTLE",
							"REWARD",
							self,
							"BATTLE REWARD" +
							" | SLOT: " + string(_it_reward + 1) +
							"/3 | CARD: " +
							string_upper(_str_card_name),
							"REWARD",
							"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI"
						);

					break;

					//======//
					//ITEM//
					//======//
					case "ITEM":

						var _str_new_item = scr_inventory_get_random_item(
							global.list_pool_items
						);

						if (_str_new_item == undefined){

							scr_debug_log(
								"BATTLE",
								"REWARD",
								self,
								"BATTLE ITEM REWARD FAILED" +
								" | SLOT: " + string(_it_reward + 1) +
								"/3 | REASON: NO VALID ITEM",
								"WARNING",
								"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI"
							);

							continue;
						}

						var _stct_reward_item = scr_inventory_get_item_info(
							_str_new_item
						);

						scr_inventory_add_item(
							_str_new_item,
							1
						);

						array_push(
							_arr_rewards,
							["ITEM",_stct_reward_item]
						);

						//================//
						//DEBUG ITEM REWARD//
						//================//
						scr_debug_log(
							"BATTLE",
							"REWARD",
							self,
							"BATTLE REWARD" +
							" | SLOT: " + string(_it_reward + 1) +
							"/3 | ITEM: " +
							string_upper(_str_new_item) +
							" | AMOUNT: 1",
							"REWARD",
							"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI"
						);

					break;
				}
			}

			//=====================//
			//SAVE HP AND ADD EXP//
			//=====================//
			var _ct_exp_recipients = 0;

			for (var _it_beast = 0;_it_beast < ds_list_size(global.list_player_party);_it_beast++){

				var _stct_beast = ds_list_find_value(
					global.list_player_party,
					_it_beast
				);

				if (!is_struct(_stct_beast)){
					continue;
				}

				var _ref_battle_beast = noone;

				//-------------------//
				//FIND BATTLE BEAST//
				//-------------------//
				for (var _it_battle_beast = 0;_it_battle_beast < ds_list_size(obj_battle_player_controller._list_beasts);_it_battle_beast++){

					var _ref_check_beast = ds_list_find_value(
						obj_battle_player_controller._list_beasts,
						_it_battle_beast
					);

					if (!instance_exists(_ref_check_beast)){
						continue;
					}

					if (_ref_check_beast._uid_beast == _stct_beast._uid_beast){

						_ref_battle_beast = _ref_check_beast;

						break;
					}
				}

				//----------------------//
				//STORE POST-BATTLE HP//
				//----------------------//
				if (instance_exists(_ref_battle_beast)){

					_stct_beast._val_beast_hp_cur = clamp(
						_ref_battle_beast._val_cur_hp,
						0,
						_stct_beast._val_beast_hp_max
					);
				}

				//----------//
				//GRANT EXP//
				//----------//
				if (_stct_beast._val_beast_hp_cur > 0){

					_ct_exp_recipients++;

					_stct_beast._val_beast_exp += 2;

					while (_stct_beast._val_beast_exp >= 10){

						_stct_beast._val_beast_exp -= 10;

						scr_beast_level_up(_stct_beast);
					}
				}
			}

			array_push(
				_arr_rewards,
				["EXP",2]
			);

			//================//
			//DEBUG EXP REWARD//
			//================//
			scr_debug_log(
				"BATTLE",
				"REWARD",
				self,
				"BATTLE REWARD | EXP: +2 EACH" +
				" | RECIPIENTS: " +
				string(_ct_exp_recipients),
				"REWARD",
				"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI"
			);

			//====================//
			//DEBUG REWARD SUMMARY//
			//====================//
			scr_debug_log(
				"BATTLE",
				"REWARD",
				self,
				"BATTLE REWARDS COMPLETE" +
				" | GOLD: +" + string(_val_gold_reward) +
				" | RANDOM REWARD SLOTS: 3" +
				" | EXP: +2" +
				" | EXP RECIPIENTS: " +
				string(_ct_exp_recipients),
				"REWARD",
				"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI"
			);

			//==================//
			//DEBUG WIN RESULT//
			//==================//
			scr_debug_log(
				"BATTLE",
				"RESULT",
				self,
				"WIN RESULT APPLIED | POST-BATTLE PARTY STATE SAVED" +
				" | PARTY: " +
				string(ds_list_size(global.list_player_party)),
				"BATTLE",
				"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI"
			);
		}

		//==============//
		//DRAW REWARDS//
		//==============//
		draw_set_font(fnt_gui_small);
		draw_set_colour(c_black);

		var _val_reward_x = room_width * 0.5;
		var _val_reward_y = room_height * 0.5 - 150;

		var _val_card_x = room_width * 0.5 - 150;
		var _val_card_y = _val_reward_y;

		//-----------------------//
		//DRAW CARD/ITEM REWARDS//
		//-----------------------//
		for (var _it_reward = 0;_it_reward < array_length(_arr_rewards);_it_reward++){

			var _arr_reward = _arr_rewards[_it_reward];

			switch (_arr_reward[0]){

				//======//
				//CARD//
				//======//
				case "CARD":

					var _stct_card = _arr_reward[1];

					draw_sprite_ext(
						_stct_card._spr_card,
						0,
						_val_card_x,
						_val_card_y,
						0.2,
						0.2,
						0,
						c_white,
						1
					);

					draw_set_halign(fa_center);

					draw_text(
						_val_card_x,
						_val_card_y + 60,
						string(_stct_card._str_card_name)
					);

					draw_set_halign(fa_left);

					_val_card_x += 150;

				break;

				//======//
				//ITEM//
				//======//
				case "ITEM":

					var _stct_item = _arr_reward[1];

					draw_sprite_ext(
						_stct_item._spr_item,
						0,
						_val_card_x,
						_val_card_y,
						2,
						2,
						0,
						c_white,
						1
					);

					draw_set_halign(fa_center);

					draw_text(
						_val_card_x,
						_val_card_y + 60,
						string(_stct_item._str_item_name)
					);

					draw_set_halign(fa_left);

					_val_card_x += 150;

				break;
			}
		}

		_val_reward_y += 90;

		//-----------//
		//DRAW GOLD//
		//-----------//
		for (var _it_reward = 0;_it_reward < array_length(_arr_rewards);_it_reward++){

			var _arr_reward = _arr_rewards[_it_reward];

			if (_arr_reward[0] != "GOLD"){
				continue;
			}

			draw_text(
				_val_reward_x - 100,
				_val_reward_y,
				"Gained " +
				string(_arr_reward[1]) +
				" Gold"
			);

			_val_reward_y += 30;
		}

		//----------//
		//DRAW EXP//
		//----------//
		for (var _it_reward = 0;_it_reward < array_length(_arr_rewards);_it_reward++){

			var _arr_reward = _arr_rewards[_it_reward];

			if (_arr_reward[0] != "EXP"){
				continue;
			}

			draw_text(
				_val_reward_x - 100,
				_val_reward_y,
				"Each Beast Gained " +
				string(_arr_reward[1]) +
				" EXP"
			);

			_val_reward_y += 30;
		}

		//============//
		//DRAW PARTY//
		//============//
		var _val_display_index = 0;

		for (var _it_beast = 0;_it_beast < ds_list_size(global.list_player_party);_it_beast++){

			var _stct_beast = ds_list_find_value(
				global.list_player_party,
				_it_beast
			);

			if (!is_struct(_stct_beast)){
				continue;
			}

			var _ref_battle_beast = noone;

			//-------------------//
			//FIND BATTLE BEAST//
			//-------------------//
			for (var _it_battle_beast = 0;_it_battle_beast < ds_list_size(obj_battle_player_controller._list_beasts);_it_battle_beast++){

				var _ref_check_beast = ds_list_find_value(
					obj_battle_player_controller._list_beasts,
					_it_battle_beast
				);

				if (!instance_exists(_ref_check_beast)){
					continue;
				}

				if (_ref_check_beast._uid_beast == _stct_beast._uid_beast){

					_ref_battle_beast = _ref_check_beast;

					break;
				}
			}

			if (!instance_exists(_ref_battle_beast)){
				continue;
			}

			var _flag_dead = _ref_battle_beast._val_cur_hp <= 0;

			//---------------//
			//SLOT POSITION//
			//---------------//
			var _val_box_x =
				_val_row_start_x +
				((_val_slot_size + _val_spacing) * _val_display_index);

			var _val_box_y = _val_row_y;

			_val_display_index++;

			//-----------//
			//DRAW SLOT//
			//-----------//
			draw_set_colour(c_black);

			draw_rectangle(
				_val_box_x,
				_val_box_y,
				_val_box_x + _val_slot_size,
				_val_box_y + _val_slot_size,
				false
			);

			draw_set_colour(
				_flag_dead ?
					c_maroon :
					global.c_dk_gray
			);

			draw_rectangle(
				_val_box_x + 5,
				_val_box_y + 5,
				_val_box_x + 95,
				_val_box_y + 95,
				false
			);

			//-----------//
			//DRAW BEAST//
			//-----------//
			var _val_beast_x = _val_box_x + (_val_slot_size * 0.5);
			var _val_beast_y = _val_box_y + (_val_slot_size * 0.5);

			var _spr_shadow = scr_beast_get_type_shadow(
				_stct_beast._str_beast_color_type
			);

			draw_sprite_ext(
				_spr_shadow,
				0,
				_val_beast_x,
				_val_beast_y + 24,
				1,
				1,
				0,
				c_white,
				1
			);

			var _c_beast = _flag_dead ? c_ltgray : c_white;

			draw_sprite_ext(
				_stct_beast._spr_beast,
				0,
				_val_beast_x,
				_val_beast_y,
				0.125,
				0.125,
				0,
				_c_beast,
				1
			);

			//--------//
			//DRAW HP//
			//--------//
			draw_set_font(fnt_gui_small);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_set_colour(c_black);

			var _str_hp = "";

			if (_flag_dead){
				_str_hp = "DEAD";
			}
			else{

				_str_hp =
					"HP: " +
					string(_ref_battle_beast._val_cur_hp) +
					"/" +
					string(_ref_battle_beast._val_max_hp);
			}

			var _val_text_x = _val_beast_x;
			var _val_text_y = _val_box_y + _val_slot_size + 15;

			draw_text(
				_val_text_x - (string_width(_str_hp) * 0.5),
				_val_text_y,
				_str_hp
			);

			//-----------//
			//DRAW LEVEL//
			//-----------//
			var _str_level =
				"Level: " +
				string(_stct_beast._val_beast_level);

			draw_text(
				_val_text_x - (string_width(_str_level) * 0.5),
				_val_text_y + 30,
				_str_level
			);
		}

		//---------//
		//CONFIRM//
		//---------//
		if (_flag_confirm_pressed){

			audio_play_sound(
				snd_gui_press,
				0,
				false
			);

			scr_market_register_battle_completion();

			//=================//
			//DEBUG BATTLE EXIT//
			//=================//
			scr_debug_log(
				"BATTLE",
				"EXIT",
				self,
				"BATTLE EXIT CONFIRMED | RESULT: WIN" +
				" | DESTINATION: " + room_get_name(global.rm_last_player) +
				" | POSITION: (" +
				string(round(global.val_last_player_x)) + "," +
				string(round(global.val_last_player_y)) + ")",
				"BATTLE",
				"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI"
			);

			var _ref_transition = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_fx",
				obj_transition
			);

			_ref_transition._rm_destination = global.rm_last_player;

			scr_gui_spawn_popup_banner(
				global.str_last_player_banner
			);

			obj_player.x = global.val_last_player_x;
			obj_player.y = global.val_last_player_y;

			scr_player_set_movement_state("START");

			obj_player.visible = true;
		}

	break;

	#endregion
}