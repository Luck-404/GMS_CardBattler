//////////////////////////////////////////////////////////////////////
//					OBJ_FIGHT_CONTROLLER STEP						//
//																	//
// > HANDLE LOGIC OF EACH STATE, THIS OBJECT RUNS THE ENEMY SIDE OF //
//   THE ENCOUNTER													//
//////////////////////////////////////////////////////////////////////		
switch(global.fight_controller_state){
	#region SPAWN ENEMIES
	case FIGHT_CONTROLLER_STATE.SPAWN_ENEMIES:
		show_debug_message("FIGHT CONTROLLER: SPAWNING ENEMIES...");
		//roll a random enemy team based on the room type, give them each a deck (inside script)
			//scr_roll_enemies(scr_save_room(global.saved_room), 1);
			scr_roll_enemies(scr_save_room(global.saved_room), irandom_range(1,5));			
			
		//spawn enemy team creature objects
		for (var _i = 0; _i < ds_list_size(global.enemy_party); _i++){				
			//spawn the creature
			var _ref_creature = ds_list_find_value(global.enemy_party, _i);
			var _ref_creature_instance = instance_create_layer(1124+(_i*158), 536, "Creatures", obj_creature); //generate the creature	
			//pass the creature the proper stats it needs
			_ref_creature_instance._creature_name = _ref_creature[? "name"];
			_ref_creature_instance._creature_champion = _ref_creature[? "champion"];
			_ref_creature_instance._creature_color1 = _ref_creature[? "color1"];
			_ref_creature_instance._creature_color2 = _ref_creature[? "color2"];
			_ref_creature_instance._creature_subtype = _ref_creature[? "subtype"];
			_ref_creature_instance._creature_team = "Enemy";
			_ref_creature_instance._creature_breed = _ref_creature[? "breed"];
			_ref_creature_instance._creature_hp_max = _ref_creature[? "hp"];		
			_ref_creature_instance._creature_hp_current = _ref_creature[? "hp"];
			_ref_creature_instance._creature_spec = _ref_creature[? "spec"];
			_ref_creature_instance._creature_class = _ref_creature[? "class"];
			if (_ref_creature_instance._creature_class == "Summoner") {
			_ref_creature_instance._creature_minion_limit = 5;
			}
			_ref_creature_instance.sprite_index = _ref_creature[? "sprite"];
			_ref_creature_instance._creature_sprite = _ref_creature[? "sprite"];
			_ref_creature_instance._creature_hurtsound = _ref_creature[? "hurtsound"];
			_ref_creature_instance._creature_deathsound = _ref_creature[? "deathsound"];
			_ref_creature_instance._creature_defaultsound = _ref_creature[? "defaultsound"];
			//init their deck
			scr_init_enemy_deck(_ref_creature_instance, _ref_creature[? "name"]);
			ds_list_add(global.enemy_party_in_play, _ref_creature_instance);		
			_ref_creature_instance._creature_position = ds_list_find_index(global.enemy_party_in_play,_ref_creature_instance);			
		}	
		
		
		//apply unit 'lefts' and 'rights'
		for (var _i = 0; _i < ds_list_size(global.enemy_party_in_play); _i++){		
			var _ref_creature = ds_list_find_value(global.enemy_party_in_play, _i);
			var _ref_left_creature = undefined;
			var _ref_right_creature = undefined;
			if (ds_list_find_value(global.enemy_party_in_play, _i-1) != undefined){
				_ref_left_creature = ds_list_find_value(global.enemy_party_in_play, _i-1);
			}
			if (ds_list_find_value(global.enemy_party_in_play, _i+1) != undefined){
				_ref_right_creature = ds_list_find_value(global.enemy_party_in_play, _i+1);
			}
			
			_ref_creature._left_unit = _ref_left_creature;
			_ref_creature._right_unit = _ref_right_creature;
		}		
		
		show_debug_message("FIGHT CONTROLLER: SUCCESS...");
		global.fight_controller_state = FIGHT_CONTROLLER_STATE.PLAYER_TURN;
	break;
	#endregion
	
	#region PLAYER TURN
	case FIGHT_CONTROLLER_STATE.PLAYER_TURN:
		//idle here while player goes (player sends to enemy turn)
	break;
	#endregion
	
	#region ENEMY TURN
	case FIGHT_CONTROLLER_STATE.ENEMY_TURN:
		#region	SHIELDS	
		///////////////////////
		// DECREMENT SHIELDS //
		///////////////////////
		if (_flag_shields_handled == false){
			_flag_shields_handled = true;
			//for each unit in player's party
			for (var _i = 0; _i < ds_list_size(global.enemy_party_in_play); _i++){
				var _unit = ds_list_find_value(global.enemy_party_in_play, _i);
				//if the unit has a shield, halve it- diff amounts for different classes
				scr_decrement_shields(_unit);
			}
		}

		
		////////////////
		// INIT TIMER //
		////////////////
		if (_flag_init_timer == false){
			_flag_init_timer = true;
			var _ref_timer = instance_create_layer(10,10,"GUI",obj_timer);
			_ref_timer._life = 60; //0.5s
		}
		if (instance_exists(obj_timer)){
			break;
		}
		#endregion

		#region ENEMY BEGIN TURN
		////////////////////////
		// BEGIN TURN EFFECTS //
		////////////////////////
		////TODO
		if (_flag_begin_turn_triggered == false){
			_flag_begin_turn_triggered = true;
			scr_trigger_status_effects("Begin","Enemy");
		}
		//wait
		if (_flag_begin_timer == false){
			_flag_begin_timer = true;
			var _ref_timer = instance_create_layer(10,10,"GUI",obj_timer);
			_ref_timer._life = 60; //0.5s
		}
		if (instance_exists(obj_timer)){
			break;
		}
		#endregion
	
		#region ENEMY MINIONS
		///////////////////
		// ENEMY MINIONS //
		///////////////////
		if (_flag_minions_cast == false){
			_flag_minions_cast = true;
			var _ref_player = instance_create_layer(10,10,"GUI",obj_minion_player);
			//add all minions to the list
				for (var _i = 0; _i < ds_list_size(global.enemy_party_in_play); _i++){
					var _unit = ds_list_find_value(global.enemy_party_in_play,_i);
					for (var _j = 0; _j < ds_list_size(_unit._creature_minion_references); _j++){
						var _minion = ds_list_find_value(_unit._creature_minion_references,_j);
						ds_list_add(_ref_player._playlist, _minion);
					}
				}
				//execute
				_ref_player._execute = true;
			if (instance_exists(obj_minion_player)){
				break;
			}	
		}

		//wait
		if (_flag_minions_timer == false){
			_flag_minions_timer = true;
			var _ref_timer = instance_create_layer(10,10,"GUI",obj_timer);
			_ref_timer._life = 60; //0.5s
		}
		if (instance_exists(obj_timer)){
			break;
		}
		#endregion
		
		
		
		#region ENEMY ATTACKS
		////////////
		// UNIT 1 //
		////////////
		if (ds_list_find_value(global.enemy_party_in_play,0) != undefined){
			///////////////////
			// UNIT 1 ATTACK //
			///////////////////			
			if (_flag_unit_1_went == false){
				_flag_unit_1_went = true
				//cast spell
				var _unit = ds_list_find_value(global.enemy_party_in_play,0);
				if (_unit._status_stunned != true){
					scr_play_enemy_card(_unit,_unit._card_to_play);
				} else {
					audio_play_sound(snd_effect_stun,0,false);
					instance_destroy(_unit._card_to_play);
					_unit._card_to_play = undefined;
				}
			}
			/////////////////////////////
			// UNIT 1 POST ATTACK WAIT //
			/////////////////////////////
			if (_flag_timer_1 == false){
				_flag_timer_1 = true;
				var _ref_timer = instance_create_layer(10,10,"GUI",obj_timer);
				_ref_timer._life = 60; //0.5s		
			}
			if (instance_exists(obj_timer)){
				break;
			}			
		}
		
		////////////
		// UNIT 2 //
		////////////
		if (ds_list_find_value(global.enemy_party_in_play,1) != undefined){
			///////////////////
			// UNIT 2 ATTACK //
			///////////////////			
			if (_flag_unit_2_went == false){
				_flag_unit_2_went = true
				//cast spell
				var _unit = ds_list_find_value(global.enemy_party_in_play,1);
				if (_unit._status_stunned != true){
					scr_play_enemy_card(_unit,_unit._card_to_play);
				} else {
					audio_play_sound(snd_effect_stun,0,false);
					instance_destroy(_unit._card_to_play);
					_unit._card_to_play = undefined;
				}
			}
			/////////////////////////////
			// UNIT 2 POST ATTACK WAIT //
			/////////////////////////////
			if (_flag_timer_2 == false){
				_flag_timer_2 = true;
				var _ref_timer = instance_create_layer(10,10,"GUI",obj_timer);
				_ref_timer._life = 60; //0.5s		
			}
			if (instance_exists(obj_timer)){
				break;
			}			
		}

		////////////
		// UNIT 3 //
		////////////
		if (ds_list_find_value(global.enemy_party_in_play,2) != undefined){
			///////////////////
			// UNIT 3 ATTACK //
			///////////////////			
			if (_flag_unit_3_went == false){
				_flag_unit_3_went = true
				//cast spell
				var _unit = ds_list_find_value(global.enemy_party_in_play,2);
				if (_unit._status_stunned != true){
					scr_play_enemy_card(_unit,_unit._card_to_play);
				} else {
					audio_play_sound(snd_effect_stun,0,false);
					instance_destroy(_unit._card_to_play);
					_unit._card_to_play = undefined;
				}
			}
			/////////////////////////////
			// UNIT 3 POST ATTACK WAIT //
			/////////////////////////////
			if (_flag_timer_3 == false){
				_flag_timer_3 = true;
				var _ref_timer = instance_create_layer(10,10,"GUI",obj_timer);
				_ref_timer._life = 60; //0.5s
			}
			if (instance_exists(obj_timer)){
				break;
			}			
		}

		////////////
		// UNIT 4 //
		////////////
		if (ds_list_find_value(global.enemy_party_in_play,3) != undefined){
			///////////////////
			// UNIT 4 ATTACK //
			///////////////////			
			if (_flag_unit_4_went == false){
				_flag_unit_4_went = true
				//cast spell
				var _unit = ds_list_find_value(global.enemy_party_in_play,3);
				if (_unit._status_stunned != true){
					scr_play_enemy_card(_unit,_unit._card_to_play);
				} else {
					audio_play_sound(snd_effect_stun,0,false);
					instance_destroy(_unit._card_to_play);
					_unit._card_to_play = undefined;
				}
			}
			/////////////////////////////
			// UNIT 4 POST ATTACK WAIT //
			/////////////////////////////
			if (_flag_timer_4 == false){
				_flag_timer_4 = true;
				var _ref_timer = instance_create_layer(10,10,"GUI",obj_timer);
				_ref_timer._life = 60; //0.5s
			}
			if (instance_exists(obj_timer)){
				break;
			}			
		}
		
		////////////
		// UNIT 5 //
		////////////
		if (ds_list_find_value(global.enemy_party_in_play,4) != undefined){
			///////////////////
			// UNIT 5 ATTACK //
			///////////////////			
			if (_flag_unit_5_went == false){
				_flag_unit_5_went = true
				//cast spell
				var _unit = ds_list_find_value(global.enemy_party_in_play,4);
				if (_unit._status_stunned != true){
					scr_play_enemy_card(_unit,_unit._card_to_play);
				} else {
					audio_play_sound(snd_effect_stun,0,false);
					instance_destroy(_unit._card_to_play);
					_unit._card_to_play = undefined;
				}
			}
			/////////////////////////////
			// UNIT 5 POST ATTACK WAIT //
			/////////////////////////////
			if (_flag_timer_5 == false){
				_flag_timer_5 = true;
				var _ref_timer = instance_create_layer(10,10,"GUI",obj_timer);
				_ref_timer._life = 60; //0.5s
			}
			if (instance_exists(obj_timer)){
				break;
			}			
		}
		#endregion
	
		#region END TURN
			///////////////////
			// END TURN WAIT //
			///////////////////
			if (_flag_end_timer == false){
				_flag_end_timer = true;
				var _ref_timer = instance_create_layer(10,10,"GUI",obj_timer);
				_ref_timer._life = 60;
			}	
			if (instance_exists(obj_timer)){
				break;
			}	
	
			//////////////////////
			// END TURN EFFECTS //
			//////////////////////
			scr_trigger_status_effects("End","Enemy");
			

			/////////////////////
			// RESET VARIABLES //
			/////////////////////
			_flag_init_timer = false;
			_flag_begin_turn_triggered = false;
			_flag_begin_timer = false;
			_flag_minions_cast = false;
			_flag_minions_timer = false;
			_flag_timer_1 = false;
			_flag_unit_1_went = false;
			_flag_timer_2 = false;
			_flag_unit_2_went = false;
			_flag_timer_3 = false;
			_flag_unit_3_went = false;
			_flag_timer_4 = false;
			_flag_unit_4_went = false;
			_flag_timer_5 = false;
			_flag_unit_5_went = false;
			_flag_end_timer = false;
			_flag_shields_handled = false;
			
			//////////////
			// TURN END //
			//////////////
			show_debug_message("FIGHT CONTROLLER: TURN " + string(global.turn_counter) + " COMPLETED");
			global.turn_counter++;

			show_debug_message("FIGHT CONTROLLER: TURN " + string(global.turn_counter) + " STARTED");
			
			global.player_enc_state = PLAYER_ENCOUNTER_STATE.BEGIN_TURN;	
			global.fight_controller_state = FIGHT_CONTROLLER_STATE.PLAYER_TURN;
			#endregion
		break;
		#endregion
	
	#region END IDLE
	case FIGHT_CONTROLLER_STATE.END_IDLE:
		//idle here while the confirm dialogue is up, reset timers
	break;	
	#endregion
}

////////////////////////////////////////////////
// CHECK IF A WIN/LOSS CONDITION HAS BEEN MET //
////////////////////////////////////////////////
	////////////////////////////
	// ALL ENEMIES DEAD - WIN //
	////////////////////////////
		if (_flag_exit_spawned == false && ds_list_size(global.enemy_party_in_play) == 0 && ds_list_size(global.enemy_party_dead) != 0){
		if (_flag_enc_reward_timer == false){
			_flag_enc_reward_timer = true;
			var _timer = instance_create_layer(10,10,"GUI",obj_timer);
			_timer._life = 30;
		}
		if (instance_exists(obj_timer)){
		
		} else {
			show_debug_message("FIGHT CONTROLLER: ENCOUNTER ENDED WITH A WIN");		
				_flag_exit_spawned = true;
				//if all enemies are dead, spawn a obj_enc_rewards with a "win" variable
				var _ref_rewards = instance_create_layer(room_width/2, room_height/2, "GUI",obj_enc_rewards);
				_ref_rewards._type = "win";
				global.flag_gui_open = true;
				global.fight_controller_state = FIGHT_CONTROLLER_STATE.END_IDLE;
				global.player_enc_state = PLAYER_ENCOUNTER_STATE.EXIT_ENC;	
			}
		}

	////////////////////////////
	// ALL ALLIES DEAD - LOSS //
	////////////////////////////
		if (_flag_exit_spawned == false && ds_list_size(global.player_party_in_play) == 0 && ds_list_size(global.player_party_dead) != 0){
			if (_flag_enc_reward_timer == false){
			_flag_enc_reward_timer = true;
			var _timer = instance_create_layer(10,10,"GUI",obj_timer);
			_timer._life = 30;
		}
		if (instance_exists(obj_timer)){
		
		} else {				
			_flag_exit_spawned = true;
			show_debug_message("FIGHT CONTROLLER: ENCOUNTER ENDED WITH A LOSS");	
			//if all allies are dead, spawn a obj_enc_rewards with a "loss" variable	
			var _ref_rewards = instance_create_layer(room_width/2, room_height/2, "GUI",obj_enc_rewards);
			_ref_rewards._type = "loss";
			global.flag_gui_open = true;
			global.fight_controller_state = FIGHT_CONTROLLER_STATE.END_IDLE;
			global.player_enc_state = PLAYER_ENCOUNTER_STATE.EXIT_ENC;
		}
		}

	////////////////////
	// FORFEIT CALLED //
	////////////////////
		if (_flag_exit_spawned == false && _flag_forfeit == true){
			if (_flag_enc_reward_timer == false){
			_flag_enc_reward_timer = true;
			var _timer = instance_create_layer(10,10,"GUI",obj_timer);
			_timer._life = 30;
		}
		if (instance_exists(obj_timer)){
		
		} else {				
			_flag_exit_spawned = true;
			show_debug_message("FIGHT CONTROLLER: ENCOUNTER ENDED WITH A FORFEIT");	
			//if forfeit was pressed, spawn a obj_enc_rewards with a "forfeit" variable
			var _ref_rewards = instance_create_layer(room_width/2, room_height/2, "GUI",obj_enc_rewards);
			_ref_rewards._type = "forfeit";
			global.flag_gui_open = true;
			global.fight_controller_state = FIGHT_CONTROLLER_STATE.END_IDLE;
			global.player_enc_state = PLAYER_ENCOUNTER_STATE.EXIT_ENC;
		}
	}