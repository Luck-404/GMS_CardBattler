//===============================================================================//
//
// STEP: OBJ_BATTLE_ENEMY_CONTROLLER
// FUNCTION: Executes the enemy battle state machine.
//
//===============================================================================//

switch(_state_enemy){

	//
	// INIT BEASTS
	//
	#region INIT BEASTS
	case ENUM_ENEMY_STATE.INIT_BEASTS:

		for (var _it_beast = 0; _it_beast < _ct_beast; _it_beast++){

			//---------------------//
			//CREATE BEAST STRUCT//
			//---------------------//
			var _stct_unit = undefined;

			if (
				_it_beast == 0 &&
				variable_global_exists("stct_forced_enemy_unit") &&
				global.stct_forced_enemy_unit != undefined
			){
				_stct_unit =
					global.stct_forced_enemy_unit;

				global.stct_forced_enemy_unit =
					undefined;
			}
			else{
				_stct_unit = scr_get_random_beast(
					global.arr_last_enemy_pool
				);
			}

			//----------------//
			//VALIDATE BEAST//
			//----------------//
			if (!is_struct(_stct_unit)){

				show_debug_message(
					"ENEMY BATTLE INIT ERROR | INVALID BEAST STRUCT | INDEX: " +
					string(_it_beast)
				);

				continue;
			}

			//---------------------//
			//VALIDATE MAXIMUM HP//
			//---------------------//
			if (_stct_unit._val_beast_hp_max <= 0){

				show_debug_message(
					"ENEMY BATTLE INIT ERROR | INVALID MAX HP | " +
					string(_stct_unit._str_beast_name)
				);

				continue;
			}

			//----------------//
			//CLAMP CURRENT HP//
			//----------------//
			_stct_unit._val_beast_hp_cur = clamp(
				_stct_unit._val_beast_hp_cur,
				0,
				_stct_unit._val_beast_hp_max
			);

			//--------------------------------//
			//ENEMIES MUST ENTER BATTLE ALIVE//
			//--------------------------------//
			if (_stct_unit._val_beast_hp_cur <= 0){

				show_debug_message(
					"ENEMY BATTLE INIT ERROR | DEAD ENEMY | " +
					string(_stct_unit._str_beast_name)
				);

				continue;
			}

			//---------------//
			//UPDATE LOGBOOK//
			//---------------//
			if (variable_global_exists("map_logbook_beasts")){

				scr_logbook_mark_beast_seen(
					_stct_unit._str_beast_name
				);

				if (
					ds_map_exists(
						global.map_logbook_beasts,
						_stct_unit._str_beast_name
					)
				){
					var _stct_seen_test =
						global.map_logbook_beasts[? _stct_unit._str_beast_name];

					show_debug_message(
						"LOGBOOK SEEN: " +
						string(_stct_unit._str_beast_name) +
						" | COUNT: " +
						string(_stct_seen_test._ct_seen)
					);
				}
			}

			//--------------------//
			//CREATE BATTLE BEAST//
			//--------------------//
			var _ref_beast = instance_create_layer(
				room_width * 0.5 + 80 + (100 * _it_beast),
				room_height * 0.5,
				"ily_player",
				obj_battle_beast
			);

			//--------------------//
			//TRANSFER BEAST DATA//
			//--------------------//
			_ref_beast._spr_beast =
				_stct_unit._spr_beast;

			_ref_beast._ref_unit =
				_stct_unit;

			_ref_beast._stct_held_item =
				_stct_unit._ref_beast_held_item;

			_ref_beast._str_team =
				"ENEMY";

			_ref_beast._uid_beast =
				_stct_unit._uid_beast;

			_ref_beast._snd_cry =
				_stct_unit._snd_beast_cry;

			_ref_beast._snd_death =
				_stct_unit._snd_beast_death;

			_ref_beast._val_pos =
				_it_beast;

			//-----------------------//
			//TRANSFER COMBAT STATS//
			//-----------------------//
			_ref_beast._ct_minions_max =
				_stct_unit._val_beast_min_stat;

			_ref_beast._val_crit_chance =
				_stct_unit._val_beast_crit_stat;

			_ref_beast._val_crit_damage =
				_stct_unit._val_beast_crit_dmg_stat;

			_ref_beast._val_cur_hp =
				_stct_unit._val_beast_hp_cur;

			_ref_beast._val_max_hp =
				_stct_unit._val_beast_hp_max;

			//-------------//
			//TRACK BEAST//
			//-------------//
			ds_list_add(
				_list_beasts,
				_ref_beast
			);

			ds_list_add(
				_list_beasts_alive,
				_ref_beast
			);
		}

		_state_enemy =
			ENUM_ENEMY_STATE.INIT_CARDS;

	break;
	#endregion
	
	//
	// INIT CARDS
	//
	#region INIT CARDS
	case ENUM_ENEMY_STATE.INIT_CARDS:

		// CREATE A DECK FOR EACH LIVING ENEMY BEAST
		for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

			var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);
			var _stct_unit = _ref_beast._ref_unit;

			// BUILD DECK
			var _list_deck = scr_get_enemy_deck(
				_stct_unit._str_beast_name,
				_stct_unit._str_beast_color_type
			);

			// CREATE CARD INSTANCES
			for (var _it_card = 0; _it_card < ds_list_size(_list_deck); _it_card++){

				var _stct_card = ds_list_find_value(_list_deck,_it_card);

				var _ref_card = instance_create_layer(
					_ref_beast.x,
					_ref_beast.y - 200,
					"ily_enemy",
					obj_battle_card
				);

				_ref_card._spr_card = _stct_card._spr_card;
				_ref_card._uid_card = _stct_card._uid_card;
				_ref_card._str_team = "ENEMY";
				_ref_card._ref_card = _stct_card;
				_ref_card._ref_unit = _ref_beast;
				_ref_card._str_location = "DECK";
				_ref_card.visible = true;

				ds_list_add(_ref_beast._list_deck,_ref_card);
			}

			// SHUFFLE DECK
			ds_list_shuffle(_ref_beast._list_deck);

			// DRAW FIRST CARD
			_ref_beast._val_hand_pos = 0;

			var _ref_card = ds_list_find_value(
				_ref_beast._list_deck,
				_ref_beast._val_hand_pos
			);

			_ref_card._str_location = "HAND";
		}

		_state_enemy = ENUM_ENEMY_STATE.WAIT;

	break;
	#endregion
	
	//
	// WAIT
	//
	#region WAIT
	case ENUM_ENEMY_STATE.WAIT:

		// TURN START ITEMS
		_flag_turn_start_items_init = false;
		_flag_turn_start_items_complete = false;

		// TURN END ITEMS
		_flag_turn_end_items_init = false;
		_flag_turn_end_items_complete = false;

		// STATUSES / CASTING / MINIONS
		_flag_statuses_init = false;
		_flag_cast_init = false;
		_flag_minions_init = false;

	break;
	#endregion
	
	//
	// TURN START
	//
	#region TURN START
	case ENUM_ENEMY_STATE.TURN_START:

		//-----------------------//
		//BUILD HELD ITEM QUEUE//
		//-----------------------//
		if (!_flag_turn_start_items_init){

			_flag_turn_start_items_init = true;

			_list_turn_start_items = ds_list_create();

			// DEGRADE SHIELDS
			for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

				var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

				scr_degrade_shield(_ref_beast);
			}

			// BUILD TURN START ITEM QUEUE
			for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

				var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				var _stct_item = _ref_beast._stct_held_item;

				if (_stct_item == undefined || _stct_item == "EMPTY"){
					continue;
				}

				if (_stct_item._str_item_trigger_type != "TURN_START"){
					continue;
				}

				var _stct_trigger = {
					_ref_beast : _ref_beast,
					_stct_item : _stct_item
				};

				ds_list_add(_list_turn_start_items,_stct_trigger);
			}
		}

		//-------------------------//
		//EXECUTE HELD ITEM QUEUE//
		//-------------------------//
		if (
			_flag_turn_start_items_init &&
			!_flag_turn_start_items_complete &&
			!instance_exists(obj_wait)
		){

			if (ds_list_size(_list_turn_start_items) > 0){

				var _stct_trigger = ds_list_find_value(_list_turn_start_items,0);

				var _ref_beast = _stct_trigger._ref_beast;
				var _stct_item = _stct_trigger._stct_item;

				if (
					instance_exists(_ref_beast) &&
					_stct_item != undefined &&
					_stct_item._scr_item != undefined
				){

					scr_spawn_popup_trigger_banner(_stct_item._str_item_name);

					var _flag_triggered = script_execute(
						_stct_item._scr_item,
						"TRIGGER",
						_stct_item,
						_ref_beast
					);

					if (_flag_triggered){
						_ref_beast._stct_held_item = "EMPTY";
					}
				}

				ds_list_delete(_list_turn_start_items,0);

				scr_init_battle_wait(60);
			}
			else{

				ds_list_destroy(_list_turn_start_items);
				_list_turn_start_items = undefined;

				_flag_turn_start_items_complete = true;
			}
		}

		//------------------//
		//BUILD STATUS QUEUE//
		//------------------//
		if (_flag_turn_start_items_complete && !_flag_statuses_init){

			_flag_statuses_init = true;

			_list_statuses = ds_list_create();

			for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

				var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

				for (var _it_status = 0; _it_status < ds_list_size(_ref_beast._list_statuses); _it_status++){

					ds_list_add(
						_list_statuses,
						ds_list_find_value(_ref_beast._list_statuses,_it_status)
					);
				}
			}
		}

		//--------------------//
		//EXECUTE STATUS QUEUE//
		//--------------------//
		if (_flag_statuses_init && !instance_exists(obj_wait)){

			if (ds_list_size(_list_statuses) > 0){

				var _ref_status = ds_list_find_value(_list_statuses,0);

				if (instance_exists(_ref_status)){

					if (_ref_status._str_trigger_region == "START"){
						_ref_status._str_status_command = "REPEAT";
					}

					ds_list_delete(_list_statuses,0);

					scr_init_battle_wait(10);
				}
				else{
					ds_list_delete(_list_statuses,0);
				}
			}
			else{

				ds_list_destroy(_list_statuses);
				_list_statuses = undefined;

				_flag_statuses_init = false;

				_state_enemy = ENUM_ENEMY_STATE.TRIGGER_MINIONS;
			}
		}

	break;
	#endregion
	
	//
	// TRIGGER MINIONS
	//
	#region TRIGGER MINIONS
	case ENUM_ENEMY_STATE.TRIGGER_MINIONS:

		if (!_flag_minions_init){

			_flag_minions_init = true;

			_list_casting_minions = ds_list_create();

			// BUILD MINION QUEUE
			for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

				var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

				for (var _it_minion = 0; _it_minion < ds_list_size(_ref_beast._list_minions); _it_minion++){

					ds_list_add(
						_list_casting_minions,
						ds_list_find_value(_ref_beast._list_minions,_it_minion)
					);
				}
			}
		}

		if (_flag_minions_init && !instance_exists(obj_wait)){

			if (ds_list_size(_list_casting_minions) > 0){

				var _ref_minion = ds_list_find_value(_list_casting_minions,0);

				scr_cast_minion_effect(_ref_minion);

				ds_list_delete(_list_casting_minions,0);

				scr_init_battle_wait(15);
			}
			else{

				ds_list_destroy(_list_casting_minions);
				_list_casting_minions = undefined;

				_flag_minions_init = false;

				_state_enemy = ENUM_ENEMY_STATE.CAST_CARDS;
			}
		}

	break;
	#endregion
	
	//
	// CAST CARDS
	//
	#region CAST CARDS
	case ENUM_ENEMY_STATE.CAST_CARDS:

		if (!_flag_cast_init){

			_flag_cast_init = true;
			_list_casting_units = ds_list_create();

			for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){
				ds_list_add(_list_casting_units,ds_list_find_value(_list_beasts_alive,_it_beast));
			}
		}

		if (_flag_cast_init && !instance_exists(obj_wait)){

			if (ds_list_size(_list_casting_units) > 0){

				var _ref_beast = ds_list_find_value(_list_casting_units,0);

				obj_battle_player_controller.hscr_check_battle_beast_able(_list_beasts_alive);

				var _ref_card = ds_list_find_value(_ref_beast._list_deck,_ref_beast._val_hand_pos);

				//--------------------//
				// DISABLED ENEMY CARD
				//--------------------//
				if (_ref_card._flag_card_disabled){

					scr_spawn_popup_scrolling(
						"TEXT",
						"CARD DISABLED",
						undefined,
						c_black,
						_ref_beast.x,
						_ref_beast.y - 72
					);

					audio_play_sound(snd_debuff,0,false);

					_ref_card.visible = false;

					ds_list_delete(
						_list_casting_units,
						0
					);

					scr_init_battle_wait(30);

					break;
				}
	
				if (_ref_beast._flag_beast_able_check){

					var _str_card_type = _ref_card._ref_card._str_card_type;
					var _ref_target = undefined;

					switch(_str_card_type){

						case "ATTACK":
							var _list_enemy = obj_battle_player_controller._list_beasts_alive;

							if (ds_list_size(_list_enemy) > 0){
								var _ref_taunt_target = scr_get_taunt_target(_list_enemy);

								//----------------//
								//TAUNT OVERRIDE//
								//----------------//
								if (instance_exists(_ref_taunt_target)){

									_ref_target = _ref_taunt_target;
								}

								//-----------------//
								//NORMAL TARGETING//
								//-----------------//
								else{

									switch(_ref_card._ref_card._str_card_range){

										case "MELEE":
											_ref_target = ds_list_find_value(_list_enemy,0);
										break;

										case "BACK":
											_ref_target = ds_list_find_value(
												_list_enemy,
												ds_list_size(_list_enemy) - 1
											);
										break;

										default:
											_ref_target = ds_list_find_value(
												_list_enemy,
												irandom(ds_list_size(_list_enemy) - 1)
											);
										break;
									}
								}

								global.ref_cast_card = _ref_card;
								global.ref_caster_beast = _ref_beast;
								global.ref_target_beast = _ref_target;

								scr_cast_card();
							}
						break;

						case "SUPPORT":

							var _str_effect_type =
								_ref_card._ref_card._str_card_effect_type;

							//-------------------//
							//HOSTILE SUPPORT CARD//
							//-------------------//
							if (
								_str_effect_type == "CC" ||
								_str_effect_type == "DEBUFF"
							){

								var _list_enemy =
									obj_battle_player_controller._list_beasts_alive;

								if (ds_list_size(_list_enemy) > 0){

									switch(_ref_card._ref_card._str_card_range){

										//----------------//
										//FRONTLINE TARGET//
										//----------------//
										case "MELEE":

											_ref_target =
												ds_list_find_value(
													_list_enemy,
													0
												);

										break;

										//---------------//
										//BACKLINE TARGET//
										//---------------//
										case "BACK":

											_ref_target =
												ds_list_find_value(
													_list_enemy,
													ds_list_size(_list_enemy) - 1
												);

										break;

										//-------------//
										//RANDOM TARGET//
										//-------------//
										default:

											_ref_target =
												ds_list_find_value(
													_list_enemy,
													irandom(ds_list_size(_list_enemy) - 1)
												);

										break;
									}
								}
							}

							//--------------------//
							//FRIENDLY SUPPORT CARD//
							//--------------------//
							else{

								_ref_target =
									_ref_beast;

								if (_ref_card._ref_card._str_card_range == "RANGED"){

									if (random(1) < 0.25){

										var _ct_ally =
											ds_list_size(
												_list_beasts_alive
											);

										if (_ct_ally > 1){

											repeat(10){

												var _ref_candidate =
													ds_list_find_value(
														_list_beasts_alive,
														irandom(_ct_ally - 1)
													);

												if (_ref_candidate != _ref_beast){

													_ref_target =
														_ref_candidate;

													break;
												}
											}
										}
									}
								}
							}

							//---------//
							//CAST CARD//
							//---------//
							if (instance_exists(_ref_target)){

								global.ref_cast_card =
									_ref_card;

								global.ref_caster_beast =
									_ref_beast;

								global.ref_target_beast =
									_ref_target;

								scr_cast_card();
							}

						break;


						case "UTILITY":

							_ref_target = _ref_beast;

							if (_ref_card._ref_card._str_card_range == "RANGED"){

								if (random(1) < 0.25){

									var _ct_ally = ds_list_size(_list_beasts_alive);

									if (_ct_ally > 1){

										repeat(10){

											var _ref_candidate = ds_list_find_value(_list_beasts_alive,irandom(_ct_ally - 1));

											if (_ref_candidate != _ref_beast){
												_ref_target = _ref_candidate;
												break;
											}
										}
									}
								}
							}

							global.ref_cast_card = _ref_card;
							global.ref_caster_beast = _ref_beast;
							global.ref_target_beast = _ref_target;

							scr_cast_card();

						break;


						case "DEFENSE":

							_ref_target = _ref_beast;

							if (_ref_card._ref_card._str_card_range == "RANGED"){

								if (random(1) < 0.25){

									var _ct_ally = ds_list_size(_list_beasts_alive);

									if (_ct_ally > 1){

										repeat(10){

											var _ref_candidate = ds_list_find_value(_list_beasts_alive,irandom(_ct_ally - 1));

											if (_ref_candidate != _ref_beast){
												_ref_target = _ref_candidate;
												break;
											}
										}
									}
								}
							}

							global.ref_cast_card = _ref_card;
							global.ref_caster_beast = _ref_beast;
							global.ref_target_beast = _ref_target;

							scr_cast_card();

						break;
					}

					ds_list_delete(_list_casting_units,0);

					_ref_card.visible = false;

					scr_init_battle_wait(30);
				}
				else{

					_ref_card.visible = false;
					ds_list_delete(_list_casting_units,0);

					break;
				}
			}
			else{
				_state_enemy = ENUM_ENEMY_STATE.NEW_CARDS;
				break;
			}
		}

	break;
	#endregion
	
	//
	// NEW CARDS
	//
	#region NEW CARDS
	case ENUM_ENEMY_STATE.NEW_CARDS:

		// ITERATE EACH LIVING ENEMY BEAST'S HAND POSITION
		for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

			var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

			// HIDE OLD CARD
			var _ref_old_card = ds_list_find_value(_ref_beast._list_deck,_ref_beast._val_hand_pos);

			_ref_old_card._flag_card_disabled = false;
			_ref_old_card.visible = false;
			_ref_old_card._str_location = "DECK";

			// ADVANCE HAND POSITION
			_ref_beast._val_hand_pos++;

			if (_ref_beast._val_hand_pos > ds_list_size(_ref_beast._list_deck) - 1){
				_ref_beast._val_hand_pos = 0;
			}

			// SHOW NEW CARD
			var _ref_new_card = ds_list_find_value(_ref_beast._list_deck,_ref_beast._val_hand_pos);

			_ref_new_card._flag_card_disabled = false;
			_ref_new_card.visible = true;
			_ref_new_card._str_location = "HAND";
		}

		_flag_statuses_init = false;
		_flag_cast_init = false;
		_flag_minions_init = false;

		_state_enemy = ENUM_ENEMY_STATE.TURN_END;

	break;
	#endregion
	
	//
	// TURN END
	//
	#region TURN END
	case ENUM_ENEMY_STATE.TURN_END:
		if (!_flag_turn_end_items_init){

			_flag_turn_end_items_init = true;

			//----------------//
			//HEAL MINIONS//
			//----------------//
			scr_heal_minions(
				_list_beasts_alive
			);

			_list_turn_end_items = ds_list_create();

		for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

			var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			var _stct_item = _ref_beast._stct_held_item;

			if (_stct_item == undefined || _stct_item == "EMPTY"){
				continue;
			}

			if (_stct_item._str_item_trigger_type != "TURN_END"){
				continue;
			}

			var _stct_trigger = {
				_ref_beast : _ref_beast,
				_stct_item : _stct_item
			};

			ds_list_add(_list_turn_end_items,_stct_trigger);
		}
	}

	//-----------------------//
	//EXECUTE HELD ITEM QUEUE//
	//-----------------------//
	if (
		_flag_turn_end_items_init &&
		!_flag_turn_end_items_complete &&
		!instance_exists(obj_wait)
	){

		if (ds_list_size(_list_turn_end_items) > 0){

			var _stct_trigger = ds_list_find_value(_list_turn_end_items,0);

			var _ref_beast = _stct_trigger._ref_beast;
			var _stct_item = _stct_trigger._stct_item;

			if (
				instance_exists(_ref_beast) &&
				_stct_item != undefined &&
				_stct_item._scr_item != undefined
			){

				var _flag_triggered = script_execute(
					_stct_item._scr_item,
					"TRIGGER",
					_stct_item,
					_ref_beast
				);

				if (
					_flag_triggered &&
					_stct_item._flag_consumed_on_trigger
				){
					_ref_beast._stct_held_item = "EMPTY";
				}
			}

			ds_list_delete(_list_turn_end_items,0);

			scr_init_battle_wait(60);
		}
		else{

			ds_list_destroy(_list_turn_end_items);
			_list_turn_end_items = undefined;

			_flag_turn_end_items_complete = true;
		}
	}
		if (_flag_turn_end_items_complete && !_flag_statuses_init){

			_flag_statuses_init = true;

			_list_statuses = ds_list_create();

			// BUILD STATUS QUEUE
			for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

				var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

				for (var _it_status = 0; _it_status < ds_list_size(_ref_beast._list_statuses); _it_status++){

					ds_list_add(
						_list_statuses,
						ds_list_find_value(_ref_beast._list_statuses,_it_status)
					);
				}
			}
		}

		if (_flag_statuses_init && !instance_exists(obj_wait)){

			if (ds_list_size(_list_statuses) > 0){

				var _ref_status = ds_list_find_value(_list_statuses,0);

				if (instance_exists(_ref_status)){

					if (_ref_status._str_trigger_region == "END"){
						_ref_status._str_status_command = "REPEAT";
					}

					ds_list_delete(_list_statuses,0);

					scr_init_battle_wait(10);
				}
				else{
					ds_list_delete(_list_statuses,0);
				}
			}
			else{

				ds_list_destroy(_list_statuses);
				_list_statuses = undefined;

				_flag_statuses_init = false;

				_state_enemy = ENUM_ENEMY_STATE.WAIT;

				obj_battle_turn_controller.hscr_pass_turn();
			}
		}

	break;
	#endregion
}