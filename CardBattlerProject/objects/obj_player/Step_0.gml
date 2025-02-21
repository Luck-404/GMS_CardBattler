//////////////////////////////////////////////////////////////////////
//							OBJ_PLAYER STEP							//
//																	//
// > HANDLE VARIOUS LOGIC FOR THE PLAYER CHARACTER		//
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////
// spawn leaves, trigger transition //
//////////////////////////////////////
//var _grass_layer = layer_tilemap_get_id("tl_grass");
//var _tree_layer = layer_tilemap_get_id("tl_trees");
//var _foliage_layer = layer_tilemap_get_id("tl_foliage");
//if ((tilemap_get_at_pixel(_grass_layer, x, y) != 0) && _flag_can_touch == true) {
//	_flag_can_touch = false;
//	scr_spawn_leaves();
//	//if (global.can_encounter == true){
//	//	var _rand = irandom_range(1,100);
//	//	if (_rand <= 50 && _flag_transition_start == false){
//	//		_flag_transition_start = true;		
			
//	//		//save the current room, tileset, and position of player
//	//		_tileset = layer_tilemap_get_id("tl_overworld");
//	//		global.saved_ts = tilemap_get_tileset(_tileset);
//	//		global.saved_room = room;
//	//		global.player_xpos = obj_player.x;
//	//		global.player_ypos = obj_player.y;
			
//	//		obj_player._move_speed = 0;				
//	//		//scr_start_transition(rm_encounter);
//	//		room_goto(rm_encounter);
//	//	}
//	//}
//}

//if (tilemap_get_at_pixel(_tree_layer, x, y) != 0) {
//	if (_flag_can_touch == true){
//		_flag_can_touch = false;
//		scr_spawn_cone();
//	}
//}

//if (tilemap_get_at_pixel(_foliage_layer, x, y) != 0) {
//	if (_flag_can_touch == true){
//		_flag_can_touch = false;
//		scr_spawn_leaves();
//	}
//}



/////////////////////
// "ESC" ENDS GAME //
/////////////////////
if (global.graveyard_gui_open == false && global.merc_shop_gui_open == false && global.card_shop_gui_open == false && global.healer_shop_gui_open == false && keyboard_check_pressed(vk_f1)){
	show_debug_message("|=== PLAYER: ENDING GAME VIA 'F1' ===|");		
	game_end();	
}

////////////////////
// R to encounter //
////////////////////
if (_flag_transition_start == false && (keyboard_check(ord("R")) == true)){
	global.saved_room = room;
	global.player_xpos = x;
	global.player_ypos = y;
	room_goto(rm_encounter);
}

////////////////
// F4 to SAVE //
////////////////
if (_flag_transition_start == false && (keyboard_check(vk_f4) == true)){
	scr_save();
}

/////////////////////
// SHIFT TO SPRINT //
/////////////////////
if (_flag_transition_start == false && (keyboard_check(vk_lshift) == true)){
	_move_speed = 4;
} else if (_flag_transition_start == false) {
	_move_speed = 3;	
}

/////////////////////////////////
//// KB "F" TOGGLES FULLSCREEN //
/////////////////////////////////
//if (keyboard_check_pressed(ord("F"))){
//	show_debug_message("|=== PLAYER: TOGGLING FULLSCREEN ===|");		
//	_flag_fullscreen = !_flag_fullscreen;
//	window_set_fullscreen(_flag_fullscreen);
//}

/////////////////////
// OVERWORLD LOGIC //
/////////////////////
if (room != rm_encounter){
	visible = true; //MAKE VISIBLE IN OVERWORLD
	
	//////////////////////////
	// PICKING UP NEW CARDS //
	//////////////////////////
	if (keyboard_check_pressed(ord("E")) && distance_to_object(obj_treasure) < 48){
		obj_treasure._flag_interacted = true;
		show_debug_message("|=== PLAYER: PRESSED 'E' ON A TREASURE! ===|");		
		scr_generate_reward_card(1);
	}


////////////////////
// MOVEMENT LOGIC //
////////////////////
	if (!_flag_moving) {
	    image_speed = 0;
	    image_index = 0;
    
	    // Get tile layers
	    var _tile_layer = layer_tilemap_get_id("tl_overworld");
	    var _wall_layer = layer_tilemap_get_id("tl_walls");
	    var _one_way_layer = layer_tilemap_get_id("tl_oneway");
    
	    // Movement inputs
	    var _move_left  = keyboard_check(ord("A"));
	    var _move_right = keyboard_check(ord("D"));
	    var _move_up    = keyboard_check(ord("W"));
	    var _move_down  = keyboard_check(ord("S"));

	    // Determine movement direction
	    var _next_x = x;
	    var _next_y = y;
	    var _facing_front = true; // Tracks whether to use front-facing sprite
	    var _flip = 1; // Tracks xscale

	    // Direction tracking variables for the hop
	    _hop_dx = 0;
	    _hop_dy = 0;

	    if (_move_up && _move_left) {
	        _hop_dx = -32;
	        _hop_dy = -32;
	        _facing_front = false;
	        _flip = -1;
	    } else if (_move_up && _move_right) {
	        _hop_dx = 32;
	        _hop_dy = -32;
	        _facing_front = false;
	    } else if (_move_down && _move_left) {
	        _hop_dx = -32;
	        _hop_dy = 32;
	        _flip = -1;
	    } else if (_move_down && _move_right) {
	        _hop_dx = 32;
	        _hop_dy = 32;
	    } else if (_move_left) {
	        _hop_dx = -32;
	        _flip = -1;
	    } else if (_move_right) {
	        _hop_dx = 32;
	    } else if (_move_up) {
	        _hop_dy = -32;
	        _facing_front = false;
	    } else if (_move_down) {
	        _hop_dy = 32;
	    }

	    _next_x += _hop_dx;
	    _next_y += _hop_dy;

	    // Apply movement and sprite settings
	    if (_hop_dx != 0 || _hop_dy != 0) {
	        image_speed = 1;
	        image_xscale = _flip;
	        sprite_index = _facing_front ? spr_player_front : spr_player_back;
	    }

	    // Check if a tile exists at the target position
	    if (tilemap_get_at_pixel(_tile_layer, _next_x, _next_y) != 0) {
	        if (tilemap_get_at_pixel(_wall_layer, _next_x, _next_y) != 0) {
	            show_debug_message("Wall here");    
	        } else if ((tilemap_get_at_pixel(_one_way_layer, _next_x, _next_y) != 0)) {
			    var _tile_index = tilemap_get_at_pixel(_one_way_layer, _next_x, _next_y);
    
			    if (scr_check_one_way_hop(_tile_index, _next_x, _next_y, x, y)) {
			        _target_x = _next_x;
			        _target_y = _next_y;
			        _flag_moving = true; // Start moving
			        _hop_start = true;
					_hop_offset = 8;
			    } else {
			        show_debug_message("Blocked! Cannot enter from this direction.");
			    }
			} else {
	            _target_x = _next_x;
	            _target_y = _next_y;
	            _flag_moving = true; // Start moving
	            _hop_start = false;                
	        }
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
			y-= _hop_offset;
			_hop_offset = 0;
	        if (_hop_start) {
	            _hop_start = false;
				y += _hop_offset;
	            _target_x += _hop_dx; // Move one more step in the same direction
	            _target_y += _hop_dy;
	            _flag_moving = true; // Trigger hop movement
	        }
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