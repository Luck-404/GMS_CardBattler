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
#region GENERAL
case PLAYER_OW_STATE.GENERAL: //wait for player input (movement, interactions with NPCs/Treasures)
	//NPC gui- hosted in-object (send to interact (TODO))
	//Treasures- hosted in-object (send to interact-- need a timer for the 'zelda hold up' effect) (TODO)
	//Shop gui - hosted in-object (send to interact)
	
	if (global.flag_gui_open == true){
		_move_speed = 0;
	}
	else {
		/////////////////////
		// SHIFT TO SPRINT //
		/////////////////////
		if (room != rm_encounter && _flag_transition_start == false && (keyboard_check(vk_lshift) == true)){
			_move_speed = 4;
		} else if (room != rm_encounter && _flag_transition_start == false) {
			_move_speed = 3;	
		}
	}
	

	////////////////
	// CHECK MOVE //
	////////////////
	#region Check Move
	if (_move_speed != 0){
	_move_left  = keyboard_check(ord("A"));
	_move_right = keyboard_check(ord("D"));
	_move_up    = keyboard_check(ord("W"));
	_move_down  = keyboard_check(ord("S"));		
		//get move input
		if (_moving == false && (_move_left != 0 || _move_right != 0 || _move_up != 0 || _move_down != 0)){

			    // Determine movement direction
			    var _next_x = x;
			    var _next_y = y;
			    var _facing_front = true; // Tracks whether to use front-facing sprite
			    var _flip = 1; // Tracks xscale-- currently faced right
				
				//M (CANCELING)
				if ((_move_left && _move_right) || (_move_up && _move_down) || (_move_left && _move_up && _move_down && _move_right)) {

				} 	

				//8 directional variables
					// Up-Left
				if (_move_up && _move_left) {
				    _next_x = x-32;
				    _next_y = y-32;
				    _facing_front = false;
				    _flip = -1;
				} 
				// Up-Right
				else if (_move_up && _move_right) { 
				    _next_x = x+32;
				    _next_y = y-32;
				    _facing_front = false;
				} 
				// Down-Left
				else if (_move_down && _move_left) {
				    _next_x = x-32;
				    _next_y = y+32;
				    _flip = -1;
				} 
				// Down-Right
				else if (_move_down && _move_right) {
				    _next_x = x+32;
				    _next_y = y+32;
				} 
				// Up
				else if (_move_up) {
				    _next_y = y-32;
				    _facing_front = false;
				} 
				// Left
				else if (_move_left) {
				    _next_x = x-32;
				    _flip = -1;
				} 
				// Right
				else if (_move_right) {
				    _next_x = x+32;
				} 
				// Down
				else if (_move_down)  {
				    _next_y = y+32;
				}
				
				// Apply movement and sprite settings
				if (_next_x != x || _next_y != y) {
				    image_speed = 1;
				    image_xscale = _flip;
				    sprite_index = _facing_front ? spr_player_front : spr_player_back;
				}	
	
			
			    // Check if a tile exists at the target position
			    if (tilemap_get_at_pixel(_tile_layer, _next_x, _next_y) != 0) { //if there is a tile
			        if (tilemap_get_at_pixel(_wall_layer, _next_x, _next_y) != 0) { //if there is no wall
						//there is a wall, do nothing
			        } 
					else if ((tilemap_get_at_pixel(_one_way_layer, _next_x, _next_y) != 0)) { //if there is no one-way
						//there is a oneway, do nothing
					} 
					else {
						//otherwise there is no wall or oneway, move!
			            _target_x = _next_x;
			            _target_y = _next_y;
			            _hop_start = false; 
						_moving = true;
			        }
			    }
			}
		#endregion
		
	//////////////////
	// EXECUTE MOVE //
	//////////////////
	#region Execute Move
	if (_moving == true) {
		var _dx = _target_x - x;
		var _dy = _target_y - y;
    
		// Smooth movement toward target
		if (abs(_dx) > 0 || abs(_dy) > 0) {
		    x += sign(_dx) * min(_move_speed, abs(_dx));
		    y += sign(_dy) * min(_move_speed, abs(_dy));
		}

		// Stop moving when the target position is reached
		if (x == _target_x && y == _target_y) { 
		        _finish_move = true;
		    }
		}
	#endregion
		
	////////////////////
	// MOVE END TICKS //
	////////////////////
	#region Move End
	if (_finish_move == true){
		_finish_move = false;	
		image_speed = 0;
		global.step_count++;
	
		//attempt to spawn critter (10% chance)
		var _randroll = irandom(100);
		if (_randroll < 10){
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
			if (global.step_count >= global.steps_rand && _flag_transition_start == false){
				var _rand = irandom(100);		
				if (_rand > 50){ //trigger encounter (50% chance)	
					_flag_transition_start = true;
					global.steps_rand = irandom_range(10,15);
					global.player_ow_state = PLAYER_OW_STATE.PAUSED;
					show_debug_message("			TRANSITION TO ENCOUNTER FROM OVERWORLD");						
					scr_transition("encounter","Any","Any","Any");
				}
			}			
		}
		_moving = false;
	}
	#endregion
	}
break;
#endregion

#region Interaction
case PLAYER_OW_STATE.INTERACT: //lock all input (conversations, cutscenes, in encounter, calculating)
	//sent here from NPCS (TODO)
	//sent here from Treasures (TODO)
	//sent here from shops
	//sent here from options menu
	_finish_move = false;
	_moving = false;					
	_target_x = x;
	_target_y = y;
	_next_x = x;
	_next_y = y;
	_move_speed = 0;
break;
#endregion

#region Pause
case PLAYER_OW_STATE.PAUSED: //lock all input (conversations, cutscenes, in encounter, calculating)
	_flag_transition_start = false;
	global.step_count = 0;
	_finish_move = false;
	_moving = false;					
	_target_x = x;
	_target_y = y;
	_next_x = x;
	_next_y = y;
	_move_speed = 0;	
break;
#endregion
	}
}

////////////////////
// ENCOUNTER ROOM //
////////////////////
if (room == rm_encounter){
	switch(global.player_enc_state){
		#region INIT
			case PLAYER_ENCOUNTER_STATE.INIT: //SPAWN CREATURES ON INIT ENTRY INTO THE ROOM
			show_debug_message("PLAYER ENCOUNTER STATE: STARTING INIT...");	
			////////////////////
			// RANDOMIZE DECK //
			////////////////////
			scr_randomize_deck();
			
			////////////////
			// SPAWN TEAM //
			////////////////
				for (var _i = 0; _i < ds_list_size(global.player_party); _i++){					
					//spawn the creature
					var _ref_creature = ds_list_find_value(global.player_party, _i);
					var _ref_creature_instance = instance_create_layer(750-(170*_i), 650, "Creatures", obj_creature); //generate the creature	
					//pass the creature the proper stats it needs
					_ref_creature_instance._creature_name = _ref_creature[? "name"];
					_ref_creature_instance._creature_champion = _ref_creature[? "champion"];
					_ref_creature_instance._creature_color1 = _ref_creature[? "color1"];
					_ref_creature_instance._creature_color2 = _ref_creature[? "color2"];
					_ref_creature_instance._creature_subtype = _ref_creature[? "subtype"];
					_ref_creature_instance._creature_team = "Player";
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
					_ref_creature_instance._creature_position = _i;
					
					//_ref_creature_instance._creature_attack_linear = 1;
					//_ref_creature_instance._creature_attack_scalar = 2;
					ds_list_add(global.player_party_in_play, _ref_creature_instance);
				}
				
		for (var _i = 0; _i < ds_list_size(global.player_party_in_play); _i++) {		
			var _ref_creature = ds_list_find_value(global.player_party_in_play, _i);
			var _ref_left_creature = undefined;
			var _ref_right_creature = undefined;
			
			if (ds_list_find_value(global.player_party_in_play, _i-1) != undefined){
				_ref_left_creature = ds_list_find_value(global.player_party_in_play, _i-1);
			}
			if (ds_list_find_value(global.player_party_in_play, _i+1) != undefined){
				_ref_right_creature = ds_list_find_value(global.player_party_in_play, _i+1);
			}
			
			_ref_creature._left_unit = _ref_left_creature;
			_ref_creature._right_unit = _ref_right_creature;
		}		

			////////////////////////////
			// ON-ENCOUNTER BLESSINGS //
			////////////////////////////
				//TODO
				
			//PASS
			show_debug_message("PLAYER ENCOUNTER STATE: SUCCESS...");	
			global.player_enc_state = PLAYER_ENCOUNTER_STATE.BEGIN_TURN;
		break;
		#endregion
		
		
		
		#region BEGIN TURN
		case PLAYER_ENCOUNTER_STATE.BEGIN_TURN: //TURN BEGINS, PLAY TURN BEGIN EFFECTS			
			//////////////////////////////////////
			// DECREMENT SHIELDS FROM LAST TURN //
			//////////////////////////////////////
				//only if not turn 1
				if (global.turn_counter != 1){
					//for each unit in player's party
					for (var _i = 0; _i < ds_list_size(global.player_party_in_play); _i++){
						var _unit = ds_list_find_value(global.player_party_in_play, _i);
						//if the unit has a shield, halve it- diff amounts for different classes
						scr_decrement_shields(_unit);
					}
				}
				
			////////////////////////////////
			// TRIGGER BEGIN TURN EFFECTS //
			////////////////////////////////
				//for each unit in player's party
				for (var _i = 0; _i < ds_list_size(global.player_party_in_play); _i++){
					var _unit = ds_list_find_value(global.player_party_in_play, _i);
					//scr_trigger_turn_effects(_unit);
					//Util
				
					//Buffs
				
					//Debuffs
				
					//CC
				
					//DoTs
				}			

			//PASS
			global.player_enc_state = PLAYER_ENCOUNTER_STATE.MINIONS_CAST;				
		break;		
		#endregion
		
		
		
		#region Minions Cast
		case PLAYER_ENCOUNTER_STATE.MINIONS_CAST: //MINIONS CAST RANDOM SPELLS IF POSSIBLE
			//tell each minion to execute their casting script
				//for each unit in player's party
				for (var _i = 0; _i < ds_list_size(global.player_party_in_play); _i++){
					var _unit = ds_list_find_value(global.player_party_in_play, _i);
					//triggers each ally minion in order (1-5), if they have at least one
					//TODO
					//scr_trigger_minions(_unit);
				}

			//PASS
			global.player_enc_state = PLAYER_ENCOUNTER_STATE.DRAW;							
		break;	
		#endregion
		
		
		
		#region DRAW
		case PLAYER_ENCOUNTER_STATE.DRAW: //DRAW YOUR CARDS, DRAW ENEMY CARDS
				
			#region USER CARDS
			/////////////////////
			// DRAW USER CARDS //
			/////////////////////
				//see how many cards are in my hand
				var _cards_in_deck = ds_list_size(global.player_encounter_deck);
				//see how many cards I can draw
				var _amount_to_draw = global.max_hand_size;
				var _extra = _cards_in_deck - _amount_to_draw;
			
				if (_extra > 0){
					//draw the cards normally
					scr_draw_cards(global.max_hand_size); //also adds cards to current hand
				}
				else if (_extra == 0){
					//draw cards normally
					scr_draw_cards(global.max_hand_size); //also adds cards to current hand
					//shuffle discard into deck
					scr_shuffle(); //takes all cards from discard and shuffles them back into your deck
				}
				else {
					var _diff = abs(_extra);
					var _first_draw = _amount_to_draw - _diff;
					//draw the first amount of cards (_first_draw)
					scr_draw_cards(_first_draw); //draw first part of the cards
					//shuffle discard into the deck
					scr_shuffle(); //takes all cards from discard and shuffles them back into your deck
					//draw second amount of cards (_diff)
					scr_draw_cards(_diff); //draw last part of the cards
				}
			#endregion
		
			#region ENEMY CARDS		
			//////////////////////
			// DRAW ENEMY CARDS //
			//////////////////////				
				//draw enemy's cards
				//for each enemy in enemy_list
				for (var _i = 0; _i < ds_list_size(global.enemy_party_in_play); _i++){
					var _unit = ds_list_find_value(global.enemy_party_in_play, _i);
					var _unit_deck = _unit._deck;
					var _card = ds_list_find_value(_unit_deck,0);
					scr_init_enemy_card(_card,_unit); //spawn a enemy_card_object, draws itself, can show info on hover in 
				}
			#endregion
			//PASS
			global.player_enc_state = PLAYER_ENCOUNTER_STATE.PICK_CARD;						
		break;		
		#endregion
		
		
		
		#region PICK CARD	
		case PLAYER_ENCOUNTER_STATE.PICK_CARD: //STAY HERE WAITNIG FOR INPUT (CARD CLICKED ON), ALSO COUNTS AS IDLE (CAN DO OPTIONS MENU STUFF)
		if (global.flag_gui_open == false){
		///////////////////
		// HOVER EFFECTS //
		///////////////////	
			//Cards (user hand and enemy prepped) - handled by obj_card/obj_enemy_card
			//Allies & Enemies //handled by obj_creature
			//minions (ally and enemy) //handled by obj_minion


		//////////////
		// END TURN //
		//////////////
		if (position_meeting(mouse_x, mouse_y, obj_end_turn) && mouse_check_button_pressed(mb_left)){
			global.player_enc_state = PLAYER_ENCOUNTER_STATE.END_TURN;	
		}
			
		/////////////////
		// SELECT CARD //
		/////////////////
			//check if card objects are usable (not enough mana, no unit on team that can cast it/units that can cast it are stunned)
				if (_flag_check_card == false){

					_flag_check_card = true;
					for (var _i = 0; _i < ds_list_size(global.player_hand); _i++){
						var _card = ds_list_find_value(global.player_hand, _i);		
						if (_card._active == false){
							var _flag_usability = scr_check_usability(_card);
							if (_flag_usability == true){
								_card._active = true;
							} else {
								_card._active = false;
							}
						}
						//cards draw greyed or not depending on usability
					}
				}
				
				//click on a card object
				if (position_meeting(mouse_x, mouse_y, obj_card) && instance_nearest(mouse_x, mouse_y, obj_card)._list == "hand" && mouse_check_button_pressed(mb_left)){
					var _card = instance_nearest(mouse_x, mouse_y, obj_card);

					if (_card._active != false){
						//unselect all cards
						with(obj_card){
							obj_card._selected = false;
						}
						//reset user card selection
						_card_selected = undefined;
					
						//select new card
						_card._selected = true;
						_card_selected = _card;				
					
						//once a card is selected PASS
						global.player_enc_state = PLAYER_ENCOUNTER_STATE.PICK_CHANNEL;
					}
					else {
						//if not usable- grey out- play err and shake slightly if they try to click it
						//TODO
						//SHAKE
						//ERR NOISE
					}
				}
				
		///////////////////////
		// RIGHT CLICK / ESC //
		///////////////////////	
		if (mouse_check_button_pressed(mb_right) || (keyboard_check_pressed(vk_escape))){		
				//unselect all cards
				with(obj_card){
					obj_card._selected = false;
				}
				//reset user card selection
				_card_selected = undefined;
			}	
		}
		break;		
		#endregion		
		
		
		
		#region PICK CHANNEL
		case PLAYER_ENCOUNTER_STATE.PICK_CHANNEL: //WHEN A CARD IS SELECTED, CHECK FOR CLICK ON ANYTHING (FOR TARGETLESS) OR ON ALLY CREATURE TO CHANNEL FOR TARGETED
		if (global.flag_gui_open == false){
				
			///////////////////
			// HOVER EFFECTS //
			///////////////////	
				//Cards (user hand and enemy prepped) - handled by obj_card/obj_enemy_card
				//Allies & Enemies //handled by obj_creature
				//minions (ally and enemy) //handled by obj_minion
			
			/////////////////////
			// HIGHLIGHT UNITS //
			/////////////////////	
			if (_flag_check_channel == false){

				_flag_check_channel = true;			
				for(var _i = 0; _i < ds_list_size(global.player_party_in_play); _i++){
					var _unit = ds_list_find_value(global.player_party_in_play, _i);
					if (_unit._active == false){					
						//based on the card, highlight ally units that fit the criteria
						var _check_channel = scr_check_channelability(_unit,_card_selected);
			
						if(_check_channel == true){
							_unit._active = true;
						} else {
							_unit._active = false;	
						}
					}
				}
			}
					
			//////////////
			// END TURN //
			//////////////
			if (position_meeting(mouse_x, mouse_y, obj_end_turn) && mouse_check_button_pressed(mb_left)){
				global.player_enc_state = PLAYER_ENCOUNTER_STATE.END_TURN;	
			}
		
			///////////////////////
			// RIGHT CLICK / ESC //
			///////////////////////	
			if (mouse_check_button_pressed(mb_right) || (keyboard_check_pressed(vk_escape))){		
				//unselect all cards
				_card_selected._selected = false;
				//reset user card selection
				_card_selected = undefined;
				//unselect channels
				if (_channel_selected != undefined){
					_channel_selected._selected_channel = false;
					_channel_selected = undefined;
				}
				
				_flag_check_card = false;
				_flag_check_channel = false;
					
				with (obj_creature){
					obj_creature._active = false;
					obj_creature._selected_channel = false;
					obj_creature._selected_target = false;
				}
				//send back one state
				global.player_enc_state = PLAYER_ENCOUNTER_STATE.PICK_CARD;	
			}			
				
			////////////////////
			// SELECT CHANNEL //
			////////////////////			
			//select unit to cast through - err noise on improper units
			if (position_meeting(mouse_x, mouse_y, obj_creature) && mouse_check_button_pressed(mb_left)){
				var _unit = instance_nearest(mouse_x, mouse_y, obj_creature);
				if (_unit._active != false){
					//unselect all creatures
					with(obj_creature){
						obj_creature._selected_channel = false;
					}
					//reset user card selection
					_channel_selected = undefined;
					
					//select new card
					_unit._selected_channel = true;
					_channel_selected = _unit;		
					
					//once a card is selected PASS
					global.player_enc_state = PLAYER_ENCOUNTER_STATE.PICK_TARGET;
				}
				else {
					//if not usable- grey out- play err and shake slightly if they try to click it
					//TODO
					//SHAKE
					//ERR NOISE
				}
			}		
		}
		break;
		#endregion
		
		
		
		#region PICK TARGET
		case PLAYER_ENCOUNTER_STATE.PICK_TARGET: //WHEN A CHANNEL IS PICKED, WAIT FOR A TARGET TO CAST SPELL ON
		if (global.flag_gui_open == false){
			//////////////
			// END TURN //
			//////////////
			if (position_meeting(mouse_x, mouse_y, obj_end_turn) && mouse_check_button_pressed(mb_left)){
				global.player_enc_state = PLAYER_ENCOUNTER_STATE.END_TURN;	
			}
			///////////////////
			// HOVER EFFECTS //
			///////////////////					
			//Cards (user hand and enemy prepped) - handled by obj_card/obj_enemy_card
			//Allies & Enemies //handled by obj_creature
			//minions (ally and enemy) //handled by obj_minion
		
			///////////////////////
			// RIGHT CLICK / ESC //
			///////////////////////
			if (mouse_check_button_pressed(mb_right) || (keyboard_check_pressed(vk_escape))){		
				var _dest = undefined;
				if (_card_selected._flag_targetless == true){
					//unselect all cards
					_card_selected._selected = false;
					_card_selected = undefined;					
					_dest = PLAYER_ENCOUNTER_STATE.PICK_CARD;
				} else {
					_dest = PLAYER_ENCOUNTER_STATE.PICK_CHANNEL;	
				}		

				//unselect channel unit
				if (_channel_selected != undefined){
					_channel_selected._selected_channel = false;
					_channel_selected = undefined;
				}
				//unselect target unit
				if (_target_selected != undefined){				
					_target_selected._selected_target = false;
					_target_selected = undefined;		
				}
				with (obj_creature){
					obj_creature._active = false;
					obj_creature._selected_channel = false;
					obj_creature._selected_target = false;
				}				
				
				_flag_check_card = false;
				_flag_check_channel = false;
				
				global.player_enc_state = _dest;
			}						
			
			////////////////
			// TARGETLESS //
			////////////////
			//if targetless, prompt to click anywhere
			if (_card_selected._flag_targetless == true){
			//if clicked- cast te spell, send back to pick card
				scr_play_card(_card_selected,_channel_selected,"Targetless");
				//send back to pick card for another cast
				global.player_enc_state = PLAYER_ENCOUNTER_STATE.PICK_CARD;	
			} 
		
			///////////////////
			// SELECT TARGET //
			///////////////////		
			else {
				if (position_meeting(mouse_x, mouse_y, obj_creature) && mouse_check_button_pressed(mb_left)){
					var _unit = instance_nearest(mouse_x, mouse_y, obj_creature);
					//unselect all cards
					with(obj_creature){
						obj_creature._selected_target = false;
					}
					//reset user card selection
					_target_selected = undefined;
					
					//select new card
					_unit._selected_target = true;
					_target_selected = _unit;
					
					//if clicked- cast te spell, send back to pick card
					scr_play_card(_card_selected,_channel_selected,_target_selected);
			
					//send back to pick card for another cast
					global.player_enc_state = PLAYER_ENCOUNTER_STATE.PICK_CARD;	
				}
			}
		}
		break;
		#endregion
		
		
		
		#region END TURN
		case PLAYER_ENCOUNTER_STATE.END_TURN: //END TURN EFFECTS TRIGGER AND PASES THE TURN TO THE ENEMY
			//////////////////////////////
			// TRIGGER END TURN EFFECTS //
			//////////////////////////////
				//TODO

			with (obj_card_counter) {
			if (_counter_team == "Player" && _target == "Targetless"){
		        _turn_lifespan--;
				_trigger_my_effect = true;
			}			
			else if (_target != "Targetless" && _target._creature_team == "Player") {
			    _turn_lifespan--;
				_trigger_my_effect = true;
			}				
			}
			
			//empty hand into discard pile
			scr_discard_hand();
			
			//regen mana
			global.cur_mana = global.max_mana+global.bonus_mana;
			
			//reset player's selected and such
			obj_player._card_selected = undefined;	
			obj_player._channel_selected = undefined;
			obj_player._target_selected = undefined;
			
			with(obj_card){
				obj_card._active = false;
				obj_card._selected = false;
			}
			
			with(obj_creature){
				obj_creature._active = false;
				obj_creature._selected_channel = false;
				obj_creature._selected_target = false;
			}			
			
			obj_player._flag_check_card = false;
			obj_player._flag_check_channel = false;
			
			//pass turn to enemy
			global.fight_controller_state = FIGHT_CONTROLLER_STATE.ENEMY_TURN;
				
			//transition to idle
			global.player_enc_state = PLAYER_ENCOUNTER_STATE.ENEMY_TURN_IDLE;	
		break;		
		#endregion
		
		
		
		#region ENEMY TURN IDLE
		case PLAYER_ENCOUNTER_STATE.ENEMY_TURN_IDLE: //IDLE HERE WHILE ENEMY GOES
		
		break;		
		#endregion
		
		
		
		#region EXIT ENC
		case PLAYER_ENCOUNTER_STATE.EXIT_ENC: //cleanup on exit from encounter	
			with(obj_card){
				obj_card._active = false;
				obj_card._selected = false;
			}
			
			//reset player's selected and such
			obj_player._card_selected = undefined;	
			obj_player._channel_selected = undefined;
			obj_player._target_selected = undefined;
			

			
			with(obj_creature){
				obj_creature._selected_channel = false;
				obj_creature._selected_target = false;
			}			
			
			while(ds_list_size(global.encounter_utility_active) != 0){
				var _counter = ds_list_find_value(global.encounter_utility_active, _i);	
				ds_list_delete(global.encounter_utility_active,_i);
				instance_destroy(_counter);
			}
			ds_list_clear(global.encounter_utility_active);
			
			//Update any allies health and Put any dead allies into graveyard
			if (ds_list_size(global.player_party_in_play) != 0){
				for (var _i = 0; _i < ds_list_size(global.player_party); _i++){
					var _ref_creature = ds_list_find_value(global.player_party_in_play,_i); //get the creature at that spot
					var _ref_hp_cur = _ref_creature._creature_hp_current; //get the value of the creature's currenthp
					//update the current hp to the permanent list
					var _ref_original_creature = ds_list_find_value(global.player_party,_i); //get the creature at that spot
					_ref_original_creature[?"curhp"] = _ref_hp_cur;
					//if that hp turns out to be 0- the creature has died and is sent to the graveyard
					if (_ref_hp_cur == 0){
						ds_list_delete(global.player_party,_i);
						ds_list_add(global.graveyard,_ref_original_creature);
					}
				}	
			} else {
				
			}
				
			//Put cards back into deck (from exhaust and discard)			
			scr_cards_cleanup();
			
			global.player_enc_state = PLAYER_ENCOUNTER_STATE.PAUSE;		
		break;				
		#endregion
		
		
		
		#region PAUSE
		case PLAYER_ENCOUNTER_STATE.PAUSE: //be in this state when obj_player goes back to OW
		
		break;
		#endregion
	}
}