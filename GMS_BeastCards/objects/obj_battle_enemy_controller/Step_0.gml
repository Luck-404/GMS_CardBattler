//===============================================================================//
//
// STEP: OBJ_BATTLE_ENEMY_CONTROLLER
// FUNCTION: Executes the enemy battle state machine.
//           Initializes enemy Beasts/Cards, processes turn-start effects,
//           resolves Minions and enemy Card casts, rotates Cards,
//           resolves turn-end effects, and passes turn control.
//
//===============================================================================//

switch(_state_enemy){

	//
	// INIT BEASTS
	//
	#region INIT BEASTS
	case ENUM_ENEMY_STATE.INIT_BEASTS:

		//----------------//
		//DEBUG INIT START//
		//----------------//
		scr_debug_log(
			"BATTLE",
			"ENEMY",
			self,
			"INITIALIZING ENEMY BEASTS | REQUESTED: " + string(_ct_beasts),
			"INIT",
			"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
		);

		for (var _it_beast = 0; _it_beast < _ct_beasts; _it_beast++){

			//-------------------//
			//CREATE BEAST STRUCT//
			//-------------------//
			var _stct_enemy_unit = undefined;
			var _flag_forced_enemy = false;

			if (
				_it_beast == 0 &&
				variable_global_exists("stct_forced_enemy_unit") &&
				is_struct(global.stct_forced_enemy_unit)
			){

				_stct_enemy_unit = global.stct_forced_enemy_unit;
				global.stct_forced_enemy_unit = undefined;

				_flag_forced_enemy = true;
			}
			else{
				_stct_enemy_unit = scr_beast_get_random(global.arr_last_enemy_pool);
			}

			//----------------//
			//VALIDATE BEAST//
			//----------------//
			if (!is_struct(_stct_enemy_unit)){

				scr_debug_log(
					"BATTLE",
					"ENEMY",
					undefined,
					"ENEMY BATTLE INIT FAILED | INVALID BEAST STRUCT | INDEX: " + string(_it_beast),
					"ERROR",
					"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
				);

				continue;
			}

			//------------------//
			//ROLL ENEMY LEVEL//
			//------------------//
			var _val_enemy_level = irandom_range(_val_enemy_level_min,_val_enemy_level_max);

			if (!scr_beast_set_level(_stct_enemy_unit,_val_enemy_level,true)){

				scr_debug_log(
					"BATTLE",
					"ENEMY",
					_stct_enemy_unit,
					"ENEMY BATTLE INIT FAILED | COULD NOT SET LEVEL: " + string(_val_enemy_level),
					"ERROR",
					"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
				);

				continue;
			}

			//=====================//
			//CALCULATE EXPECTED HP//
			//=====================//
			var _val_expected_max_hp = scr_beast_get_max_hp(
				_stct_enemy_unit._val_beast_hp_stat,
				_stct_enemy_unit._val_beast_level
			);

			//---------------------//
			//VALIDATE MAXIMUM HP//
			//---------------------//
			if (_val_expected_max_hp <= 0){

				scr_debug_log(
					"BATTLE",
					"ENEMY",
					_stct_enemy_unit,
					"ENEMY BATTLE INIT FAILED | INVALID EXPECTED MAX HP: " + string(_val_expected_max_hp),
					"ERROR",
					"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
				);

				continue;
			}

			//==================//
			//VERIFY LEVEL HP//
			//==================//
			if (_stct_enemy_unit._val_beast_hp_max != _val_expected_max_hp){

				scr_debug_log(
					"BEAST",
					"LEVEL",
					_stct_enemy_unit,
					"ENEMY HP MISMATCH CORRECTED" +
					" | BEAST: " + string_upper(_stct_enemy_unit._str_beast_name) +
					" | LEVEL: " + string(_stct_enemy_unit._val_beast_level) +
					" | EXISTING MAX HP: " + string(_stct_enemy_unit._val_beast_hp_max) +
					" | EXPECTED MAX HP: " + string(_val_expected_max_hp),
					"WARNING",
					"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
				);
			}

			//================//
			//SET ENEMY HP//
			//================//
			_stct_enemy_unit._val_beast_hp_max = _val_expected_max_hp;
			_stct_enemy_unit._val_beast_hp_cur = _val_expected_max_hp;

			//---------------//
			//UPDATE LOGBOOK//
			//---------------//
			if (variable_global_exists("map_logbook_beasts")){
				scr_logbook_mark_beast_seen(_stct_enemy_unit._str_beast_name);
			}

			//--------------------//
			//CREATE BATTLE BEAST//
			//--------------------//
			var _ref_enemy_beast = instance_create_layer(
				room_width * 0.5 + 80 + (100 * _it_beast),
				room_height * 0.5,
				"ily_player",
				obj_battle_beast
			);

			//--------------------//
			//TRANSFER BEAST DATA//
			//--------------------//
			_ref_enemy_beast._spr_beast = _stct_enemy_unit._spr_beast;
			_ref_enemy_beast._ref_unit = _stct_enemy_unit;
			_ref_enemy_beast._stct_held_item = _stct_enemy_unit._stct_beast_held_item;

			_ref_enemy_beast._str_team = "ENEMY";
			_ref_enemy_beast._uid_beast = _stct_enemy_unit._uid_beast;

			_ref_enemy_beast._snd_cry = _stct_enemy_unit._snd_beast_cry;
			_ref_enemy_beast._snd_death = _stct_enemy_unit._snd_beast_death;

			_ref_enemy_beast._val_pos = _it_beast;

			//-----------------------//
			//TRANSFER COMBAT STATS//
			//-----------------------//
			_ref_enemy_beast._ct_minions_max = _stct_enemy_unit._val_beast_min_stat;

			_ref_enemy_beast._val_crit_chance = _stct_enemy_unit._val_beast_crit_stat;
			_ref_enemy_beast._val_crit_damage = _stct_enemy_unit._val_beast_crit_dmg_stat;

			_ref_enemy_beast._val_cur_hp = _stct_enemy_unit._val_beast_hp_cur;
			_ref_enemy_beast._val_max_hp = _stct_enemy_unit._val_beast_hp_max;

			_ref_enemy_beast._val_speed_base = _stct_enemy_unit._val_beast_speed_stat;

			//-------------//
			//TRACK BEAST//
			//-------------//
			ds_list_add(_list_beasts,_ref_enemy_beast);
			ds_list_add(_list_beasts_alive,_ref_enemy_beast);

			//------------------//
			//DEBUG BEAST READY//
			//------------------//
			scr_debug_log(
				"BEAST",
				"ENEMY",
				_ref_enemy_beast,
				"ENEMY BEAST INITIALIZED | SOURCE: " + (_flag_forced_enemy ? "FORCED" : "RANDOM") +
				" | LVL " + string(_stct_enemy_unit._val_beast_level) +
				" | HP: " + string(_ref_enemy_beast._val_cur_hp) +
				"/" + string(_ref_enemy_beast._val_max_hp) +
				" | BREED: " + string_upper(string(_stct_enemy_unit._str_beast_breed)) +
				" | TYPE: " + string_upper(string(_stct_enemy_unit._str_beast_color_type)) +
				" | POSITION: " + string(_it_beast),
				"INIT",
				"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
			);
		}

		//--------------------//
		//DEBUG BEAST SUMMARY//
		//--------------------//
		scr_debug_log(
			"BATTLE",
			"ENEMY",
			self,
			"ENEMY BEAST INITIALIZATION COMPLETE | ACTIVE: " + string(ds_list_size(_list_beasts_alive)) +
			" | REQUESTED: " + string(_ct_beasts),
			"INIT",
			"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
		);

		_state_enemy = ENUM_ENEMY_STATE.INIT_CARDS;

	break;
	#endregion

	//
	// INIT CARDS
	//
	#region INIT CARDS
	case ENUM_ENEMY_STATE.INIT_CARDS:

		var _ct_enemy_cards_total = 0;

		//----------------//
		//DEBUG INIT START//
		//----------------//
		scr_debug_log(
			"BATTLE",
			"ENEMY",
			self,
			"INITIALIZING ENEMY CARDS | BEASTS: " + string(ds_list_size(_list_beasts_alive)),
			"INIT",
			"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
		);

		//-------------------//
		//BUILD BEAST DECKS//
		//-------------------//
		for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

			var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

			if (!instance_exists(_ref_beast)){

				scr_debug_log(
					"BATTLE",
					"ENEMY",
					undefined,
					"ENEMY CARD INIT FAILED | INVALID BEAST INSTANCE | INDEX: " + string(_it_beast),
					"ERROR",
					"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
				);

				continue;
			}

			if (!is_struct(_ref_beast._ref_unit)){

				scr_debug_log(
					"BATTLE",
					"ENEMY",
					_ref_beast,
					"ENEMY CARD INIT FAILED | INVALID BEAST STRUCT",
					"ERROR",
					"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
				);

				continue;
			}

			var _stct_unit = _ref_beast._ref_unit;

			//------------//
			//BUILD DECK//
			//------------//
			var _list_deck = scr_beast_get_deck(
				_stct_unit._str_beast_name,
				_stct_unit._str_beast_color_type
			);

			if (!ds_exists(_list_deck,ds_type_list)){

				scr_debug_log(
					"BATTLE",
					"ENEMY",
					_ref_beast,
					"ENEMY CARD INIT FAILED | INVALID DECK",
					"ERROR",
					"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
				);

				continue;
			}

			var _ct_deck_cards = ds_list_size(_list_deck);
			var _str_deck_cards = "";

			//---------------------//
			//CREATE CARD INSTANCES//
			//---------------------//
			for (var _it_card = 0; _it_card < _ct_deck_cards; _it_card++){

				var _stct_card = ds_list_find_value(_list_deck,_it_card);

				if (!is_struct(_stct_card)){

					scr_debug_log(
						"BATTLE",
						"ENEMY",
						_ref_beast,
						"ENEMY CARD INIT FAILED | INVALID CARD STRUCT | DECK INDEX: " + string(_it_card),
						"ERROR",
						"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
					);

					continue;
				}

				//----------------//
				//BUILD DECK TEXT//
				//----------------//
				if (_str_deck_cards != ""){
					_str_deck_cards += ", ";
				}

				_str_deck_cards += string_upper(string(_stct_card._str_card_name));

				//----------------//
				//CREATE CARD//
				//----------------//
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

				_ct_enemy_cards_total++;
			}

			//----------------------//
			//DESTROY TEMPORARY DECK//
			//----------------------//
			ds_list_destroy(_list_deck);

			//-------------//
			//SHUFFLE DECK//
			//-------------//
			ds_list_shuffle(_ref_beast._list_deck);

			//----------------//
			//DRAW FIRST CARD//
			//----------------//
			_ref_beast._val_hand_pos = 0;

			var _str_active_card = "NONE";

			if (ds_list_size(_ref_beast._list_deck) > 0){

				var _ref_first_card = ds_list_find_value(
					_ref_beast._list_deck,
					_ref_beast._val_hand_pos
				);

				if (instance_exists(_ref_first_card)){

					_ref_first_card._str_location = "HAND";

					if (is_struct(_ref_first_card._ref_card)){
						_str_active_card = string_upper(string(_ref_first_card._ref_card._str_card_name));
					}
				}
			}

			//----------------//
			//DEBUG BEAST DECK//
			//----------------//
			scr_debug_log(
				"CARDS",
				"ENEMY_DECK",
				_ref_beast,
				"ENEMY DECK INITIALIZED | CARDS: " + string(ds_list_size(_ref_beast._list_deck)) +
				" | ACTIVE: " + _str_active_card +
				" | DECK: " + _str_deck_cards,
				"INIT",
				"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
			);
		}

		//---------------------//
		//DEBUG INIT COMPLETE//
		//---------------------//
		scr_debug_log(
			"BATTLE",
			"ENEMY",
			self,
			"ENEMY BATTLE INITIALIZATION COMPLETE | BEASTS: " + string(ds_list_size(_list_beasts_alive)) +
			" | CARDS: " + string(_ct_enemy_cards_total),
			"INIT",
			"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
		);

		_state_enemy = ENUM_ENEMY_STATE.WAIT;

	break;
	#endregion

	//
	// WAIT
	//
	#region WAIT
	case ENUM_ENEMY_STATE.WAIT:

		//------------------//
		//TURN START ITEMS//
		//------------------//
		_flag_turn_start_items_init = false;
		_flag_turn_start_items_complete = false;

		//----------------//
		//TURN END ITEMS//
		//----------------//
		_flag_turn_end_items_init = false;
		_flag_turn_end_items_complete = false;

		//----------------------------//
		//STATUSES / CASTING / MINIONS//
		//----------------------------//
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

		//--------------------------//
		//BANISHED TEAM TURN SAFETY//
		//--------------------------//
		if (
			ds_list_size(_list_beasts_alive) <= 0 &&
			scr_battle_has_team_combatants("ENEMY")
		){

			_state_enemy = ENUM_ENEMY_STATE.WAIT;

			obj_battle_turn_controller.hscr_battle_pass_turn();

			break;
		}

		//-----------------------//
		//BUILD HELD ITEM QUEUE//
		//-----------------------//
		if (!_flag_turn_start_items_init){

			_flag_turn_start_items_init = true;
			_list_turn_start_items = ds_list_create();

			//---------------//
			//DEGRADE ARMOR//
			//---------------//
			for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

				var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				scr_battle_degrade_armor(_ref_beast);
			}

			//-----------------------//
			//BUILD TURN START QUEUE//
			//-----------------------//
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
			!instance_exists(obj_battle_wait)
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

					scr_gui_spawn_popup_trigger_banner(_stct_item._str_item_name);

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

				scr_battle_init_wait(90);
			}
			else{

				ds_list_destroy(_list_turn_start_items);
				_list_turn_start_items = undefined;

				_flag_turn_start_items_complete = true;
			}
		}

		//-------------------//
		//BUILD STATUS QUEUE//
		//-------------------//
		if (_flag_turn_start_items_complete && !_flag_statuses_init){

			_flag_statuses_init = true;
			_list_statuses = ds_list_create();

			for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

				var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

				if (!instance_exists(_ref_beast)){
					continue;
				}

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
		if (_flag_statuses_init && !instance_exists(obj_battle_wait)){

			if (ds_list_size(_list_statuses) > 0){

				var _ref_status = ds_list_find_value(_list_statuses,0);

				if (instance_exists(_ref_status)){

					if (_ref_status._str_trigger_region == "START"){
						_ref_status._str_status_command = "REPEAT";
					}

					ds_list_delete(_list_statuses,0);

					scr_battle_init_wait(20);
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

		//-------------------//
		//BUILD MINION QUEUE//
		//-------------------//
		if (!_flag_minions_init){

			_flag_minions_init = true;

			_list_casting_minions = scr_minion_build_speed_queue(_list_beasts_alive);
		}

		//---------------------//
		//EXECUTE MINION QUEUE//
		//---------------------//
		if (_flag_minions_init && !instance_exists(obj_battle_wait)){

			if (ds_list_size(_list_casting_minions) > 0){

				var _ref_minion = ds_list_find_value(_list_casting_minions,0);

				if (instance_exists(_ref_minion)){
					scr_minion_cast_effect(_ref_minion);
				}

				ds_list_delete(_list_casting_minions,0);

				scr_battle_init_wait(30);
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

		//------------------//
		//BUILD CAST QUEUE//
		//------------------//
		if (!_flag_cast_init){

			_flag_cast_init = true;
			_list_casting_beasts = ds_list_create();

			for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

				var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

				if (instance_exists(_ref_beast)){
					ds_list_add(_list_casting_beasts,_ref_beast);
				}
			}
		}

		//--------------------//
		//EXECUTE CAST QUEUE//
		//--------------------//
		if (_flag_cast_init && !instance_exists(obj_battle_wait)){

			if (ds_list_size(_list_casting_beasts) > 0){

				var _ref_beast = ds_list_find_value(_list_casting_beasts,0);

				if (!instance_exists(_ref_beast)){

					ds_list_delete(_list_casting_beasts,0);

					break;
				}

				obj_battle_player_controller.hscr_battle_check_beast_able(_list_beasts_alive);

				//----------------//
				//GET ACTIVE CARD//
				//----------------//
				if (ds_list_size(_ref_beast._list_deck) <= 0){

					ds_list_delete(_list_casting_beasts,0);

					break;
				}

				var _ref_card = ds_list_find_value(
					_ref_beast._list_deck,
					_ref_beast._val_hand_pos
				);

				if (!instance_exists(_ref_card)){

					ds_list_delete(_list_casting_beasts,0);

					break;
				}

				if (!is_struct(_ref_card._ref_card)){

					_ref_card.visible = false;
					ds_list_delete(_list_casting_beasts,0);

					break;
				}

				//--------------------//
				//DISABLED ENEMY CARD//
				//--------------------//
				if (_ref_card._flag_card_disabled){

					scr_gui_spawn_popup_scrolling(
						"TEXT",
						"CARD DISABLED",
						undefined,
						c_black,
						_ref_beast.x,
						_ref_beast.y - 72
					);

					audio_play_sound(snd_battle_expend,0,false);

					_ref_card.visible = false;

					ds_list_delete(_list_casting_beasts,0);

					scr_battle_init_wait(30);

					break;
				}

				//----------------//
				//BEAST CAN ACT//
				//----------------//
				if (_ref_beast._flag_beast_able_check){

					var _stct_card = _ref_card._ref_card;
					var _str_card_type = _stct_card._str_card_type;
					var _ref_target = undefined;

					switch(_str_card_type){

						//--------//
						//ATTACK//
						//--------//
						case "ATTACK":

							//--------------------//
							//INVALID ENEMY RANGE//
							//--------------------//
							if (
								_stct_card._str_card_range == "BACK" ||
								_stct_card._str_card_range == "FLANK"
							){

								scr_gui_spawn_popup_scrolling(
									"TEXT",
									"NO VALID TARGET",
									undefined,
									c_ltgray,
									_ref_beast.x,
									_ref_beast.y - 72
								);

								break;
							}

							//----------------//
							//GET PLAYER TEAM//
							//----------------//
							var _list_enemy = obj_battle_player_controller._list_beasts_alive;

							if (ds_list_size(_list_enemy) > 0){

								_ref_target = ds_list_find_value(_list_enemy,0);

								//---------//
								//CAST CARD//
								//---------//
								if (instance_exists(_ref_target)){

									global.ref_cast_card = _ref_card;
									global.ref_caster_beast = _ref_beast;
									global.ref_target_beast = _ref_target;

									scr_battle_cast_card();
								}
							}

						break;

						//---------//
						//SUPPORT//
						//---------//
						case "SUPPORT":

							var _str_effect_type = _stct_card._str_card_effect_type;

							//---------------------//
							//HOSTILE SUPPORT CARD//
							//---------------------//
							if (
								_str_effect_type == "CC" ||
								_str_effect_type == "DEBUFF"
							){

								var _list_enemy = obj_battle_player_controller._list_beasts_alive;

								if (ds_list_size(_list_enemy) > 0){
									_ref_target = ds_list_find_value(_list_enemy,0);
								}
							}

							//----------------------//
							//FRIENDLY SUPPORT CARD//
							//----------------------//
							else{

								_ref_target = _ref_beast;

								if (_stct_card._str_card_range == "RANGED" && random(1) < 0.25){

									var _ct_allies = ds_list_size(_list_beasts_alive);

									if (_ct_allies > 1){

										repeat(10){

											var _ref_candidate = ds_list_find_value(
												_list_beasts_alive,
												irandom(_ct_allies - 1)
											);

											if (_ref_candidate != _ref_beast){

												_ref_target = _ref_candidate;

												break;
											}
										}
									}
								}
							}

							//---------//
							//CAST CARD//
							//---------//
							if (instance_exists(_ref_target)){

								global.ref_cast_card = _ref_card;
								global.ref_caster_beast = _ref_beast;
								global.ref_target_beast = _ref_target;

								scr_battle_cast_card();
							}

						break;

						//---------//
						//UTILITY//
						//---------//
						case "UTILITY":

							var _str_effect_type = _stct_card._str_card_effect_type;
							var _str_card_id = _stct_card._str_card_id;

							//----------------//
							//HOSTILE TRAP//
							//----------------//
							if (
								_str_effect_type == "TRAP" &&
								_str_card_id != "DISTRACTING_TRAP"
							){

								var _list_enemy = obj_battle_player_controller._list_beasts_alive;

								if (ds_list_size(_list_enemy) > 0){
									_ref_target = ds_list_find_value(_list_enemy,0);
								}
							}

							//------------------//
							//FRIENDLY UTILITY//
							//------------------//
							else{

								_ref_target = _ref_beast;

								if (_stct_card._str_card_range == "RANGED" && random(1) < 0.25){

									var _ct_allies = ds_list_size(_list_beasts_alive);

									if (_ct_allies > 1){

										repeat(10){

											var _ref_candidate = ds_list_find_value(
												_list_beasts_alive,
												irandom(_ct_allies - 1)
											);

											if (_ref_candidate != _ref_beast){

												_ref_target = _ref_candidate;

												break;
											}
										}
									}
								}
							}

							//---------//
							//CAST CARD//
							//---------//
							if (instance_exists(_ref_target)){

								global.ref_cast_card = _ref_card;
								global.ref_caster_beast = _ref_beast;
								global.ref_target_beast = _ref_target;

								scr_battle_cast_card();
							}

						break;

						//---------//
						//DEFENSE//
						//---------//
						case "DEFENSE":

							_ref_target = _ref_beast;

							if (_stct_card._str_card_range == "RANGED" && random(1) < 0.25){

								var _ct_allies = ds_list_size(_list_beasts_alive);

								if (_ct_allies > 1){

									repeat(10){

										var _ref_candidate = ds_list_find_value(
											_list_beasts_alive,
											irandom(_ct_allies - 1)
										);

										if (_ref_candidate != _ref_beast){

											_ref_target = _ref_candidate;

											break;
										}
									}
								}
							}

							global.ref_cast_card = _ref_card;
							global.ref_caster_beast = _ref_beast;
							global.ref_target_beast = _ref_target;

							scr_battle_cast_card();

						break;
					}

					//----------------//
					//FINISH BEAST CAST//
					//----------------//
					ds_list_delete(_list_casting_beasts,0);

					_ref_card.visible = false;

					scr_battle_init_wait(30);
				}

				//----------------//
				//BEAST CANNOT ACT//
				//----------------//
				else{

					_ref_card.visible = false;

					ds_list_delete(_list_casting_beasts,0);

					break;
				}
			}
			else{

				ds_list_destroy(_list_casting_beasts);
				_list_casting_beasts = undefined;

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

		//-------------------//
		//ROTATE ENEMY CARDS//
		//-------------------//
		for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

			var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			var _ct_cards = ds_list_size(_ref_beast._list_deck);

			if (_ct_cards <= 0){
				continue;
			}

			//---------------//
			//HIDE OLD CARD//
			//---------------//
			var _ref_old_card = ds_list_find_value(
				_ref_beast._list_deck,
				_ref_beast._val_hand_pos
			);

			if (instance_exists(_ref_old_card)){

				_ref_old_card._flag_card_disabled = false;
				_ref_old_card.visible = false;
				_ref_old_card._str_location = "DECK";
			}

			//---------------------//
			//ADVANCE HAND POSITION//
			//---------------------//
			_ref_beast._val_hand_pos++;

			if (_ref_beast._val_hand_pos >= _ct_cards){
				_ref_beast._val_hand_pos = 0;
			}

			//---------------//
			//SHOW NEW CARD//
			//---------------//
			var _ref_new_card = ds_list_find_value(
				_ref_beast._list_deck,
				_ref_beast._val_hand_pos
			);

			if (instance_exists(_ref_new_card)){

				_ref_new_card._flag_card_disabled = false;
				_ref_new_card.visible = true;
				_ref_new_card._str_location = "HAND";
			}
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

		//-----------------------//
		//BUILD HELD ITEM QUEUE//
		//-----------------------//
		if (!_flag_turn_end_items_init){

			_flag_turn_end_items_init = true;

			//--------------//
			//HEAL MINIONS//
			//--------------//
			scr_minion_heal_all(_list_beasts_alive);

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
			!instance_exists(obj_battle_wait)
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

				scr_battle_init_wait(90);
			}
			else{

				ds_list_destroy(_list_turn_end_items);
				_list_turn_end_items = undefined;

				_flag_turn_end_items_complete = true;
			}
		}

		//-------------------//
		//BUILD STATUS QUEUE//
		//-------------------//
		if (_flag_turn_end_items_complete && !_flag_statuses_init){

			_flag_statuses_init = true;
			_list_statuses = ds_list_create();

			for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

				var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

				if (!instance_exists(_ref_beast)){
					continue;
				}

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
		if (_flag_statuses_init && !instance_exists(obj_battle_wait)){

			if (ds_list_size(_list_statuses) > 0){

				var _ref_status = ds_list_find_value(_list_statuses,0);

				if (instance_exists(_ref_status)){

					if (_ref_status._str_trigger_region == "END"){
						_ref_status._str_status_command = "REPEAT";
					}

					ds_list_delete(_list_statuses,0);

					scr_battle_init_wait(20);
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

				obj_battle_turn_controller.hscr_battle_pass_turn();
			}
		}

	break;
	#endregion
}