//
//
// DRAW: OBJ_GUI_END_BATTLE_PANE | DRAW WIN TYPE AND REWARDS
//
//
switch(_condition){
	#region LOSS
	case "LOSS":
		//DRAW 'DEFEATED'
		draw_set_font(fnt_gui_large);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_colour(c_red);
		draw_text(room_width/2-(string_width("DEFEATED...")/2), 100,"DEFEATED...");
		
		draw_text(room_width/2-(string_width("YOU LIMP BACK TO THE RANCH")/2), 150,"YOU LIMP BACK TO THE RANCH");
		draw_set_colour(c_black);
		
		if (_flag_finished == false){
			_flag_finished = true;
			//UPDATE PLAYER'S UNIT HP- SET ALL TO 0
			for (var _i = 0; _i < ds_list_size(global.player_party); _i++){
				var _party_unit = ds_list_find_value(global.player_party,_i);
				_party_unit[?"beast_hp_cur"] = 0;
			}
		}
		
		//DISPLAY ALL PLAYER PARTY UNITS AND THEIR CUR/MAXHP
		#region PARTY DRAW IN PANE
		for (var _i = 0; _i < ds_list_size(global.player_party); _i++)
		{
		    var _box_x = _row_start_x + ((_slot_size + _spacing) * _i);
		    var _box_y = _row_y;

		    var _unit = ds_list_find_value(global.player_party, _i);

		    // Outline
		    draw_set_colour(c_black);
		    draw_rectangle(_box_x, _box_y,_box_x + _slot_size,_box_y + _slot_size,false);

		    // Fill
		    draw_set_colour(c_gray);
		    draw_rectangle(_box_x + 5,_box_y + 5,_box_x + 95,_box_y + 95,false);

		    // Center
		    var _unit_x = _box_x + (_slot_size * 0.5);
		    var _unit_y = _box_y + (_slot_size * 0.5);

		    // Shadow
		    var _shadow = scr_get_beast_type_shadow(_unit[?"beast_color_type"]);
		    draw_sprite_ext(_shadow, 0, _unit_x, _unit_y + 25, 1, 1, 0, c_white, 1);

		    // Unit
		    draw_sprite_ext(_unit[?"beast_sprite"],0,_unit_x,_unit_y,0.125,0.125,0,c_white,1);
			#endregion
			
		    // HP
			draw_set_font(fnt_gui_large);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_set_colour(c_black);			
			var _hp_string = "HP: " + string(_unit[?"beast_hp_cur"] + "/" + string(_unit[?"beast_hp_max"]));
			var _text_x = _unit_x;
			var _text_y = _box_y + (_slot_size) + 15;
		    draw_text(_text_x-(string_width(_hp_string)/2),_text_y,_hp_string);
			#endregion			
		}
		
		
		//WAIT FOR CLICK ON OBJ_END_CONFIRM
		if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x,mouse_y,obj_battle_button_end_battle_confirm)){
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
			obj_player._player_speed = 3;
			obj_player.visible = true;		
		}
	break;
	#endregion
	
	#region WIN
	case "WIN":
		//DRAW 'DEFEATED'
		draw_set_font(fnt_gui_large);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_colour(c_black);
		draw_text(room_width/2-(string_width("YOU WON!")/2), 100,"YOU WON!");
		
		draw_text(room_width/2-(string_width("REWARDS:")/2), 150,"REWARDS:");
		draw_set_colour(c_black);
		
		if (_flag_finished == false){
			_flag_finished = true;
			//AWARD GP
			global.player_gold += 25;
			
			//AWARD 3 RANDOM CARDS
			for (var _i = 0; _i < 3; _i++){
				randomize();
				var _pool = choose(global.rarity_I_cards,global.rarity_I_cards,global.rarity_I_cards,global.rarity_I_cards,global.rarity_I_cards,global.rarity_I_cards,global.rarity_II_cards,global.rarity_II_cards,global.rarity_II_cards,global.rarity_III_cards);
				var _card_roll = irandom_range(0,ds_list_size(_pool)-1);
				var _card_name = ds_list_find_value(_pool,_card_roll);
				var _new_card = scr_get_card_info(_card_name);
				scr_add_card_to_deck(_new_card);
			}
			
			//UPDATE PLAYER'S UNIT HP AND EXP
			for (var _i = 0; _i < ds_list_size(global.player_party); _i++){
				var _party_unit = ds_list_find_value(global.player_party,_i);
				var _battle_unit = ds_list_find_value(obj_battle_player_controller._beasts_list,_i);
				
				_party_unit[?"beast_hp_cur"] = _battle_unit._cur_hp;
				var _cur_exp = _party_unit[?"beast_exp"];
				if (_cur_exp+2 >= 10){
					_party_unit[?"beast_level"]++;
					_party_unit[?"beast_exp"] += 2;
					_party_unit[?"beast_exp"] -= 10;
				} else {
					_party_unit[?"beast_exp"] +=2;
				}
			}
		}
		
		//DISPLAY ALL PLAYER PARTY UNITS AND THEIR CUR/MAXHP
		#region PARTY DRAW IN PANE
		for (var _i = 0; _i < ds_list_size(global.player_party); _i++)
		{
		    var _box_x = _row_start_x + ((_slot_size + _spacing) * _i);
		    var _box_y = _row_y;

		    var _unit = ds_list_find_value(global.player_party, _i);

		    // Outline
		    draw_set_colour(c_black);
		    draw_rectangle(_box_x, _box_y,_box_x + _slot_size,_box_y + _slot_size,false);

		    // Fill
		    draw_set_colour(c_gray);
		    draw_rectangle(_box_x + 5,_box_y + 5,_box_x + 95,_box_y + 95,false);

		    // Center
		    var _unit_x = _box_x + (_slot_size * 0.5);
		    var _unit_y = _box_y + (_slot_size * 0.5);

		    // Shadow
		    var _shadow = scr_get_beast_type_shadow(_unit[?"beast_color_type"]);
		    draw_sprite_ext(_shadow, 0, _unit_x, _unit_y + 25, 1, 1, 0, c_white, 1);

		    // Unit
		    draw_sprite_ext(_unit[?"beast_sprite"],0,_unit_x,_unit_y,0.125,0.125,0,c_white,1);
			#endregion
			
		    // HP
			draw_set_font(fnt_gui_large);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_set_colour(c_black);			
			var _hp_string = "HP: " + string(_unit[?"beast_hp_cur"] + "/" + string(_unit[?"beast_hp_max"]));
			var _text_x = _unit_x;
			var _text_y = _box_y + (_slot_size) + 15;
		    draw_text(_text_x-(string_width(_hp_string)/2),_text_y,_hp_string);	
			//level
		    draw_text(_text_x-(string_width(string("Level: " + _unit[?"beast_level"]))/2),_text_y+30,"Level: " + _unit[?"beast_level"]);					
			#endregion			
		}
		
		
		//WAIT FOR CLICK ON OBJ_END_CONFIRM
		if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x,mouse_y,obj_battle_button_end_battle_confirm)){
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
			obj_player._player_speed = 3;
			obj_player.visible = true;		
		}
	break;
	#endregion
}