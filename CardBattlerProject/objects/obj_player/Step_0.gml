//////////////////////////////////////////////////////////////////////
//							OBJ_PLAYER STEP							//
//																	//
// > HANDLE VARIOUS LOGIC FOR THE PLAYER CHARACTER					//
//////////////////////////////////////////////////////////////////////
if (room != rm_encounter){
// Get tile layers
var _grass_layer = layer_tilemap_get_id("tl_grass");
var _foliage_layer = layer_tilemap_get_id("tl_foliage");
var _tile_layer = layer_tilemap_get_id("tl_overworld");
var _wall_layer = layer_tilemap_get_id("tl_walls");
var _one_way_layer = layer_tilemap_get_id("tl_oneway");

//////////////////////////
// PLAYER STATE MACHINE //
//////////////////////////
switch (global.player_ow_state){
#region IDLE
case PLAYER_OW_STATE.IDLE: //wait for player input (movement, interactions with NPCs/Treasures)
	image_speed = 0;
	image_index = 0;
	////////////////////
	// R to encounter //
	////////////////////
	if (room != rm_encounter && _flag_transition_start == false && (keyboard_check(ord("R")) == true)){
		_flag_transition_start = true;
		global.step_count = 0;
		scr_transition("encounter","Any","Any","Any");
	}

	/////////////////////
	// SHIFT TO SPRINT //
	/////////////////////
	if (room != rm_encounter && _flag_transition_start == false && (keyboard_check(vk_lshift) == true)){
		_move_speed = 8;
	} else if (room != rm_encounter && _flag_transition_start == false) {
		_move_speed = 4;	
	}
	
	//NPC gui- hosted in-object
	//Treasures- hosted in-object
	
	////////////////////
	// MOVEMENT INPUT //
	////////////////////
	// Movement inputs
	_move_left  = keyboard_check(ord("A"));
	_move_right = keyboard_check(ord("D"));
	_move_up    = keyboard_check(ord("W"));
	_move_down  = keyboard_check(ord("S"));	
	
	if (_move_left != 0 || _move_right != 0 || _move_up != 0 || _move_down != 0){
		global.player_ow_state = PLAYER_OW_STATE.MOVE_CHECK;
	}
break;
#endregion

#region MOVE CHECK
case PLAYER_OW_STATE.MOVE_CHECK: //check if player can move (collision detect)
		_move_left  = keyboard_check(ord("A"));
		_move_right = keyboard_check(ord("D"));
		_move_up    = keyboard_check(ord("W"));
		_move_down  = keyboard_check(ord("S"));	
		
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
	            //wall
	        } else if ((tilemap_get_at_pixel(_one_way_layer, _next_x, _next_y) != 0)) {
			    var _tile_index = tilemap_get_at_pixel(_one_way_layer, _next_x, _next_y);
    
			    if (scr_check_one_way_hop(_tile_index, _next_x, _next_y, x, y)) {
			        _target_x = _next_x;
			        _target_y = _next_y;
			        _hop_start = true;
					_hop_offset = 8;
					global.player_ow_state = PLAYER_OW_STATE.MOVE;
			    } else {
			        global.player_ow_state = PLAYER_OW_STATE.IDLE;
			    }
			} else {
	            _target_x = _next_x;
	            _target_y = _next_y
	            _hop_start = false; 
				global.player_ow_state = PLAYER_OW_STATE.MOVE;
	        }
	    }
break;
#endregion

#region Move
case PLAYER_OW_STATE.MOVE: //perform the movement
    var _dx = _target_x - x;
    var _dy = _target_y - y;
    
    // Smooth movement
    if (abs(_dx) > 0 || abs(_dy) > 0) {
        x += sign(_dx) * min(_move_speed, abs(_dx));
        y += sign(_dy) * min(_move_speed, abs(_dy));
    }

    // Stop moving when the target position is reached
    if (x == _target_x && y == _target_y) { 
        y -= _hop_offset;
        _hop_offset = 0;

        if (_hop_start) {
            _hop_start = false;
            y += _hop_offset;
            _target_x += _hop_dx;
            _target_y += _hop_dy;
            global.player_ow_state = PLAYER_OW_STATE.MOVE;
        } else {
            global.player_ow_state = PLAYER_OW_STATE.MOVE_TICK;
        }
    }
break;
#endregion

#region Move Tick
case PLAYER_OW_STATE.MOVE_TICK: //step increment, spawn extras (leaves, cones, critters), trigger encounter if appropriate!
	global.step_count++;
	
	//attempt to spawn critter (10% chance)
	var _randroll = irandom(100);
	if (_randroll < 11){
		scr_spawn_critter();	
	}
	
	//if I can spawn a particle (5 step reset)
	if (_counter_particles > 4){
		//if now in a bush or grass, spawn a leaf
		if (((tilemap_get_at_pixel(_grass_layer, x, y) > 0) || (tilemap_get_at_pixel(_foliage_layer, x, y) > 0))) {
			scr_spawn_leaves();
			_counter_particles = 0;
		} 
		// else if now in a tree, spawn a cone
		else if (place_meeting(x,y,obj_tree)) {
				scr_spawn_cone();
				_counter_particles = 0;
		}
	}
	//increment particle counter
	_counter_particles++;	
	
	//trigger a transition with a 50% chance if in a grass/bush
	if (((tilemap_get_at_pixel(_grass_layer, x, y) > 0) || (tilemap_get_at_pixel(_foliage_layer, x, y) > 0))) {
			//spawn a transition if able to transition (20 steps)
		if (global.step_count >= 20 && _flag_transition_start == false){
			var _rand = irandom(100);
			if (_rand > 50){
				//trigger encounter (50% chance)
				global.step_count = 0;
				_flag_transition_start = true;
				_target_x = x;
				_target_y = y;
				_move_speed = 0;
				global.player_ow_state = PLAYER_OW_STATE.IDLE;
				scr_transition("encounter","Any","Any","Any");
			}
		}			
	} 
	
	global.player_ow_state = PLAYER_OW_STATE.IDLE;
break;
#endregion

#region Pause
case PLAYER_OW_STATE.PAUSE: //lock all input (conversations, cutscenes, in encounter, calculating)

break;
#endregion
}
}


////////////////////
// ENCOUNTER ROOM //
////////////////////
if (room == rm_encounter){
	switch(global.player_enc_state){
		case PLAYER_ENCOUNTER_STATE.INIT: //SPAWN CREATURES ON INIT ENTRY INTO THE ROOM
		break;
		case PLAYER_ENCOUNTER_STATE.BEGIN_TURN: //TURN BEGINS, PLAY TURN BEGIN EFFECTS
		break;		
		case PLAYER_ENCOUNTER_STATE.MINIONS_CAST: //MINIONS CAST RANDOM SPELLS IF POSSIBLE
		break;	
		case PLAYER_ENCOUNTER_STATE.SHUFFLING: //SHUFFLE YOUR DECK, SHUFFLE ENEMY DECKS
		break;
		case PLAYER_ENCOUNTER_STATE.DRAW: //DRAW YOUR CARDS, DRAW ENEMY CARDS
		break;		
		case PLAYER_ENCOUNTER_STATE.PICK_CARD: //STAY HERE WAITNIG FOR INPUT (CARD CLICKED ON), ALSO COUNTS AS IDLE (CAN DO OPTIONS MENU STUFF)
		break;		
		case PLAYER_ENCOUNTER_STATE.PICK_CHANNEL: //WHEN A CARD IS SELECTED, CHECK FOR CLICK ON ANYTHING (FOR TARGETLESS) OR ON ALLY CREATURE TO CHANNEL FOR TARGETED
		break;
		case PLAYER_ENCOUNTER_STATE.PICK_TARGET: //WHEN A CHANNEL IS PICKED, WAIT FOR A TARGET TO CAST SPELL ON
		break;
		case PLAYER_ENCOUNTER_STATE.CASTING: //SPELL EXECUTES, EFFECTS TRIGGER
		break;
		case PLAYER_ENCOUNTER_STATE.END_TURN: //END TURN EFFECTS TRIGGER AND PASES THE TURN TO THE ENEMY
		break;		
		case PLAYER_ENCOUNTER_STATE.ENEMY_TURN_IDLE: //IDLE HERE WHILE ENEMY GOES
		break;		
		case PLAYER_ENCOUNTER_STATE.EXIT_ENC: //cleanup on exit from encounter
		break;				
		case PLAYER_ENCOUNTER_STATE.PAUSE: //be in this state when obj_player goes back to OW
		break;
	}
	//if (_flag_deck_created == false){ //CREATE THE DECK
	
	//	instance_create_layer(x,y,"GUI",obj_deck_handler);
		
	//	_flag_deck_created = true;
	//}
	
	////spawn enemy units ONCE	
	//if (_flag_party_spawned == false){
	//	for (var _i = 0; _i < ds_list_size(global.player_team); _i++){					
	//		//spawn the creature
	//		var _ref_creature = ds_list_find_value(global.player_team, _i);
	//		var _ref_creature_instance = instance_create_layer(750-(170*_i), 650, "Creatures", obj_creature); //generate the creature	
	//		//pass the creature the proper stats it needs
	//		_ref_creature_instance._creature_name = _ref_creature[? "name"];
	//		_ref_creature_instance._creature_champion = _ref_creature[? "champion"];
	//		_ref_creature_instance._creature_color1 = _ref_creature[? "color1"];
	//		_ref_creature_instance._creature_color2 = _ref_creature[? "color2"];
	//		_ref_creature_instance._creature_subtype = _ref_creature[? "subtype"];
	//		_ref_creature_instance._creature_team = _ref_creature[? "team"];
	//		_ref_creature_instance._creature_breed = _ref_creature[? "breed"];
	//		_ref_creature_instance._creature_hp_max = _ref_creature[? "hp"];
	//		_ref_creature_instance._creature_hp_current = _ref_creature[? "curhp"];
	//		_ref_creature_instance._creature_spec = _ref_creature[? "spec"];
	//		_ref_creature_instance._creature_class = _ref_creature[? "class"];
	//		_ref_creature_instance.sprite_index = _ref_creature[? "sprite"];
	//		_ref_creature_instance._creature_sprite = _ref_creature[? "sprite"];
	//		_ref_creature_instance._creature_hurtsound = _ref_creature[? "hurtsound"];
	//		_ref_creature_instance._creature_deathsound = _ref_creature[? "deathsound"];
	//		_ref_creature_instance._creature_defaultsound = _ref_creature[? "defaultsound"];
			
	//		ds_list_add(global.player_team_in_play, _ref_creature_instance);
	//		_ref_creature_instance._creature_position = ds_list_find_index(global.player_team_in_play,_ref_creature_instance);
	//	}
	//	_flag_party_spawned = true;

			
	//	var _enemy_team = instance_create_layer(960, 540, "GUI", obj_enemy_team); //generate the enemy team						
	//}
}