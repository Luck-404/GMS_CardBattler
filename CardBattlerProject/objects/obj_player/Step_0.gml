//////////////////////////////////////
// spawn leaves, trigger transition //
//////////////////////////////////////
if (place_meeting(x, y, obj_grass) && _flag_can_touch == true) {
	_flag_can_touch = false;
	scr_spawn_leaves();
	if (global.can_encounter == true){
		var _rand = irandom_range(1,100);
		if (_rand <= 50 && _flag_transition_start == false){
			_flag_transition_start = true;		
			
			//save the current room, tileset, and position of player
			_tileset = layer_tilemap_get_id("ts_overworld");
			global.saved_ts = tilemap_get_tileset(_tileset);
			global.saved_room = room;
			global.player_xpos = obj_player.x;
			global.player_ypos = obj_player.y;
			
			obj_player._move_speed = 0;				
			scr_start_transition(rm_encounter);
		}
	}
}

if (place_meeting(x, y, obj_tree)) {
	if (_flag_can_touch == true){
		_flag_can_touch = false;
		scr_spawn_cone();
	}
}



/////////////////////
// "ESC" ENDS GAME //
/////////////////////
if (global.graveyard_gui_open == false && global.merc_shop_gui_open == false && global.card_shop_gui_open == false && global.healer_shop_gui_open == false && keyboard_check_pressed(vk_escape)){
	show_debug_message("|=== PLAYER: ENDING GAME VIA 'ESC' ===|");		
	game_end();	
}

///////////////////////////////
// KB "F" TOGGLES FULLSCREEN //
///////////////////////////////
if (keyboard_check_pressed(ord("F"))){
	show_debug_message("|=== PLAYER: TOGGLING FULLSCREEN ===|");		
	_flag_fullscreen = !_flag_fullscreen;
	window_set_fullscreen(_flag_fullscreen);
}

/////////////////////
// OVERWORLD LOGIC //
/////////////////////
if (room != rm_encounter){
	visible = true; //MAKE VISIBLE IN OVERWORLD
	
	//////////////////////////
	// PICKING UP NEW CARDS //
	//////////////////////////
	if (keyboard_check_pressed(ord("E")) && place_meeting(x,y,obj_treasure)){
		obj_treasure._flag_interacted = true;
		show_debug_message("|=== PLAYER: PRESSED 'E' ON A TREASURE! ===|");		
		scr_generate_reward_card(1);
	}


	////////////////////
	// MOVEMENT LOGIC //
	////////////////////
	if (!_flag_moving) {
	    // Get tile layer and current tile at the target position
	    var _tile_layer = layer_tilemap_get_id("ts_overworld");
	    var _next_x = x, _next_y = y;

	    // Check input for movement using WASD or arrow keys for 8 directions
	    var _move_left  = keyboard_check(ord("A"));
	    var _move_right = keyboard_check(ord("D"));
	    var _move_up    = keyboard_check(ord("W"));
	    var _move_down  = keyboard_check(ord("S"));

	    // Determine movement direction
	    if (_move_up && _move_left) { // Move up-left
	        _next_x = x - 32;
	        _next_y = y - 32;
	        image_xscale = -1;
	    } else if (_move_up && _move_right) { // Move up-right
	        _next_x = x + 32;
	        _next_y = y - 32;
	        image_xscale = 1;
	    } else if (_move_down && _move_left) { // Move down-left
	        _next_x = x - 32;
	        _next_y = y + 32;
	        image_xscale = -1;
	    } else if (_move_down && _move_right) { // Move down-right
	        _next_x = x + 32;
	        _next_y = y + 32;
	        image_xscale = 1;
	    } else if (_move_left) { // Move left
	        _next_x = x - 32;
	        image_xscale = -1;
	    } else if (_move_right) { // Move right
	        _next_x = x + 32;
	        image_xscale = 1;
	    } else if (_move_up) { // Move up
	        _next_y = y - 32;
	    } else if (_move_down) { // Move down
	        _next_y = y + 32;
	    }

	    // Check if a tile exists at the target position
	    if (tilemap_get_at_pixel(_tile_layer, _next_x, _next_y) != 0) {
	        _target_x = _next_x;
	        _target_y = _next_y;
	        _flag_moving = true; // Start moving			
	    }
	}

	// Smooth movement to the target position
	if (_flag_moving) {
	    if (x < _target_x) x = min(x + _move_speed, _target_x);
	    if (x > _target_x) x = max(x - _move_speed, _target_x);
	    if (y < _target_y) y = min(y + _move_speed, _target_y);
	    if (y > _target_y) y = max(y - _move_speed, _target_y);

	    // Stop moving when the target position is reached
	    if (x == _target_x && y == _target_y) {
	        _flag_moving = false;
	    }
	}
}

////////////////////
// ENCOUNTER ROOM //
////////////////////
if (room == rm_encounter){
	if (_flag_deck_created == false){ //CREATE THE DECK
		show_debug_message("|=== PLAYER: ENTERED ENCOUNTER, GENERATING DECK_HANDLER... ===|");			
		instance_create_layer(x,y,"GUI",obj_deck_handler);
		show_debug_message("|=== PLAYER: GENERATED DECK_HANDLER! ===|");				
		_flag_deck_created = true;
	}
	
	//spawn enemy units ONCE	
	if (_flag_party_spawned == false){
		show_debug_message("|=== PLAYER: SPAWNING PLAYER TEAM OF SIZE " + string(ds_list_size(global.player_team)) + "... ===|");				
		for (var _i = 0; _i < ds_list_size(global.player_team); _i++){					
			//spawn the creature
			var _ref_creature = ds_list_find_value(global.player_team, _i);
			var _ref_creature_instance = instance_create_layer(750-(170*_i), 650, "Creatures", obj_creature); //generate the creature	
			//pass the creature the proper stats it needs
			_ref_creature_instance._creature_name = _ref_creature[? "name"];
			_ref_creature_instance._creature_champion = _ref_creature[? "champion"];
			_ref_creature_instance._creature_color1 = _ref_creature[? "color1"];
			_ref_creature_instance._creature_color2 = _ref_creature[? "color2"];
			_ref_creature_instance._creature_subtype = _ref_creature[? "subtype"];
			_ref_creature_instance._creature_team = _ref_creature[? "team"];
			_ref_creature_instance._creature_breed = _ref_creature[? "breed"];
			_ref_creature_instance._creature_hp_max = _ref_creature[? "hp"];
			_ref_creature_instance._creature_hp_current = _ref_creature[? "curhp"];
			_ref_creature_instance._creature_spec = _ref_creature[? "spec"];
			_ref_creature_instance._creature_class = _ref_creature[? "class"];
			_ref_creature_instance.sprite_index = _ref_creature[? "sprite"];
			_ref_creature_instance._creature_sprite = _ref_creature[? "sprite"];
			_ref_creature_instance._creature_hurtsound = _ref_creature[? "hurtsound"];
			_ref_creature_instance._creature_deathsound = _ref_creature[? "deathsound"];
			_ref_creature_instance._creature_defaultsound = _ref_creature[? "defaultsound"];
			
			show_debug_message("|=== PLAYER: SPAWNED ALLY CREATURE " + string(_ref_creature[? "name"])+ "! ===|");
			ds_list_add(global.player_team_in_play, _ref_creature_instance);
			_ref_creature_instance._creature_position = ds_list_find_index(global.player_team_in_play,_ref_creature_instance);
		}
		_flag_party_spawned = true;
		show_debug_message("|=== PLAYER: SPAWNED WHOLE ALLY TEAM! ===|");	
		
		show_debug_message("|=== PLAYER: SPAWNING ENEMY TEAM... ===|");			
		var _enemy_team = instance_create_layer(960, 540, "GUI", obj_enemy_team); //generate the enemy team		
		show_debug_message("|=== PLAYER: SPAWNED ENEMY TEAM! ===|");				
	}
}