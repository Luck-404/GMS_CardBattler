/////////////////////
// "ESC" ENDS GAME //
/////////////////////
if (keyboard_check_pressed(vk_escape)){
	game_end();	
}

///////////////////////////////
// KB "F" TOGGLES FULLSCREEN //
///////////////////////////////
if (keyboard_check_pressed(ord("F"))){
	_flag_fullscreen = !_flag_fullscreen;
	window_set_fullscreen(_flag_fullscreen);
}

/////////////////////
// OVERWORLD LOGIC //
/////////////////////
if (room == rm_overworld){
	visible = true; //MAKE VISIBLE IN OVERWORLD
	
	//////////////////////////
	// PICKING UP NEW CARDS //
	//////////////////////////
	if (keyboard_check_pressed(ord("E")) && place_meeting(x,y,obj_sparkly)){
		scr_generate_reward_card(1);
	}


	////////////////////
	// MOVEMENT LOGIC //
	////////////////////
	if (!_flag_moving) {
	        // Get tile layer and current tile at the target position
	        var _tile_layer = layer_tilemap_get_id("ts_overworld");
	        var _next_x = x, _next_y = y;

	        // Check input for movement using WASD keys
	        if (keyboard_check(ord("A"))) { // Move left
	            _next_x = x - 32;
	            image_xscale = -1; // Flip sprite to face left
	        } else if (keyboard_check(ord("D"))) { // Move right
	            _next_x = x + 32;
	            image_xscale = 1; // Face sprite to the right
	        } else if (keyboard_check(ord("W"))) { // Move up
	            _next_y = y - 32;
	        } else if (keyboard_check(ord("S"))) { // Move down
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
		instance_create_layer(x,y,"GUI",obj_deck_handler);
		show_debug_message("\n\n===CREATED DECK HANDLER===\n\n");		
		_flag_deck_created = true;
	}
	
	//spawn enemy units ONCE	
	if (_flag_party_spawned == false){
		show_debug_message("\n\n===STARTING CREATURE SPAWN===\n\n");				
		for (var _i = 0; _i < ds_list_size(global.player_team); _i++){
			show_debug_message("\ALLY TEAM INDEX " + string(_i));	
			show_debug_message("\nALLY TEAM SIZE " + string(ds_list_size(global.player_team)));						
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
			_ref_creature_instance._creature_hp_current = _ref_creature[? "hp"];
			_ref_creature_instance._creature_spec = _ref_creature[? "spec"];
			_ref_creature_instance._creature_class = _ref_creature[? "class"];
			_ref_creature_instance.sprite_index = _ref_creature[? "sprite"];
			_ref_creature_instance._creature_sprite = _ref_creature[? "sprite"];
			_ref_creature_instance._creature_hurtsound = _ref_creature[? "hurtsound"];
			_ref_creature_instance._creature_deathsound = _ref_creature[? "deathsound"];
			_ref_creature_instance._creature_defaultsound = _ref_creature[? "defaultsound"];
			
			show_debug_message("\nSPAWNED ALLY CREATURE " + string(_ref_creature[? "name"]));
			ds_list_add(global.player_team_in_play, _ref_creature_instance);
			_ref_creature_instance._creature_position = ds_list_find_index(global.player_team_in_play,_ref_creature_instance);
		}
		_flag_party_spawned = true;
			show_debug_message("\n\n===SPAWNED ENEMY TEAM OBJECT===\n\n");		
		var _enemy_team = instance_create_layer(960, 540, "GUI", obj_enemy_team); //generate the enemy team		
	}
}