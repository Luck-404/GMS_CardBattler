//===============================================================================//
//
// STEP: OBJ_BATTLE_ENEMY_CONTROLLER
// FUNCTION: Executes the enemy battle state machine.
//           Initializes enemy Beasts/Cards, processes turn-start effects,
//           resolves Minions and enemy Card casts, rotates Cards,
//           resolves turn-end effects, and passes turn control.
//
//===============================================================================//

//================//
//CHEATS GUI LOCK//
//================//
if (
	instance_exists(global.ref_active_gui) &&
	variable_instance_exists(global.ref_active_gui,"_str_type") &&
	global.ref_active_gui._str_type == "CHEATS"
){
	exit;
}

//===================//
//PRE-BATTLE SAFETY//
//===================//
if (
	instance_exists(obj_battle_turn_controller) &&
	!obj_battle_turn_controller._flag_started_game
){

	if (
		_state_enemy != ENUM_ENEMY_STATE.INIT_BEASTS &&
		_state_enemy != ENUM_ENEMY_STATE.INIT_CARDS
	){

		_state_enemy =
			ENUM_ENEMY_STATE.WAIT;

		exit;
	}
}

switch(_state_enemy){

	//
	// INIT BEASTS
	//
	#region INIT BEASTS
	case ENUM_ENEMY_STATE.INIT_BEASTS:

		scr_debug_log(
			"BATTLE",
			"ENEMY",
			self,
			"INITIALIZING ENEMY BEASTS | REQUESTED: " +
			string(_ct_beasts),
			"INIT",
			"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
		);

		//====================//
		//ROLL ENEMY ROSTER//
		//====================//
		var _arr_enemy_units = [];

		for (
			var _it_beast = 0;
			_it_beast < _ct_beasts;
			_it_beast++
		){

			var _stct_enemy_unit =
				undefined;

			var _flag_forced_enemy =
				false;

			if (
				_it_beast == 0 &&
				variable_global_exists("stct_forced_enemy_unit") &&
				is_struct(global.stct_forced_enemy_unit)
			){

				_stct_enemy_unit =
					global.stct_forced_enemy_unit;

				global.stct_forced_enemy_unit =
					undefined;

				_flag_forced_enemy =
					true;
			}
			else{

				_stct_enemy_unit =
					scr_beast_get_random(
						global.arr_last_enemy_pool
					);
			}

			if (!is_struct(_stct_enemy_unit)){

				scr_debug_log(
					"BATTLE",
					"ENEMY",
					undefined,
					"ENEMY BATTLE INIT FAILED | INVALID BEAST STRUCT | ROLL: " +
					string(_it_beast),
					"ERROR",
					"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
				);

				continue;
			}

			var _val_enemy_level =
				undefined;

			if (is_struct(_stct_encounter_scaling)){

				_val_enemy_level =
					scr_encounter_roll_enemy_level(
						_stct_encounter_scaling
					);
			}

			if (
				_val_enemy_level == undefined ||
				!is_real(_val_enemy_level)
			){

				_val_enemy_level =
					irandom_range(
						_val_enemy_level_min,
						_val_enemy_level_max
					);
			}

			if (
				!scr_beast_set_level(
					_stct_enemy_unit,
					_val_enemy_level,
					true
				)
			){

				scr_debug_log(
					"BATTLE",
					"ENEMY",
					_stct_enemy_unit,
					"ENEMY BATTLE INIT FAILED | COULD NOT SET LEVEL: " +
					string(_val_enemy_level),
					"ERROR",
					"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
				);

				continue;
			}

			var _val_expected_max_hp =
				scr_beast_get_max_hp(
					_stct_enemy_unit._val_beast_hp_stat,
					_stct_enemy_unit._val_beast_level
				);

			if (_val_expected_max_hp <= 0){

				scr_debug_log(
					"BATTLE",
					"ENEMY",
					_stct_enemy_unit,
					"ENEMY BATTLE INIT FAILED | INVALID EXPECTED MAX HP: " +
					string(_val_expected_max_hp),
					"ERROR",
					"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
				);

				continue;
			}

			if (
				_stct_enemy_unit._val_beast_hp_max !=
				_val_expected_max_hp
			){

				scr_debug_log(
					"BEAST",
					"LEVEL",
					_stct_enemy_unit,
					"ENEMY HP MISMATCH CORRECTED" +
					" | BEAST: " +
					string_upper(_stct_enemy_unit._str_beast_name) +
					" | LEVEL: " +
					string(_stct_enemy_unit._val_beast_level) +
					" | EXISTING MAX HP: " +
					string(_stct_enemy_unit._val_beast_hp_max) +
					" | EXPECTED MAX HP: " +
					string(_val_expected_max_hp),
					"WARNING",
					"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
				);
			}

			_stct_enemy_unit._val_beast_hp_max =
				_val_expected_max_hp;

			_stct_enemy_unit._val_beast_hp_cur =
				_val_expected_max_hp;

			if (
				variable_global_exists(
					"map_logbook_beasts"
				)
			){

				scr_logbook_mark_beast_seen(
					_stct_enemy_unit._str_beast_name
				);
			}

			array_push(
				_arr_enemy_units,
				{
					_stct_unit : _stct_enemy_unit,
					_flag_forced : _flag_forced_enemy,
					_val_formation_priority : scr_beast_get_formation_priority(
						_stct_enemy_unit
					),
					_it_roll : _it_beast
				}
			);
		}

		//======================//
		//SORT FORMATION ROLES//
		//======================//
		/*
			Lower priority values prefer the front.

			FL = 0
			MF = 1
			C  = 2
			MB = 3
			BL = 4

			This is a stable insertion sort. Equal-priority Beasts retain their
			random encounter-roll order, so role preference never dictates exact
			composition or creates a hard class quota.
		*/

		for (
			var _it_sort = 1;
			_it_sort < array_length(_arr_enemy_units);
			_it_sort++
		){

			var _stct_sort_entry =
				_arr_enemy_units[_it_sort];

			var _it_insert =
				_it_sort - 1;

			while (
				_it_insert >= 0 &&
				_arr_enemy_units[_it_insert]
					._val_formation_priority >
				_stct_sort_entry
					._val_formation_priority
			){

				_arr_enemy_units[_it_insert + 1] =
					_arr_enemy_units[_it_insert];

				_it_insert--;
			}

			_arr_enemy_units[_it_insert + 1] =
				_stct_sort_entry;
		}

		//====================//
		//SPAWN SORTED ROSTER//
		//====================//
		for (
			var _it_spawn = 0;
			_it_spawn < array_length(_arr_enemy_units);
			_it_spawn++
		){

			var _stct_enemy_entry =
				_arr_enemy_units[_it_spawn];

			var _stct_enemy_unit =
				_stct_enemy_entry._stct_unit;

			var _ref_enemy_beast =
				instance_create_layer(
					room_width * 0.5 +
						80 +
						(100 * _it_spawn),
					room_height * 0.5,
					"ily_player",
					obj_battle_beast
				);

			_ref_enemy_beast._spr_beast =
				_stct_enemy_unit._spr_beast;

			_ref_enemy_beast._ref_unit =
				_stct_enemy_unit;

			_ref_enemy_beast._stct_held_item =
				_stct_enemy_unit._stct_beast_held_item;

			_ref_enemy_beast._str_team = "ENEMY";

			_ref_enemy_beast._uid_beast =
				_stct_enemy_unit._uid_beast;

			_ref_enemy_beast._snd_cry =
				_stct_enemy_unit._snd_beast_cry;

			_ref_enemy_beast._snd_death =
				_stct_enemy_unit._snd_beast_death;

			_ref_enemy_beast._val_pos =
				_it_spawn;

			_ref_enemy_beast._ct_minions_max =
				_stct_enemy_unit._val_beast_min_stat;

			_ref_enemy_beast._val_crit_chance =
				_stct_enemy_unit._val_beast_crit_stat;

			_ref_enemy_beast._val_crit_damage =
				_stct_enemy_unit._val_beast_crit_dmg_stat;

			_ref_enemy_beast._val_cur_hp =
				_stct_enemy_unit._val_beast_hp_cur;

			_ref_enemy_beast._val_max_hp =
				_stct_enemy_unit._val_beast_hp_max;

			_ref_enemy_beast._val_speed_base =
				_stct_enemy_unit._val_beast_speed_stat;

			ds_list_add(
				_list_beasts,
				_ref_enemy_beast
			);

			ds_list_add(
				_list_beasts_alive,
				_ref_enemy_beast
			);

			scr_debug_log(
				"BEAST",
				"ENEMY",
				_ref_enemy_beast,
				"ENEMY BEAST INITIALIZED | SOURCE: " +
				(_stct_enemy_entry._flag_forced ? "FORCED" : "RANDOM") +
				" | LVL " +
				string(_stct_enemy_unit._val_beast_level) +
				" | HP: " +
				string(_ref_enemy_beast._val_cur_hp) +
				"/" +
				string(_ref_enemy_beast._val_max_hp) +
				" | BREED: " +
				string_upper(
					string(_stct_enemy_unit._str_beast_breed)
				) +
				" | TYPE: " +
				string_upper(
					string(_stct_enemy_unit._str_beast_color_type)
				) +
				" | ROLL: " +
				string(_stct_enemy_entry._it_roll) +
				" | FORMATION PRIORITY: " +
				string(_stct_enemy_entry._val_formation_priority) +
				" | POSITION: " +
				string(_it_spawn),
				"INIT",
				"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
			);
		}

		scr_debug_log(
			"BATTLE",
			"ENEMY",
			self,
			"ENEMY BEAST INITIALIZATION COMPLETE | ACTIVE: " +
			string(ds_list_size(_list_beasts_alive)) +
			" | REQUESTED: " +
			string(_ct_beasts) +
			" | FORMATION SORTED: YES",
			"INIT",
			"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
		);

		_state_enemy =
			ENUM_ENEMY_STATE.INIT_CARDS;

	break;
	#endregion

	//
	// INIT CARDS
	//
	#region INIT CARDS
	case ENUM_ENEMY_STATE.INIT_CARDS:

		var _ct_enemy_cards_total = 0;

		scr_debug_log(
			"BATTLE",
			"ENEMY",
			self,
			"INITIALIZING ENEMY CARDS | BEASTS: " +
			string(ds_list_size(_list_beasts_alive)),
			"INIT",
			"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
		);

		for (
			var _it_beast = 0;
			_it_beast < ds_list_size(_list_beasts_alive);
			_it_beast++
		){

			var _ref_beast =
				ds_list_find_value(
					_list_beasts_alive,
					_it_beast
				);

			if (!instance_exists(_ref_beast)){

				scr_debug_log(
					"BATTLE",
					"ENEMY",
					undefined,
					"ENEMY CARD INIT FAILED | INVALID BEAST INSTANCE | INDEX: " +
					string(_it_beast),
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

			var _stct_unit =
				_ref_beast._ref_unit;

			var _arr_deck =
				scr_beast_get_deck(
					_stct_unit._str_beast_name,
					_stct_unit._str_beast_color_type
				);

			if (!is_array(_arr_deck)){

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

			var _ct_deck_cards =
				array_length(_arr_deck);

			var _str_deck_cards = "";

			for (
				var _it_card = 0;
				_it_card < _ct_deck_cards;
				_it_card++
			){

				var _stct_card =
					_arr_deck[
						_it_card
					];

				if (!is_struct(_stct_card)){

					scr_debug_log(
						"BATTLE",
						"ENEMY",
						_ref_beast,
						"ENEMY CARD INIT FAILED | INVALID CARD STRUCT | DECK INDEX: " +
						string(_it_card),
						"ERROR",
						"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
					);

					continue;
				}

				if (_str_deck_cards != ""){
					_str_deck_cards += ", ";
				}

				_str_deck_cards +=
					string_upper(
						string(_stct_card._str_card_name)
					);

				var _ref_card =
					instance_create_layer(
						_ref_beast.x,
						_ref_beast.y - 200,
						"ily_enemy",
						obj_battle_card
					);

				_ref_card._spr_card =
					_stct_card._spr_card;

				_ref_card._uid_card =
					_stct_card._uid_card;

				_ref_card._str_team = "ENEMY";
				_ref_card._ref_card = _stct_card;
				_ref_card._ref_unit = _ref_beast;
				_ref_card._str_location = "DECK";

				_ref_card.visible = true;

				ds_list_add(
					_ref_beast._list_deck,
					_ref_card
				);

				_ct_enemy_cards_total++;
			}

			_arr_deck = undefined;

			ds_list_shuffle(
				_ref_beast._list_deck
			);

			_ref_beast._val_hand_pos = 0;

			var _str_active_card =
				"NONE";

			if (
				ds_list_size(
					_ref_beast._list_deck
				) > 0
			){

				var _ref_first_card =
					ds_list_find_value(
						_ref_beast._list_deck,
						_ref_beast._val_hand_pos
					);

				if (instance_exists(_ref_first_card)){

					_ref_first_card._str_location =
						"HAND";

					if (
						is_struct(
							_ref_first_card._ref_card
						)
					){

						_str_active_card =
							string_upper(
								string(
									_ref_first_card
										._ref_card
										._str_card_name
								)
							);
					}
				}
			}

			scr_debug_log(
				"CARDS",
				"ENEMY_DECK",
				_ref_beast,
				"ENEMY DECK INITIALIZED | CARDS: " +
				string(ds_list_size(_ref_beast._list_deck)) +
				" | ACTIVE: " +
				_str_active_card +
				" | DECK: " +
				_str_deck_cards,
				"INIT",
				"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
			);
		}

		scr_debug_log(
			"BATTLE",
			"ENEMY",
			self,
			"ENEMY BATTLE INITIALIZATION COMPLETE | BEASTS: " +
			string(ds_list_size(_list_beasts_alive)) +
			" | CARDS: " +
			string(_ct_enemy_cards_total),
			"INIT",
			"OBJ_BATTLE_ENEMY_CONTROLLER:STEP"
		);

		_state_enemy =
			ENUM_ENEMY_STATE.WAIT;

	break;
	#endregion

	//
	// WAIT
	//
	#region WAIT
	case ENUM_ENEMY_STATE.WAIT:

		_flag_turn_start_items_init = false;
		_flag_turn_start_items_complete = false;

		_flag_turn_end_items_init = false;
		_flag_turn_end_items_complete = false;

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

		if (
			ds_list_size(_list_beasts_alive) <= 0 &&
			scr_battle_has_team_combatants("ENEMY")
		){

			_state_enemy =
				ENUM_ENEMY_STATE.WAIT;

			obj_battle_turn_controller
				.hscr_battle_pass_turn();

			break;
		}

		if (!_flag_turn_start_items_init){

			_flag_turn_start_items_init = true;

			_arr_turn_start_items = [];
			_it_turn_start_item = 0;

			for (
				var _it_beast = 0;
				_it_beast < ds_list_size(_list_beasts_alive);
				_it_beast++
			){

				var _ref_beast =
					ds_list_find_value(
						_list_beasts_alive,
						_it_beast
					);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				scr_battle_degrade_armor(
					_ref_beast
				);
			}

			for (
				var _it_beast = 0;
				_it_beast < ds_list_size(_list_beasts_alive);
				_it_beast++
			){

				var _ref_beast =
					ds_list_find_value(
						_list_beasts_alive,
						_it_beast
					);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				var _stct_item =
					_ref_beast._stct_held_item;

				if (
					_stct_item == undefined ||
					_stct_item == "EMPTY"
				){
					continue;
				}

				if (
					_stct_item._str_item_trigger_type !=
					"TURN_START"
				){
					continue;
				}

				array_push(
					_arr_turn_start_items,
					{
						_ref_beast : _ref_beast,
						_stct_item : _stct_item
					}
				);
			}
		}

		//=======================//
		//SORT START ITEMS BY SPD//
		//=======================//
		if (
			_flag_turn_start_items_init &&
			_it_turn_start_item == 0
		){
			_arr_turn_start_items =
				scr_battle_sort_beast_trigger_array_by_speed(
					_arr_turn_start_items
				);
		}

		if (
			_flag_turn_start_items_init &&
			!_flag_turn_start_items_complete &&
			!instance_exists(obj_battle_wait)
		){

			if (
				_it_turn_start_item <
				array_length(_arr_turn_start_items)
			){

				var _stct_trigger =
					_arr_turn_start_items[
						_it_turn_start_item
					];

				_it_turn_start_item++;

				var _ref_beast =
					_stct_trigger._ref_beast;

				var _stct_item =
					_stct_trigger._stct_item;

				if (
					instance_exists(_ref_beast) &&
					_stct_item != undefined &&
					_stct_item._scr_item != undefined
				){

					scr_gui_spawn_popup_trigger_banner(
						_stct_item._str_item_name
					);

					var _flag_triggered =
						script_execute(
							_stct_item._scr_item,
							"TRIGGER",
							_stct_item,
							_ref_beast
						);

					if (
						_flag_triggered &&
						variable_struct_exists(
							_stct_item,
							"_flag_consumed_on_trigger"
						) &&
						_stct_item._flag_consumed_on_trigger
					){
						_ref_beast._stct_held_item = "EMPTY";
					}
				}

				scr_battle_init_wait(5);
			}
			else{

				_arr_turn_start_items = [];
				_it_turn_start_item = 0;

				_flag_turn_start_items_complete = true;
			}
		}

		if (
			_flag_turn_start_items_complete &&
			!_flag_statuses_init
		){

			_flag_statuses_init = true;

			_arr_statuses = [];
			_it_status_queue = 0;

			for (
				var _it_beast = 0;
				_it_beast < ds_list_size(_list_beasts_alive);
				_it_beast++
			){

				var _ref_beast =
					ds_list_find_value(
						_list_beasts_alive,
						_it_beast
					);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				for (
					var _it_status = 0;
					_it_status <
						ds_list_size(
							_ref_beast._list_statuses
						);
					_it_status++
				){

					array_push(
						_arr_statuses,
						ds_list_find_value(
							_ref_beast._list_statuses,
							_it_status
						)
					);
				}
			}
		}

		if (
			_flag_statuses_init &&
			!instance_exists(obj_battle_wait)
		){

			if (
				_it_status_queue <
				array_length(_arr_statuses)
			){

				var _ref_status =
					_arr_statuses[
						_it_status_queue
					];

				_it_status_queue++;

				if (instance_exists(_ref_status)){
					scr_battle_init_wait(15);
				}
			}
			else{

				_arr_statuses = [];
				_it_status_queue = 0;

				_flag_statuses_init = false;

				_state_enemy =
					ENUM_ENEMY_STATE.TRIGGER_MINIONS;
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

			_arr_casting_minions =
				scr_minion_build_speed_queue(
					_list_beasts_alive
				);

			_it_casting_minion = 0;
		}

		if (
			_flag_minions_init &&
			!instance_exists(obj_battle_wait)
		){

			if (
				_it_casting_minion <
				array_length(_arr_casting_minions)
			){

				var _ref_minion =
					_arr_casting_minions[
						_it_casting_minion
					];

				_it_casting_minion++;

				if (instance_exists(_ref_minion)){
					scr_minion_cast_effect(_ref_minion);
				}

				scr_battle_init_wait(20);
			}
			else{

				_arr_casting_minions = [];
				_it_casting_minion = 0;

				_flag_minions_init = false;

				_state_enemy =
					ENUM_ENEMY_STATE.CAST_CARDS;
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

			_arr_casting_beasts = [];
			_it_casting_beast = 0;

			for (
				var _it_beast = 0;
				_it_beast < ds_list_size(_list_beasts_alive);
				_it_beast++
			){

				var _ref_beast =
					ds_list_find_value(
						_list_beasts_alive,
						_it_beast
					);

				if (instance_exists(_ref_beast)){

					array_push(
						_arr_casting_beasts,
						_ref_beast
					);
				}
			}
		}

		//--------------------//
		//EXECUTE CAST QUEUE//
		//--------------------//
		if (
			_flag_cast_init &&
			!instance_exists(obj_battle_wait)
		){

			if (
				_it_casting_beast <
				array_length(_arr_casting_beasts)
			){

				var _ref_beast =
					_arr_casting_beasts[
						_it_casting_beast
					];

				if (!instance_exists(_ref_beast)){

					_it_casting_beast++;

					break;
				}

				obj_battle_player_controller
					.hscr_battle_check_beast_able(
						_list_beasts_alive
					);

				if (
					ds_list_size(
						_ref_beast._list_deck
					) <= 0
				){

					_it_casting_beast++;

					break;
				}

				var _ref_card =
					ds_list_find_value(
						_ref_beast._list_deck,
						_ref_beast._val_hand_pos
					);

				if (!instance_exists(_ref_card)){

					_it_casting_beast++;

					break;
				}

				if (!is_struct(_ref_card._ref_card)){

					_ref_card.visible = false;

					_it_casting_beast++;

					break;
				}

				if (_ref_card._flag_card_disabled){

					scr_gui_spawn_popup_scrolling(
						"TEXT",
						"CARD DISABLED",
						undefined,
						c_black,
						_ref_beast.x,
						_ref_beast.y - 72
					);

					audio_play_sound(
						snd_battle_expend,
						0,
						false
					);

					_ref_card.visible = false;

					_it_casting_beast++;

					scr_battle_init_wait(30);

					break;
				}

				if (_ref_beast._flag_beast_able_check){

					var _stct_card =
						_ref_card._ref_card;

					var _str_card_type =
						_stct_card._str_card_type;

					var _str_effect_type =
						_stct_card._str_card_effect_type;

					var _ref_target =
						undefined;

					switch(_str_card_type){

						case "ATTACK":

							_ref_target =
								hscr_battle_enemy_get_hostile_target(
									_ref_beast,
									_stct_card
								);

						break;

						case "SUPPORT":

							if (_str_effect_type == "HEAL"){

								_ref_target =
									hscr_battle_enemy_get_heal_target(
										_ref_beast,
										_stct_card
									);
							}
							else if (
								_str_effect_type == "DEBUFF" ||
								_str_effect_type == "CC"
							){

								_ref_target =
									hscr_battle_enemy_get_hostile_target(
										_ref_beast,
										_stct_card
									);
							}
							else{

								_ref_target =
									hscr_battle_enemy_get_friendly_target(
										_ref_beast,
										_stct_card
									);
							}

						break;

						case "UTILITY":

							if (
								_str_effect_type == "TRAP" &&
								_stct_card._str_card_id !=
									"DISTRACTING_TRAP"
							){

								_ref_target =
									hscr_battle_enemy_get_hostile_target(
										_ref_beast,
										_stct_card
									);
							}
							else if (
								_str_effect_type ==
								"REPOSITION"
							){

								if (
									scr_battle_can_reposition(
										_ref_beast
									)
								){

									var _arr_swap_targets = [];

									for (
										var _it_ally = 0;
										_it_ally <
											ds_list_size(
												_list_beasts_alive
											);
										_it_ally++
									){

										var _ref_ally =
											ds_list_find_value(
												_list_beasts_alive,
												_it_ally
											);

										if (_ref_ally == _ref_beast){
											continue;
										}

										if (
											!scr_battle_can_reposition(
												_ref_ally
											)
										){
											continue;
										}

										array_push(
											_arr_swap_targets,
											_ref_ally
										);
									}

									if (
										array_length(
											_arr_swap_targets
										) > 0
									){

										_ref_target =
											_arr_swap_targets[
												irandom(
													array_length(
														_arr_swap_targets
													) - 1
												)
											];
									}
								}
							}
							else if (_str_effect_type == "HEAL"){

								_ref_target =
									hscr_battle_enemy_get_heal_target(
										_ref_beast,
										_stct_card
									);
							}
							else{

								_ref_target =
									hscr_battle_enemy_get_friendly_target(
										_ref_beast,
										_stct_card
									);
							}

						break;

						case "DEFENSE":

							_ref_target =
								hscr_battle_enemy_get_friendly_target(
									_ref_beast,
									_stct_card,
									true
								);

						break;
					}

					var _flag_valid_target =
						false;

					if (_ref_target == "GLOBAL"){

						_flag_valid_target =
							true;
					}
					else if (
						instance_exists(
							_ref_target
						)
					){

						_flag_valid_target =
							true;
					}

					if (_flag_valid_target){

						global.ref_cast_card =
							_ref_card;

						global.ref_caster_beast =
							_ref_beast;

						global.ref_target_beast =
							_ref_target;

						scr_battle_cast_card();
					}
					else{

						scr_gui_spawn_popup_scrolling(
							"TEXT",
							"NO VALID TARGET",
							undefined,
							c_ltgray,
							_ref_beast.x,
							_ref_beast.y - 72
						);
					}

					_it_casting_beast++;

					_ref_card.visible =
						false;

					scr_battle_init_wait(30);
				}
				else{

					_ref_card.visible =
						false;

					_it_casting_beast++;

					break;
				}
			}
			else{

				_arr_casting_beasts = [];
				_it_casting_beast = 0;

				_flag_cast_init = false;

				_state_enemy =
					ENUM_ENEMY_STATE.NEW_CARDS;

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

		for (
			var _it_beast = 0;
			_it_beast < ds_list_size(_list_beasts_alive);
			_it_beast++
		){

			var _ref_beast =
				ds_list_find_value(
					_list_beasts_alive,
					_it_beast
				);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			var _ct_cards =
				ds_list_size(
					_ref_beast._list_deck
				);

			if (_ct_cards <= 0){
				continue;
			}

			var _ref_old_card =
				ds_list_find_value(
					_ref_beast._list_deck,
					_ref_beast._val_hand_pos
				);

			if (instance_exists(_ref_old_card)){

				_ref_old_card._flag_card_disabled = false;
				_ref_old_card.visible = false;
				_ref_old_card._str_location = "DECK";
			}

			_ref_beast._val_hand_pos++;

			if (
				_ref_beast._val_hand_pos >=
				_ct_cards
			){
				_ref_beast._val_hand_pos = 0;
			}

			var _ref_new_card =
				ds_list_find_value(
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

		_state_enemy =
			ENUM_ENEMY_STATE.TURN_END;

	break;
	#endregion

	//
	// TURN END
	//
	#region TURN END
	case ENUM_ENEMY_STATE.TURN_END:

		if (!_flag_turn_end_items_init){

			_flag_turn_end_items_init = true;

			scr_minion_heal_all(
				_list_beasts_alive
			);

			_arr_turn_end_items = [];
			_it_turn_end_item = 0;

			for (
				var _it_beast = 0;
				_it_beast < ds_list_size(_list_beasts_alive);
				_it_beast++
			){

				var _ref_beast =
					ds_list_find_value(
						_list_beasts_alive,
						_it_beast
					);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				var _stct_item =
					_ref_beast._stct_held_item;

				if (
					_stct_item == undefined ||
					_stct_item == "EMPTY"
				){
					continue;
				}

				if (
					_stct_item._str_item_trigger_type !=
					"TURN_END"
				){
					continue;
				}

				array_push(
					_arr_turn_end_items,
					{
						_ref_beast : _ref_beast,
						_stct_item : _stct_item
					}
				);
			}
		}

		//=====================//
		//SORT END ITEMS BY SPD//
		//=====================//
		if (
			_flag_turn_end_items_init &&
			_it_turn_end_item == 0
		){
			_arr_turn_end_items =
				scr_battle_sort_beast_trigger_array_by_speed(
					_arr_turn_end_items
				);
		}

		if (
			_flag_turn_end_items_init &&
			!_flag_turn_end_items_complete &&
			!instance_exists(obj_battle_wait)
		){

			if (
				_it_turn_end_item <
				array_length(_arr_turn_end_items)
			){

				var _stct_trigger =
					_arr_turn_end_items[
						_it_turn_end_item
					];

				_it_turn_end_item++;

				var _ref_beast =
					_stct_trigger._ref_beast;

				var _stct_item =
					_stct_trigger._stct_item;

				if (
					instance_exists(_ref_beast) &&
					_stct_item != undefined &&
					_stct_item._scr_item != undefined
				){

					var _flag_triggered =
						script_execute(
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

				scr_battle_init_wait(5);
			}
			else{

				_arr_turn_end_items = [];
				_it_turn_end_item = 0;

				_flag_turn_end_items_complete = true;
			}
		}

		if (
			_flag_turn_end_items_complete &&
			!_flag_statuses_init
		){

			_flag_statuses_init = true;

			_arr_statuses = [];
			_it_status_queue = 0;

			for (
				var _it_beast = 0;
				_it_beast < ds_list_size(_list_beasts_alive);
				_it_beast++
			){

				var _ref_beast =
					ds_list_find_value(
						_list_beasts_alive,
						_it_beast
					);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				for (
					var _it_status = 0;
					_it_status <
						ds_list_size(
							_ref_beast._list_statuses
						);
					_it_status++
				){

					array_push(
						_arr_statuses,
						ds_list_find_value(
							_ref_beast._list_statuses,
							_it_status
						)
					);
				}
			}

			if (
				ds_exists(
					global.list_statuses,
					ds_type_list
				)
			){

				for (
					var _it_global_status = 0;
					_it_global_status <
						ds_list_size(
							global.list_statuses
						);
					_it_global_status++
				){

					var _ref_global_status =
						ds_list_find_value(
							global.list_statuses,
							_it_global_status
						);

					if (!instance_exists(_ref_global_status)){
						continue;
					}

					if (
						_ref_global_status._str_status_type !=
						"EVENT"
					){
						continue;
					}

					if (
						_ref_global_status._str_trigger_region !=
						"END"
					){
						continue;
					}

					if (
						!variable_instance_exists(
							_ref_global_status,
							"_str_event_owner_team"
						)
					){
						continue;
					}

					if (
						_ref_global_status._str_event_owner_team !=
						"ENEMY"
					){
						continue;
					}

					array_push(
						_arr_statuses,
						_ref_global_status
					);
				}
			}
		}

		if (
			_flag_statuses_init &&
			!instance_exists(obj_battle_wait)
		){

			if (
				_it_status_queue <
				array_length(_arr_statuses)
			){

				var _ref_status =
					_arr_statuses[
						_it_status_queue
					];

				_it_status_queue++;

				if (instance_exists(_ref_status)){

					if (
						_ref_status._str_trigger_region ==
						"END"
					){
						_ref_status._str_status_command =
							"REPEAT";
					}

					scr_battle_init_wait(15);
				}
			}
			else{

				_arr_statuses = [];
				_it_status_queue = 0;

				_flag_statuses_init = false;

				_state_enemy =
					ENUM_ENEMY_STATE.WAIT;

				obj_battle_turn_controller
					.hscr_battle_pass_turn();
			}
		}

	break;
	#endregion
}