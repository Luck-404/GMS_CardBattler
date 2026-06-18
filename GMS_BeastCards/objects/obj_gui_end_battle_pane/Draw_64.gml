//
//
// DRAW: OBJ_GUI_END_BATTLE_PANE | DRAW WIN TYPE AND REWARDS
//
//
switch(_condition){
	#region LOSS
	case "LOSS":
		//DRAW 'DEFEATED'
		draw_set_font(fnt_large_gui);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_colour(c_red);
		draw_text(room_width/2-(string_width("DEFEATED...")/2), room_height/2-75,"DEFEATED...");
		
		draw_text(room_width/2-(string_width("YOU LIMP BACK TO THE RANCH")/2), room_height/2,"YOU LIMP BACK TO THE RANCH");
		draw_set_colour(c_black);
		
		#region ONCE
		if (_flag_finished == false){
			_flag_finished = true;
			//UPDATE PLAYER'S UNIT HP- SET ALL TO 0
			for (var _i = 0; _i < ds_list_size(global.player_party); _i++){
				var _party_unit = ds_list_find_value(global.player_party,_i);
				_party_unit[?"beast_hp_cur"] = 0;
			}
		}
		#endregion
		
		//DISPLAY ALL PLAYER PARTY UNITS AND THEIR CUR/MAXHP
		#region PARTY DRAW IN PANE
			var _display_index = 0;

			for (var _i = 0; _i < ds_list_size(global.player_party); _i++)
			{
			    var _unit = ds_list_find_value(global.player_party, _i);

			    var _battle_unit = noone;

			    for (var _j = 0; _j < ds_list_size(obj_battle_player_controller._beasts_list); _j++)
			    {
			        var _b = ds_list_find_value(obj_battle_player_controller._beasts_list, _j);

			        if (_b._uid == _unit[?"beast_uid"])
			        {
			            _battle_unit = _b;
			            break;
			        }
			    }

			    var _is_present_in_battle = instance_exists(_battle_unit);

			    if (!_is_present_in_battle) continue;

			    //----------------------------------------------------
			    // CRITICAL FIX: DEFINE DEAD STATE
			    //----------------------------------------------------
			    var _is_dead = (_battle_unit._cur_hp <= 0);

			    var _box_x = _row_start_x + ((_slot_size + _spacing) * _display_index);
			    var _box_y = _row_y;

			    _display_index++;

			    //----------------------------------------------------
			    // OUTLINE
			    //----------------------------------------------------
			    draw_set_colour(c_black);
			    draw_rectangle(_box_x, _box_y, _box_x + _slot_size, _box_y + _slot_size, false);

			    //----------------------------------------------------
			    // BACKGROUND
			    //----------------------------------------------------
			    draw_set_colour(_is_dead ? c_maroon : c_gray);

			    draw_rectangle(
			        _box_x + 5,
			        _box_y + 5,
			        _box_x + 95,
			        _box_y + 95,
			        false
			    );

			    //----------------------------------------------------
			    // CENTER
			    //----------------------------------------------------
			    var _unit_x = _box_x + (_slot_size * 0.5);
			    var _unit_y = _box_y + (_slot_size * 0.5);

			    //----------------------------------------------------
			    // SHADOW
			    //----------------------------------------------------
			    var _shadow = scr_get_beast_type_shadow(_unit[?"beast_color_type"]);
			    draw_sprite_ext(_shadow, 0, _unit_x, _unit_y + 25, 1, 1, 0, c_white, 1);

			    //----------------------------------------------------
			    // SPRITE
			    //----------------------------------------------------
			    var _col = _is_dead ? c_ltgray : c_white;

			    draw_sprite_ext(
			        _unit[?"beast_sprite"],
			        0,
			        _unit_x,
			        _unit_y,
			        0.125,
			        0.125,
			        0,
			        _col,
			        1
			    );

			    //----------------------------------------------------
			    // HP TEXT
			    //----------------------------------------------------
			    draw_set_font(fnt_small_gui);
			    draw_set_halign(fa_left);
			    draw_set_valign(fa_top);
			    draw_set_colour(c_black);

			    var _hp_string;

			    if (_is_dead)
			    {
			        _hp_string = "DEAD";
			    }
			    else
			    {
			        _hp_string = "HP: "
			            + string(_battle_unit._cur_hp)
			            + "/"
			            + string(_battle_unit._max_hp);
			    }

			    var _text_x = _unit_x;
			    var _text_y = _box_y + (_slot_size) + 15;

			    draw_text(_text_x - (string_width(_hp_string) / 2), _text_y, _hp_string);
			}
			#endregion			
		
		
		//WAIT FOR CLICK ON OBJ_END_CONFIRM
		if (mouse_check_button_pressed(mb_left) && position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_gui_end_battle_confirm_button)){
			//TRANSITION BACK TO RANCH ROOM WITH A STORED POSITION:	
			//SPAWN NEW TRANSITION
			var _transition = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_transition);
			_transition._destination = rm_ow_ranch;			
			
			//SPAWN ANNOUNCEMENT BANNER
			scr_spawn_popup_banner("RANCH ROOM");
	
			//PLAYER COORDS
			obj_player.x = 530; //x
			obj_player.y = 980; //y
			
			//PLAYER IS ABLE AGAIN
			scr_toggle_player_movement("START");
			obj_player.visible = true;		
		}
	break;
	#endregion
	
	
	
	
	
	
	#region WIN
	case "WIN":
		//DRAW 'WIN'
		draw_set_font(fnt_large_gui);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_colour(c_black);
		draw_text(room_width/2-(string_width("YOU WON!")/2), 150,"YOU WON!");
		
		draw_text(room_width/2-(string_width("REWARDS:")/2), 200,"REWARDS:");
		draw_set_colour(c_black);
		
		#region ONCE
		if (_flag_finished == false){
			_flag_finished = true;
			//AWARD GP
			var _gold_reward = irandom_range(25,100);
			global.player_gold += _gold_reward;
			array_push(_rewards_list, ["GOLD", _gold_reward]);
			
			//AWARD 3 RANDOM CARDS OR ITEMS
			for (var _i = 0; _i < 3; _i++){
				var _rew = choose("ITEM","CARD");	
				if (_rew == "CARD"){
					var _pool = choose(global.rarity_I_cards,global.rarity_I_cards,global.rarity_I_cards,global.rarity_I_cards,global.rarity_I_cards,global.rarity_I_cards,global.rarity_II_cards,global.rarity_II_cards,global.rarity_II_cards,global.rarity_III_cards);
					var _card_roll = irandom_range(0,ds_list_size(_pool)-1);
					var _card_name = ds_list_find_value(_pool,_card_roll);
					var _new_card = scr_get_card_info(_card_name)
					scr_add_card_to_deck(_new_card);		
					show_debug_message("RANDOM BATTLE REWARD + " + _card_name);
					array_push(_rewards_list, ["CARD", _new_card]);	
				}
				else {
					var _new_item = scr_get_random_item(global.item_pool);
					show_debug_message("RANDOM BATTLE REWARD + " + _new_item);
					var _fake_item = scr_get_item_info(_new_item);
					scr_add_item_to_inventory(_new_item,1);
					array_push(_rewards_list, ["ITEM", _fake_item]);	
				}				
			}	

		
			
			
			
			//UPDATE PLAYER'S UNIT HP AND EXP
			for (var _i = 0; _i < ds_list_size(global.player_party); _i++){
				var _party_unit = ds_list_find_value(global.player_party,_i);
				var _battle_unit = noone;

				for (var _j = 0; _j < ds_list_size(obj_battle_player_controller._beasts_list); _j++)
				{
				    var _b = ds_list_find_value(obj_battle_player_controller._beasts_list, _j);

				    if (_b._uid == _party_unit[?"beast_uid"])
				    {
				        _battle_unit = _b;
				        break;
				    }
				}
				
				if (instance_exists(_battle_unit))
				{
				    _party_unit[?"beast_hp_cur"] = _battle_unit._cur_hp;
				}

				var _cur_exp = _party_unit[?"beast_exp"];
				if (_party_unit[?"beast_hp_cur"] > 0)
				{
				    _party_unit[?"beast_exp"] += 2;

				    while (_party_unit[?"beast_exp"] >= 10)
				    {
				        _party_unit[?"beast_exp"] -= 10;
				        scr_level_up_beast(_party_unit);
				    }
				}
			}
			array_push(_rewards_list, ["EXP", 2]);
		}
		#endregion
		//
		// DRAW REWARDS
		//
		#region REWARDS
		draw_set_font(fnt_small_gui);
		draw_set_colour(c_black);

		var _reward_x = room_width * 0.5;
		var _reward_y = room_width/2-150;

		//
		// CARDS FIRST
		//
		var _card_x = room_width * 0.5 - 150;
		var _card_y = _reward_y;

		for (var _i = 0; _i < array_length(_rewards_list); _i++)
		{
			if (_rewards_list[_i][0] == "CARD")
			{
			    var _card = _rewards_list[_i][1];

			    draw_sprite_ext(
			        _card[?"card_sprite"],
			        0,
			        _card_x,
			        _card_y,
			        0.2,
			        0.2,
			        0,
			        c_white,
			        1
			    );

			    draw_set_halign(fa_center);

			    draw_text(
			        _card_x,
			        _card_y + 60,
			        string(_card[?"card_name"])
			    );

			    draw_set_halign(fa_left);

			    _card_x += 150;
			}
			else if (_rewards_list[_i][0] == "ITEM")
			{
			    var _item = _rewards_list[_i][1];

			    draw_sprite_ext(
			        _item[?"item_sprite"],
			        0,
			        _card_x,
			        _card_y,
			        2,
			        2,
			        0,
			        c_white,
			        1
			    );

			    draw_set_halign(fa_center);

			    draw_text(
			        _card_x,
			        _card_y + 60,
			        string(_item[?"item_name"])
			    );

			    draw_set_halign(fa_left);

			    _card_x += 150;
			}			
		}

		_reward_y += 90;

		//
		// GOLD SECOND
		//
		for (var _i = 0; _i < array_length(_rewards_list); _i++)
		{
		    if (_rewards_list[_i][0] == "GOLD")
		    {
		        draw_text(
		            _reward_x - 100,
		            _reward_y,
		            "Gained " + string(_rewards_list[_i][1]) + " Gold"
		        );

		        _reward_y += 30;
		    }
		}

		//
		// EXP LAST
		//
		for (var _i = 0; _i < array_length(_rewards_list); _i++)
		{
		    if (_rewards_list[_i][0] == "EXP")
		    {
		        draw_text(
		            _reward_x - 100,
		            _reward_y,
		            "Each Beast Gained " + string(_rewards_list[_i][1]) + " EXP"
		        );

		        _reward_y += 30;
		    }
		}
		#endregion
		
		#region PARTY DRAW IN PANE
			var _display_index = 0;

			for (var _i = 0; _i < ds_list_size(global.player_party); _i++)
			{
			    var _unit = ds_list_find_value(global.player_party, _i);

			    var _battle_unit = noone;

			    for (var _j = 0; _j < ds_list_size(obj_battle_player_controller._beasts_list); _j++)
			    {
			        var _b = ds_list_find_value(obj_battle_player_controller._beasts_list, _j);

			        if (_b._uid == _unit[?"beast_uid"])
			        {
			            _battle_unit = _b;
			            break;
			        }
			    }

			    var _is_present_in_battle = instance_exists(_battle_unit);

			    if (!_is_present_in_battle) continue;

			    //----------------------------------------------------
			    // CRITICAL FIX: DEFINE DEAD STATE
			    //----------------------------------------------------
			    var _is_dead = (_battle_unit._cur_hp <= 0);

			    var _box_x = _row_start_x + ((_slot_size + _spacing) * _display_index);
			    var _box_y = _row_y;

			    _display_index++;

			    //----------------------------------------------------
			    // OUTLINE
			    //----------------------------------------------------
			    draw_set_colour(c_black);
			    draw_rectangle(_box_x, _box_y, _box_x + _slot_size, _box_y + _slot_size, false);

			    //----------------------------------------------------
			    // BACKGROUND
			    //----------------------------------------------------
			    draw_set_colour(_is_dead ? c_maroon : c_gray);

			    draw_rectangle(
			        _box_x + 5,
			        _box_y + 5,
			        _box_x + 95,
			        _box_y + 95,
			        false
			    );

			    //----------------------------------------------------
			    // CENTER
			    //----------------------------------------------------
			    var _unit_x = _box_x + (_slot_size * 0.5);
			    var _unit_y = _box_y + (_slot_size * 0.5);

			    //----------------------------------------------------
			    // SHADOW
			    //----------------------------------------------------
			    var _shadow = scr_get_beast_type_shadow(_unit[?"beast_color_type"]);
			    draw_sprite_ext(_shadow, 0, _unit_x, _unit_y + 25, 1, 1, 0, c_white, 1);

			    //----------------------------------------------------
			    // SPRITE
			    //----------------------------------------------------
			    var _col = _is_dead ? c_ltgray : c_white;

			    draw_sprite_ext(
			        _unit[?"beast_sprite"],
			        0,
			        _unit_x,
			        _unit_y,
			        0.125,
			        0.125,
			        0,
			        _col,
			        1
			    );

			    //----------------------------------------------------
			    // HP TEXT
			    //----------------------------------------------------
			    draw_set_font(fnt_small_gui);
			    draw_set_halign(fa_left);
			    draw_set_valign(fa_top);
			    draw_set_colour(c_black);

			    var _hp_string;

			    if (_is_dead)
			    {
			        _hp_string = "DEAD";
			    }
			    else
			    {
			        _hp_string = "HP: "
			            + string(_battle_unit._cur_hp)
			            + "/"
			            + string(_battle_unit._max_hp);
			    }

			    var _text_x = _unit_x;
			    var _text_y = _box_y + (_slot_size) + 15;

			    draw_text(_text_x - (string_width(_hp_string) / 2), _text_y, _hp_string);

			    draw_text(
			        _text_x - (string_width("Level: " + string(_unit[?"beast_level"])) / 2),
			        _text_y + 30,
			        "Level: " + string(_unit[?"beast_level"])
			    );

		}
		#endregion
		
		//WAIT FOR CLICK ON OBJ_END_CONFIRM
		if (mouse_check_button_pressed(mb_left) && position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_gui_end_battle_confirm_button)){
			//TRANSITION BACK TO RANCH ROOM WITH A STORED POSITION:	
			//SPAWN NEW TRANSITION
			var _transition = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_transition);
			_transition._destination = global.last_player_rm;			
			
			//SPAWN ANNOUNCEMENT BANNER
			scr_spawn_popup_banner(global.last_player_banner);
	
			//PLAYER COORDS
			obj_player.x = global.last_player_x; //x
			obj_player.y = global.last_player_y; //y
			
			//PLAYER IS ABLE AGAIN
			scr_toggle_player_movement("START");
			obj_player.visible = true;		
		}
	break;
	#endregion
}