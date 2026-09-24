//===============================================================================//
//
// STEP: OBJ_BATTLE_PLAYER_CONTROLLER
// FUNCTION: Executes the player battle state machine.
//           Handles Beast/Card initialization, turn processing, Minions,
//           Card/caster/target selection, Prisms, corpse targeting,
//           Tutor/discard flows, and player turn completion.
//
//===============================================================================//

//--------------------------//
//PRISM BUTTON: CURRENT HUD//
//--------------------------//
// Original Create coordinates point to the old layout. Keep hit detection
// and the existing Draw GUI End prism helper in the same HUD rectangle.
_val_prism_button_x1 = 0;
_val_prism_button_y1 = 744;
_val_prism_button_x2 = 100;
_val_prism_button_y2 = 793;

//----------------------//
//CLEAR TARGET PREVIEW//
//----------------------//
if (_state_player != ENUM_PLAYER_STATE.SELECT_TARGET){
	_arr_target_preview = [];
}

switch(_state_player){

	//
	// INIT BEASTS
	//
	#region INIT BEASTS
	case ENUM_PLAYER_STATE.INIT_BEASTS:

		//----------------//
		//DEBUG INIT START//
		//----------------//
		scr_debug_log(
			"BATTLE",
			"PLAYER",
			self,
			"INITIALIZING PLAYER BEASTS | PARTY: " + string(ds_list_size(global.list_player_party)),
			"INIT",
			"OBJ_BATTLE_PLAYER_CONTROLLER:STEP"
		);

		var _val_spawn_index = 0;
		var _ct_party_beasts = ds_list_size(global.list_player_party);

		for (var _it_beast = 0; _it_beast < _ct_party_beasts; _it_beast++){

			var _stct_unit = ds_list_find_value(global.list_player_party,_it_beast);

			//----------------//
			//VALIDATE BEAST//
			//----------------//
			if (!is_struct(_stct_unit)){

				scr_debug_log(
					"BATTLE",
					"PLAYER",
					undefined,
					"PLAYER BATTLE INIT FAILED | INVALID BEAST STRUCT | PARTY INDEX: " + string(_it_beast),
					"ERROR",
					"OBJ_BATTLE_PLAYER_CONTROLLER:STEP"
				);

				continue;
			}

			//--------------------//
			//VALIDATE MAXIMUM HP//
			//--------------------//
			if (_stct_unit._val_beast_hp_max <= 0){

				scr_debug_log(
					"BATTLE",
					"PLAYER",
					_stct_unit,
					"PLAYER BATTLE INIT FAILED | INVALID MAX HP: " + string(_stct_unit._val_beast_hp_max),
					"ERROR",
					"OBJ_BATTLE_PLAYER_CONTROLLER:STEP"
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

			//-----------------//
			//SKIP DEAD BEASTS//
			//-----------------//
			if (_stct_unit._val_beast_hp_cur <= 0){

				scr_debug_log(
					"BATTLE",
					"PLAYER",
					_stct_unit,
					"PLAYER BEAST SKIPPED | LVL " + string(_stct_unit._val_beast_level) +
					" | HP: 0/" + string(_stct_unit._val_beast_hp_max) +
					" | REASON: DEFEATED",
					"INIT",
					"OBJ_BATTLE_PLAYER_CONTROLLER:STEP"
				);

				continue;
			}

			//--------------------//
			//CREATE BATTLE BEAST//
			//--------------------//
			var _ref_beast = instance_create_layer(
				room_width * 0.5 - 80 - (100 * _val_spawn_index),
				room_height * 0.5,
				"ily_player",
				obj_battle_beast
			);

			//--------------------//
			//TRANSFER BEAST DATA//
			//--------------------//
			_ref_beast._spr_beast = _stct_unit._spr_beast;
			_ref_beast._ref_unit = _stct_unit;
			_ref_beast._stct_held_item = _stct_unit._stct_beast_held_item;

			_ref_beast._str_team = "PLAYER";

			_ref_beast._uid_beast = _stct_unit._uid_beast;

			_ref_beast._snd_cry = _stct_unit._snd_beast_cry;
			_ref_beast._snd_death = _stct_unit._snd_beast_death;

			_ref_beast._val_pos = _val_spawn_index;

			//-----------------------//
			//TRANSFER COMBAT STATS//
			//-----------------------//
			_ref_beast._ct_minions_max = _stct_unit._val_beast_min_stat;

			_ref_beast._val_crit_chance = _stct_unit._val_beast_crit_stat;
			_ref_beast._val_crit_damage = _stct_unit._val_beast_crit_dmg_stat;

			_ref_beast._val_cur_hp = _stct_unit._val_beast_hp_cur;
			_ref_beast._val_max_hp = _stct_unit._val_beast_hp_max;

			_ref_beast._val_speed_base = _stct_unit._val_beast_speed_stat;

			//-------------//
			//TRACK BEAST//
			//-------------//
			ds_list_add(_list_beasts,_ref_beast);
			ds_list_add(_list_beasts_alive,_ref_beast);

			//------------------//
			//DEBUG BEAST READY//
			//------------------//
			scr_debug_log(
				"BEAST",
				"PLAYER",
				_ref_beast,
				"PLAYER BEAST INITIALIZED | LVL " + string(_stct_unit._val_beast_level) +
				" | HP: " + string(_ref_beast._val_cur_hp) +
				"/" + string(_ref_beast._val_max_hp) +
				" | BREED: " + string_upper(string(_stct_unit._str_beast_breed)) +
				" | POSITION: " + string(_val_spawn_index),
				"INIT",
				"OBJ_BATTLE_PLAYER_CONTROLLER:STEP"
			);

			_val_spawn_index++;
		}

		//--------------------//
		//DEBUG BEAST SUMMARY//
		//--------------------//
		scr_debug_log(
			"BATTLE",
			"PLAYER",
			self,
			"PLAYER BEAST INITIALIZATION COMPLETE | ACTIVE: " + string(ds_list_size(_list_beasts_alive)) +
			" | PARTY: " + string(_ct_party_beasts),
			"INIT",
			"OBJ_BATTLE_PLAYER_CONTROLLER:STEP"
		);

		_state_player = ENUM_PLAYER_STATE.INIT_CARDS;

	break;
	#endregion

	//
	// INIT CARDS
	//
	#region INIT CARDS
	case ENUM_PLAYER_STATE.INIT_CARDS:

		var _ct_deck_cards = ds_list_size(global.list_player_deck);

		//----------------//
		//DEBUG INIT START//
		//----------------//
		scr_debug_log(
			"BATTLE",
			"PLAYER",
			self,
			"INITIALIZING PLAYER CARDS | DECK: " + string(_ct_deck_cards),
			"INIT",
			"OBJ_BATTLE_PLAYER_CONTROLLER:STEP"
		);

		//-------------------//
		//CREATE BATTLE CARDS//
		//-------------------//
		for (var _it_card = 0; _it_card < _ct_deck_cards; _it_card++){

			var _stct_card = ds_list_find_value(global.list_player_deck,_it_card);

			if (!is_struct(_stct_card)){

				scr_debug_log(
					"BATTLE",
					"PLAYER",
					undefined,
					"PLAYER CARD INIT FAILED | INVALID CARD STRUCT | DECK INDEX: " + string(_it_card),
					"ERROR",
					"OBJ_BATTLE_PLAYER_CONTROLLER:STEP"
				);

				continue;
			}

			var _ref_card = instance_create_layer(
				70,
				room_height - 100,
				"ily_player",
				obj_battle_card
			);

			_ref_card._spr_card = _stct_card._spr_card;
			_ref_card._uid_card = _stct_card._uid_card;

			_ref_card._str_team = "PLAYER";
			_ref_card._ref_card = _stct_card;
			_ref_card._str_location = "DECK";

			ds_list_add(_list_battle_deck,_ref_card);
		}

		//----------------//
		//SHUFFLE DECK//
		//----------------//
		ds_list_shuffle(_list_battle_deck);

		//-----------------//
		//DRAW OPENING HAND//
		//-----------------//
		var _ct_opening_draw = scr_battle_draw_cards(_ct_opening_draw_amount);

		//--------------------//
		//DEBUG CARD SUMMARY//
		//--------------------//
		scr_debug_log(
			"BATTLE",
			"PLAYER",
			self,
			"PLAYER CARDS INITIALIZED | TOTAL: " +
			string(
				ds_list_size(_list_battle_deck) +
				ds_list_size(_list_battle_hand) +
				ds_list_size(_list_battle_discard) +
				ds_list_size(_list_battle_exhaust)
			) +
			" | DRAW PILE: " + string(ds_list_size(_list_battle_deck)) +
			" | HAND: " + string(ds_list_size(_list_battle_hand)) +
			" | OPENING DRAW: " + string(_ct_opening_draw),
			"INIT",
			"OBJ_BATTLE_PLAYER_CONTROLLER:STEP"
		);

		//---------------------//
		//DEBUG INIT COMPLETE//
		//---------------------//
		scr_debug_log(
			"BATTLE",
			"PLAYER",
			self,
			"PLAYER BATTLE INITIALIZATION COMPLETE | BEASTS: " + string(ds_list_size(_list_beasts_alive)) +
			" | CARDS: " + string(_ct_deck_cards) +
			" | MANA: " + string(_val_cur_mana) + "/" + string(_val_max_mana),
			"INIT",
			"OBJ_BATTLE_PLAYER_CONTROLLER:STEP"
		);

		_state_player = ENUM_PLAYER_STATE.WAIT;

	break;
	#endregion

	//
	// WAIT
	//
	#region WAIT
	case ENUM_PLAYER_STATE.WAIT:

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

		//--------------------//
		//STATUSES / MINIONS//
		//--------------------//
		_flag_statuses_init = false;
		_flag_minions_init = false;

		//-------------------------//
		//BEGIN PENDING EXTRA TURN//
		//-------------------------//
		if (
			_flag_begin_extra_turn &&
			!instance_exists(obj_battle_wait)
		){

			_flag_begin_extra_turn = false;
			_state_player = ENUM_PLAYER_STATE.TURN_START;

			scr_debug_log(
				"BATTLE",
				"TURN",
				self,
				"ROUND " + string(obj_battle_turn_controller._ct_round) +
				" | PLAYER EXTRA TURN START",
				"BATTLE",
				"OBJ_BATTLE_PLAYER_CONTROLLER:STEP"
			);
		}

	break;
	#endregion

	//
	// TURN START
	//
	#region TURN START
	case ENUM_PLAYER_STATE.TURN_START:

		//--------------------------//
		//BANISHED TEAM TURN SAFETY//
		//--------------------------//
		if (
			ds_list_size(_list_beasts_alive) <= 0 &&
			scr_battle_has_team_combatants("PLAYER")
		){

			_state_player = ENUM_PLAYER_STATE.WAIT;

			obj_battle_turn_controller.hscr_battle_pass_turn();

			break;
		}

		//-----------------------//
		//BUILD HELD ITEM QUEUE//
		//-----------------------//
		if (!_flag_turn_start_items_init){

			_flag_turn_start_items_init = true;
			_list_turn_start_items = ds_list_create();

			//-------------//
			//RESTORE MANA//
			//-------------//
			var _val_mana_before_refill = _val_cur_mana;

			_val_cur_mana = _val_max_mana;

			//----------------//
			//DEBUG MANA REFILL//
			//----------------//
			if (_val_cur_mana != _val_mana_before_refill){

				scr_debug_log(
					"BATTLE",
					"MANA",
					self,
					"PLAYER MANA REFILLED | " +
					string(_val_mana_before_refill) +
					"/" + string(_val_max_mana) +
					" -> " +
					string(_val_cur_mana) +
					"/" + string(_val_max_mana),
					"BATTLE",
					"OBJ_BATTLE_PLAYER_CONTROLLER:STEP"
				);
			}

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

				scr_battle_init_wait(5);
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
			
		//=======================//
		//GLOBAL BEGIN STATUSES//
		//=======================//
		if (ds_exists(global.list_statuses,ds_type_list)){

		    for (
		        var _it_global_status = 0;
		        _it_global_status < ds_list_size(global.list_statuses);
		        _it_global_status++
		    ){

		        var _ref_global_status = ds_list_find_value(
		            global.list_statuses,
		            _it_global_status
		        );

		        if (!instance_exists(_ref_global_status)){
		            continue;
		        }

		        //----------------------//
		        //BEGIN STATUSES ONLY//
		        //----------------------//
		        if (
		            _ref_global_status._str_trigger_region != "START" &&
		            _ref_global_status._str_trigger_region != "BEGIN"
		        ){
		            continue;
		        }

		        ds_list_add(
		            _list_statuses,
		            _ref_global_status
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

					if (
					    _ref_status._str_trigger_region == "START" ||
					    _ref_status._str_trigger_region == "BEGIN"
					){
					    _ref_status._str_status_command = "REPEAT";
					}

					ds_list_delete(_list_statuses,0);

					scr_battle_init_wait(15);
				}
				else{
					ds_list_delete(_list_statuses,0);
				}
			}
			else{

				ds_list_destroy(_list_statuses);
				_list_statuses = undefined;

				_flag_statuses_init = false;

				_state_player = ENUM_PLAYER_STATE.TRIGGER_MINIONS;
			}
		}

	break;
	#endregion

	//
	// TRIGGER MINIONS
	//
	#region TRIGGER MINIONS
	case ENUM_PLAYER_STATE.TRIGGER_MINIONS:

		//-------------------//
		//BUILD MINION QUEUE//
		//-------------------//
		if (!_flag_minions_init){

			_flag_minions_init = true;

			_list_casting_minions =
				scr_minion_build_speed_queue(_list_beasts_alive);
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

				scr_battle_init_wait(20);
			}
			else{

				ds_list_destroy(_list_casting_minions);
				_list_casting_minions = undefined;

				_flag_minions_init = false;

				_state_player = ENUM_PLAYER_STATE.SELECT_CARD;

				hscr_battle_check_card_oom(_list_battle_hand);
			}
		}

	break;
	#endregion

	//
	// SELECT CARD
	//
	#region SELECT CARD
	case ENUM_PLAYER_STATE.SELECT_CARD:

		_flag_statuses_init = false;
		_flag_minions_init = false;

		//----------------//
		//OPEN PRISM MENU//
		//----------------//
		if (mouse_check_button_pressed(mb_left) && !_flag_clicked){

			var _val_mouse_x = device_mouse_x_to_gui(0);
			var _val_mouse_y = device_mouse_y_to_gui(0);

			if (
				hscr_battle_is_mouse_in_box(
					_val_mouse_x,
					_val_mouse_y,
					_val_prism_button_x1,
					_val_prism_button_y1,
					_val_prism_button_x2,
					_val_prism_button_y2
				)
			){

				_flag_clicked = true;

				if (array_length(hscr_battle_get_prism_stacks()) <= 0){

					audio_play_sound(snd_gui_error,0,false);

					scr_gui_spawn_popup_error("NO PRISMS AVAILABLE",60);
				}
				else{

					audio_play_sound(snd_gui_press,0,false);

					_state_player = ENUM_PLAYER_STATE.SELECT_PRISM;
				}

				break;
			}
		}

		//----------//
		//END TURN//
		//----------//
		if (
			mouse_check_button_pressed(mb_left) &&
			!_flag_clicked &&
			position_meeting(
				device_mouse_x_to_gui(0),
				device_mouse_y_to_gui(0),
				obj_battle_end_turn_button
			)
		){

			audio_play_sound(snd_battle_turn,0,false);

			_flag_clicked = true;
			_state_player = ENUM_PLAYER_STATE.TURN_END;

			break;
		}

		//------------------//
		//SELECT HAND CARD//
		//------------------//
		if (
			instance_exists(_ref_hover_card) &&
			mouse_check_button_pressed(mb_left) &&
			!_flag_clicked
		){

			audio_play_sound(snd_battle_card_move,0,false);

			_flag_clicked = true;

			var _ref_card = _ref_hover_card;

			if (
				instance_exists(_ref_card) &&
				_ref_card._str_location == "HAND" &&
				_ref_card._str_team == "PLAYER" &&
				!_ref_card._flag_card_oom_check
			){

				global.ref_cast_card = _ref_card;

				_state_player = ENUM_PLAYER_STATE.SELECT_CASTER;

				hscr_battle_check_beast_able(_list_beasts_alive);
				hscr_battle_check_beast_color(_list_beasts_alive);
				hscr_battle_check_beast_archetype(_list_beasts_alive);
				hscr_battle_check_beast_class(_list_beasts_alive);
			}
		}

	break;
	#endregion

	//
	// SELECT PRISM
	//
	#region SELECT PRISM
	case ENUM_PLAYER_STATE.SELECT_PRISM:

		//-------------------//
		//RIGHT CLICK RETURN//
		//-------------------//
		if (mouse_check_button_pressed(mb_right) && !_flag_clicked){

			audio_play_sound(snd_gui_close,0,false);

			_flag_clicked = true;

			_stct_selected_prism = undefined;
			_state_player = ENUM_PLAYER_STATE.SELECT_CARD;

			break;
		}

		//----------//
		//END TURN//
		//----------//
		if (
			mouse_check_button_pressed(mb_left) &&
			!_flag_clicked &&
			position_meeting(
				device_mouse_x_to_gui(0),
				device_mouse_y_to_gui(0),
				obj_battle_end_turn_button
			)
		){

			audio_play_sound(snd_battle_turn,0,false);

			_flag_clicked = true;
			_stct_selected_prism = undefined;

			_state_player = ENUM_PLAYER_STATE.TURN_END;

			break;
		}

		//------------------//
		//CLOSE PRISM MENU//
		//------------------//
		if (mouse_check_button_pressed(mb_left) && !_flag_clicked){

			var _val_mouse_x = device_mouse_x_to_gui(0);
			var _val_mouse_y = device_mouse_y_to_gui(0);

			if (
				hscr_battle_is_mouse_in_box(
					_val_mouse_x,
					_val_mouse_y,
					_val_prism_button_x1,
					_val_prism_button_y1,
					_val_prism_button_x2,
					_val_prism_button_y2
				)
			){

				audio_play_sound(snd_gui_close,0,false);

				_flag_clicked = true;

				_stct_selected_prism = undefined;
				_state_player = ENUM_PLAYER_STATE.SELECT_CARD;

				break;
			}
		}

		//--------------------//
		//SELECT PRISM STACK//
		//--------------------//
		if (mouse_check_button_pressed(mb_left) && !_flag_clicked){

			audio_play_sound(snd_gui_press,0,false);

			_flag_clicked = true;

			hscr_battle_handle_prism_menu_input();

			break;
		}

	break;
	#endregion

	//
	// SELECT PRISM TARGET
	//
	#region SELECT PRISM TARGET
	case ENUM_PLAYER_STATE.SELECT_PRISM_TARGET:

		//-------------------//
		//RIGHT CLICK RETURN//
		//-------------------//
		if (mouse_check_button_pressed(mb_right) && !_flag_clicked){

			audio_play_sound(snd_gui_close,0,false);

			_flag_clicked = true;

			_stct_selected_prism = undefined;
			_state_player = ENUM_PLAYER_STATE.SELECT_PRISM;

			break;
		}

		//----------//
		//END TURN//
		//----------//
		if (
			mouse_check_button_pressed(mb_left) &&
			!_flag_clicked &&
			position_meeting(
				device_mouse_x_to_gui(0),
				device_mouse_y_to_gui(0),
				obj_battle_end_turn_button
			)
		){

			audio_play_sound(snd_battle_turn,0,false);

			_flag_clicked = true;
			_stct_selected_prism = undefined;

			_state_player = ENUM_PLAYER_STATE.TURN_END;

			break;
		}

		//--------------------//
		//SELECT ENEMY TARGET//
		//--------------------//
		if (
			position_meeting(
				device_mouse_x_to_gui(0),
				device_mouse_y_to_gui(0),
				obj_battle_beast
			) &&
			mouse_check_button_pressed(mb_left) &&
			!_flag_clicked
		){

			var _ref_beast_clicked = instance_nearest(
				device_mouse_x_to_gui(0),
				device_mouse_y_to_gui(0),
				obj_battle_beast
			);

			if (
				instance_exists(_ref_beast_clicked) &&
				_ref_beast_clicked._str_team == "ENEMY" &&
				_ref_beast_clicked._str_list == "ALIVE" &&
				_ref_beast_clicked._val_cur_hp > 0
			){

				audio_play_sound(snd_gui_close,0,false);

				_flag_clicked = true;

				scr_battle_try_prism_capture(
					_stct_selected_prism,
					_ref_beast_clicked
				);

				_stct_selected_prism = undefined;

				hscr_battle_check_card_oom(_list_battle_hand);

				_state_player = ENUM_PLAYER_STATE.SELECT_CARD;
			}
		}

	break;
	#endregion

	//
	// SELECT CASTER
	//
	#region SELECT CASTER
	case ENUM_PLAYER_STATE.SELECT_CASTER:

		//----------//
		//END TURN//
		//----------//
		if (
			mouse_check_button_pressed(mb_left) &&
			!_flag_clicked &&
			position_meeting(
				device_mouse_x_to_gui(0),
				device_mouse_y_to_gui(0),
				obj_battle_end_turn_button
			)
		){

			audio_play_sound(snd_battle_turn,0,false);

			_flag_clicked = true;
			_state_player = ENUM_PLAYER_STATE.TURN_END;

			break;
		}

		//-------------------//
		//RIGHT CLICK RETURN//
		//-------------------//
		if (mouse_check_button_pressed(mb_right) && !_flag_clicked){

			audio_play_sound(snd_gui_close,0,false);

			_flag_clicked = true;

			_state_player = ENUM_PLAYER_STATE.SELECT_CARD;

			global.ref_cast_card = undefined;

			hscr_battle_check_card_oom(_list_battle_hand);

			break;
		}

		//---------------//
		//SELECT CASTER//
		//---------------//
		if (
			position_meeting(
				device_mouse_x_to_gui(0),
				device_mouse_y_to_gui(0),
				obj_battle_beast
			) &&
			mouse_check_button_pressed(mb_left) &&
			!_flag_clicked
		){

			var _ref_beast_clicked = instance_nearest(
				device_mouse_x_to_gui(0),
				device_mouse_y_to_gui(0),
				obj_battle_beast
			);

			if (
				instance_exists(_ref_beast_clicked) &&
				_ref_beast_clicked._val_cur_hp > 0 &&
				_ref_beast_clicked._str_team == "PLAYER" &&
				_ref_beast_clicked._flag_beast_color_check &&
				_ref_beast_clicked._flag_beast_able_check &&
				_ref_beast_clicked._flag_beast_archetype_check &&
				_ref_beast_clicked._flag_beast_class_check
			){

				audio_play_sound(snd_gui_press,0,false);

				_flag_clicked = true;

				global.ref_caster_beast = _ref_beast_clicked;

				var _str_card_range =
					global.ref_cast_card._ref_card._str_card_range;

				//-------------------//
				//ENEMY CARD TARGET//
				//-------------------//
				if (_str_card_range == "ENEMY_CARD"){
					_state_player = ENUM_PLAYER_STATE.SELECT_ENEMY_CARD;
				}

				//------------------------//
				//OPTIONAL CORPSE TARGET//
				//------------------------//
				else if (_str_card_range == "CORPSE_OPTIONAL"){

					global.ref_target_corpse = undefined;

					_state_player = ENUM_PLAYER_STATE.SELECT_CORPSE;
				}

				//---------------//
				//CORPSE TARGET//
				//---------------//
				else if (_str_card_range == "CORPSE"){

					if (scr_battle_has_corpse()){

						global.ref_target_corpse = undefined;

						_state_player = ENUM_PLAYER_STATE.SELECT_CORPSE;
					}
					else{

						audio_play_sound(snd_gui_error,0,false);

						scr_gui_spawn_popup_error("NO CORPSES",60);

						global.ref_caster_beast = undefined;

						_state_player = ENUM_PLAYER_STATE.SELECT_CASTER;
					}
				}

				//--------------//
				//BEAST TARGET//
				//--------------//
				else{

					_state_player = ENUM_PLAYER_STATE.SELECT_TARGET;

					if (_str_card_range != "GLOBAL"){
						hscr_battle_check_beast_range(_list_beasts_alive,_str_card_range);
					}
				}
			}
		}

	break;
	#endregion

	//
	// SELECT TARGET
	//
	#region SELECT TARGET
	case ENUM_PLAYER_STATE.SELECT_TARGET:

		//----------------------//
		//BUILD TARGET PREVIEW//
		//----------------------//
		_arr_target_preview = [];

		var _val_mouse_x = device_mouse_x_to_gui(0);
		var _val_mouse_y = device_mouse_y_to_gui(0);

		var _ref_hovered_beast = instance_position(
			_val_mouse_x,
			_val_mouse_y,
			obj_battle_beast
		);

		if (
			instance_exists(_ref_hovered_beast) &&
			_ref_hovered_beast._str_list == "ALIVE" &&
			_ref_hovered_beast._val_cur_hp > 0 &&
			_ref_hovered_beast._flag_beast_range_check
		){

			_arr_target_preview = scr_battle_get_card_preview_targets(
				global.ref_cast_card._ref_card,
				_ref_hovered_beast
			);
		}

		//----------//
		//END TURN//
		//----------//
		if (
			mouse_check_button_pressed(mb_left) &&
			!_flag_clicked &&
			position_meeting(
				_val_mouse_x,
				_val_mouse_y,
				obj_battle_end_turn_button
			)
		){

			audio_play_sound(snd_battle_turn,0,false);

			_flag_clicked = true;
			_state_player = ENUM_PLAYER_STATE.TURN_END;

			break;
		}

		//-------------------//
		//RIGHT CLICK RETURN//
		//-------------------//
		if (mouse_check_button_pressed(mb_right) && !_flag_clicked){

			audio_play_sound(snd_gui_close,0,false);

			_flag_clicked = true;

			_state_player = ENUM_PLAYER_STATE.SELECT_CASTER;

			global.ref_caster_beast = undefined;

			hscr_battle_check_beast_able(_list_beasts_alive);
			hscr_battle_check_beast_color(_list_beasts_alive);
			hscr_battle_check_beast_archetype(_list_beasts_alive);
			hscr_battle_check_beast_class(_list_beasts_alive);

			break;
		}

		var _str_card_range =
			global.ref_cast_card._ref_card._str_card_range;

		//-------------------//
		//GLOBAL CARD TARGET//
		//-------------------//
		if (
			_str_card_range == "GLOBAL" &&
			mouse_check_button_pressed(mb_left) &&
			!_flag_clicked
		){

			audio_play_sound(snd_gui_press,0,false);

			_flag_clicked = true;

			global.ref_target_beast = "GLOBAL";

			_state_player = ENUM_PLAYER_STATE.CARD_EXECUTE;
		}

		//-------------------//
		//SELECT BEAST TARGET//
		//-------------------//
		if (
			_str_card_range != "GLOBAL" &&
			position_meeting(_val_mouse_x,_val_mouse_y,obj_battle_beast) &&
			mouse_check_button_pressed(mb_left) &&
			!_flag_clicked
		){

			var _ref_beast_clicked = instance_nearest(
				_val_mouse_x,
				_val_mouse_y,
				obj_battle_beast
			);

			if (
				instance_exists(_ref_beast_clicked) &&
				_ref_beast_clicked._str_list == "ALIVE" &&
				_ref_beast_clicked._val_cur_hp > 0 &&
				_ref_beast_clicked._flag_beast_range_check
			){

				audio_play_sound(snd_gui_press,0,false);

				_flag_clicked = true;

				global.ref_target_beast = _ref_beast_clicked;

				_state_player = ENUM_PLAYER_STATE.CARD_EXECUTE;
			}
		}

	break;
	#endregion

	//
	// SELECT ENEMY CARD
	//
	#region SELECT ENEMY CARD
	case ENUM_PLAYER_STATE.SELECT_ENEMY_CARD:

		//----------//
		//END TURN//
		//----------//
		if (
			mouse_check_button_pressed(mb_left) &&
			!_flag_clicked &&
			position_meeting(
				device_mouse_x_to_gui(0),
				device_mouse_y_to_gui(0),
				obj_battle_end_turn_button
			)
		){

			audio_play_sound(snd_battle_turn,0,false);

			_flag_clicked = true;

			global.ref_target_card = undefined;

			_state_player = ENUM_PLAYER_STATE.TURN_END;

			break;
		}

		//-------------------//
		//RIGHT CLICK RETURN//
		//-------------------//
		if (mouse_check_button_pressed(mb_right) && !_flag_clicked){

			audio_play_sound(snd_gui_close,0,false);

			_flag_clicked = true;

			global.ref_caster_beast = undefined;
			global.ref_target_card = undefined;

			_state_player = ENUM_PLAYER_STATE.SELECT_CASTER;

			hscr_battle_check_beast_able(_list_beasts_alive);
			hscr_battle_check_beast_color(_list_beasts_alive);
			hscr_battle_check_beast_archetype(_list_beasts_alive);
			hscr_battle_check_beast_class(_list_beasts_alive);

			break;
		}

		//---------------------//
		//SELECT ENEMY CARD//
		//---------------------//
		if (mouse_check_button_pressed(mb_left) && !_flag_clicked){

			var _val_mouse_x = device_mouse_x_to_gui(0);
			var _val_mouse_y = device_mouse_y_to_gui(0);

			var _ref_card_clicked = undefined;

			var _list_enemies = obj_battle_enemy_controller._list_beasts_alive;
			var _ct_enemies = ds_list_size(_list_enemies);

			for (var _it_enemy = 0; _it_enemy < _ct_enemies; _it_enemy++){

				var _ref_enemy = ds_list_find_value(_list_enemies,_it_enemy);

				if (!instance_exists(_ref_enemy)){
					continue;
				}

				if (
					_ref_enemy._str_list != "ALIVE" ||
					_ref_enemy._val_cur_hp <= 0
				){
					continue;
				}

				var _ref_hand_card = ds_list_find_value(
					_ref_enemy._list_deck,
					_ref_enemy._val_hand_pos
				);

				if (!instance_exists(_ref_hand_card)){
					continue;
				}

				if (position_meeting(_val_mouse_x,_val_mouse_y,_ref_hand_card)){

					_ref_card_clicked = _ref_hand_card;

					break;
				}
			}

			//----------------//
			//VALID ENEMY CARD//
			//----------------//
			if (
				instance_exists(_ref_card_clicked) &&
				_ref_card_clicked._str_team == "ENEMY" &&
				_ref_card_clicked._str_location == "HAND" &&
				!_ref_card_clicked._flag_card_disabled
			){

				audio_play_sound(snd_gui_press,0,false);

				_flag_clicked = true;

				global.ref_target_card = _ref_card_clicked;

				_state_player = ENUM_PLAYER_STATE.CARD_EXECUTE;
			}
			else{

				//--------------//
				//INVALID CARD//
				//--------------//
				audio_play_sound(snd_gui_error,0,false);

				scr_gui_spawn_popup_error("INVALID CARD",60);
			}
		}

	break;
	#endregion

	//
	// SELECT CORPSE
	//
	#region SELECT CORPSE
	case ENUM_PLAYER_STATE.SELECT_CORPSE:

		//----------------//
		//GET MOUSE//
		//----------------//
		var _val_mouse_x = device_mouse_x_to_gui(0);
		var _val_mouse_y = device_mouse_y_to_gui(0);

		//----------------//
		//VALIDATE CARD//
		//----------------//
		if (
			!instance_exists(global.ref_cast_card) ||
			!is_struct(global.ref_cast_card._ref_card)
		){

			global.ref_target_corpse = undefined;
			global.ref_caster_beast = undefined;
			global.ref_cast_card = undefined;

			_state_player = ENUM_PLAYER_STATE.SELECT_CARD;

			break;
		}

		var _stct_corpse_card = global.ref_cast_card._ref_card;

		//=======================//
		//OPTIONAL TARGET RULES//
		//=======================//
		var _flag_allow_empty_target =
			!scr_battle_has_corpse();

		if (
			variable_struct_exists(
				_stct_corpse_card,
				"_flag_allow_empty_corpse_target"
			)
		){

			_flag_allow_empty_target =
				_flag_allow_empty_target ||
				_stct_corpse_card._flag_allow_empty_corpse_target;
		}

		//=====================//
		//CANCEL DESTINATION//
		//=====================//
		var _flag_cancel_to_card_select = false;

		if (
			variable_struct_exists(
				_stct_corpse_card,
				"_flag_corpse_cancel_to_card_select"
			)
		){

			_flag_cancel_to_card_select =
				_stct_corpse_card._flag_corpse_cancel_to_card_select;
		}

		//----------//
		//END TURN//
		//----------//
		if (
			mouse_check_button_pressed(mb_left) &&
			!_flag_clicked &&
			position_meeting(
				_val_mouse_x,
				_val_mouse_y,
				obj_battle_end_turn_button
			)
		){

			audio_play_sound(snd_battle_turn,0,false);

			_flag_clicked = true;

			global.ref_target_corpse = undefined;
			global.ref_caster_beast = undefined;

			_state_player = ENUM_PLAYER_STATE.TURN_END;

			break;
		}

		//-------------------//
		//RIGHT CLICK RETURN//
		//-------------------//
		if (mouse_check_button_pressed(mb_right) && !_flag_clicked){

			audio_play_sound(snd_gui_close,0,false);

			_flag_clicked = true;

			global.ref_target_corpse = undefined;
			global.ref_caster_beast = undefined;

			//=======================//
			//RETURN TO CARD SELECT//
			//=======================//
			if (_flag_cancel_to_card_select){

				global.ref_cast_card = undefined;

				_state_player = ENUM_PLAYER_STATE.SELECT_CARD;

				hscr_battle_check_card_oom(
					_list_battle_hand
				);

				break;
			}

			//=========================//
			//RETURN TO CASTER SELECT//
			//=========================//
			_state_player = ENUM_PLAYER_STATE.SELECT_CASTER;

			hscr_battle_check_beast_able(_list_beasts_alive);
			hscr_battle_check_beast_color(_list_beasts_alive);
			hscr_battle_check_beast_archetype(_list_beasts_alive);
			hscr_battle_check_beast_class(_list_beasts_alive);

			break;
		}

		//================//
		//LEFT CLICK//
		//================//
		if (
			mouse_check_button_pressed(mb_left) &&
			!_flag_clicked
		){

			//====================//
			//GET CLICKED BEAST//
			//====================//
			var _ref_clicked_beast = instance_position(
				_val_mouse_x,
				_val_mouse_y,
				obj_battle_beast
			);

			//====================//
			//CHECK VALID CORPSE//
			//====================//
			var _flag_valid_corpse = (
				instance_exists(_ref_clicked_beast) &&
				_ref_clicked_beast._str_list == "DEAD" &&
				_ref_clicked_beast._val_cur_hp <= 0 &&
				!_ref_clicked_beast._flag_captured &&
				!_ref_clicked_beast._flag_corpse_consumed
			);

			//==================//
			//SACRIFICE CORPSE//
			//==================//
			if (_flag_valid_corpse){

				audio_play_sound(snd_gui_press,0,false);

				_flag_clicked = true;

				global.ref_target_corpse = _ref_clicked_beast;

				_state_player = ENUM_PLAYER_STATE.CARD_EXECUTE;

				break;
			}

			//================//
			//SACRIFICE HP//
			//================//
			if (
				_stct_corpse_card._str_card_range == "CORPSE_OPTIONAL" &&
				_flag_allow_empty_target
			){

				audio_play_sound(snd_gui_press,0,false);

				_flag_clicked = true;

				global.ref_target_corpse = undefined;

				_state_player = ENUM_PLAYER_STATE.CARD_EXECUTE;

				break;
			}

			//================//
			//INVALID CORPSE//
			//================//
			if (instance_exists(_ref_clicked_beast)){

				audio_play_sound(snd_gui_error,0,false);

				scr_gui_spawn_popup_error(
					"INVALID CORPSE",
					60
				);
			}
		}

	break;
	#endregion

	//
	// CARD EXECUTE
	//
	#region CARD EXECUTE
	case ENUM_PLAYER_STATE.CARD_EXECUTE:

		// Failed preflight does not qualify for post-cast Tutor/Rekindle/Discard effects.
		if (!scr_battle_cast_card()){
			_state_player = ENUM_PLAYER_STATE.SELECT_CARD;
			hscr_battle_check_card_oom(_list_battle_hand);
			break;
		}

		//======================//
		//CHECK REKINDLE QUEUE//
		//======================//
		if (_ct_rekindle_pending > 0){

			var _arr_rekindle_candidates = scr_battle_get_exhausted_color_candidates(
				"VERMILION",
				_ref_rekindle_source_card
			);

			//================//
			//OPEN SELECTION//
			//================//
			if (array_length(_arr_rekindle_candidates) > 0){

				var _ref_rekindle_gui = instance_create_layer(
					room_width * 0.5,
					room_height * 0.5,
					"ily_fx",
					obj_gui_battle_exhaust_select
				);

				_ref_rekindle_gui.hscr_gui_init_exhaust_select(
					_arr_rekindle_candidates,
					"VERMILION",
					_ref_rekindle_source_card
				);

				_state_player = ENUM_PLAYER_STATE.TUTOR_SELECT;

				break;
			}

			//----------------//
			//NO VALID CARDS//
			//----------------//
			_ct_rekindle_pending = 0;
			_ref_rekindle_source_card = undefined;

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"NO EXHAUSTED VERMILION CARDS",
				undefined,
				c_ltgray,
				room_width * 0.5,
				room_height * 0.5
			);
		}

		//------------------//
		//CHECK TUTOR QUEUE//
		//------------------//
		if (_ct_utility_tutors_pending > 0){

			if (hscr_battle_open_utility_tutor()){

				_state_player = ENUM_PLAYER_STATE.TUTOR_SELECT;

				break;
			}
		}

		//--------------------------//
		//CHECK EFFECT DISCARD QUEUE//
		//--------------------------//
		if (
			_ct_effect_discards_pending > 0 &&
			ds_list_size(_list_battle_hand) > 0
		){

			var _str_card_word =
				(_ct_effect_discards_pending == 1)
				? " CARD"
				: " CARDS";

			scr_gui_spawn_popup_error(
				"DISCARD " +
					string(_ct_effect_discards_pending) +
					_str_card_word,
				1000000000
			);

			_state_player = ENUM_PLAYER_STATE.DISCARD_EFFECT;
		}
		else{

			//----------------//
			//NORMAL CARD FLOW//
			//----------------//
			_ct_effect_discards_pending = 0;

			_state_player = ENUM_PLAYER_STATE.SELECT_CARD;

			hscr_battle_check_card_oom(_list_battle_hand);
		}

	break;
	#endregion

	//
	// TUTOR SELECT
	//
	#region TUTOR SELECT
	case ENUM_PLAYER_STATE.TUTOR_SELECT:

		/*
			obj_gui_battle_tutor owns Tutor input.

			Normal Card selection remains locked until the player
			chooses a Card from the Tutor GUI.
		*/

	break;
	#endregion

	//
	// TURN END
	//
	#region TURN END
	case ENUM_PLAYER_STATE.TURN_END:

		//---------------------//
		//BUILD HELD ITEM QUEUE//
		//---------------------//
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

				scr_battle_init_wait(15);
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

			//---------------//
			//BEAST STATUSES//
			//---------------//
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

			//----------------//
			//GLOBAL STATUSES//
			//----------------//
			if (ds_exists(global.list_statuses,ds_type_list)){

				for (var _it_global_status = 0;_it_global_status < ds_list_size(global.list_statuses);_it_global_status++){

					var _ref_status = ds_list_find_value(global.list_statuses,_it_global_status);

					if (!instance_exists(_ref_status)){
						continue;
					}

					//--------------------------//
					//CHECK EVENT TURN OWNERSHIP//
					//--------------------------//
					if (
						_ref_status._str_status_type == "EVENT" &&
						variable_instance_exists(_ref_status,"_str_event_owner_team") &&
						_ref_status._str_event_owner_team != "PLAYER"
					){
						continue;
					}

					ds_list_add(_list_statuses,_ref_status);
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

					scr_battle_init_wait(15);
				}
				else{
					ds_list_delete(_list_statuses,0);
				}
			}
			else{

				ds_list_destroy(_list_statuses);
				_list_statuses = undefined;

				_flag_statuses_init = false;

				//--------------------------//
				//DISCARD DOWN TO HAND SIZE//
				//--------------------------//
				if (ds_list_size(_list_battle_hand) > _ct_hand_size){

					scr_gui_spawn_popup_error(
						"DISCARD DOWN TO " + string(_ct_hand_size) + " CARDS",
						1000000000
					);

					_state_player = ENUM_PLAYER_STATE.DISCARD_DOWN;
				}
				else{

					//---------------//
					//DRAW NEW CARDS//
					//---------------//
					scr_battle_draw_cards(_ct_draw_amount);

					hscr_battle_check_card_oom(_list_battle_hand);

					hscr_battle_finish_player_turn();
				}
			}
		}

	break;
	#endregion

	//
	// DISCARD CARD EFFECT
	//
	#region DISCARD CARD EFFECT
	case ENUM_PLAYER_STATE.DISCARD_EFFECT:

		//----------------//
		//DISCARD COMPLETE//
		//----------------//
		if (
			_ct_effect_discards_pending <= 0 ||
			ds_list_size(_list_battle_hand) <= 0
		){

			_ct_effect_discards_pending = 0;

			instance_destroy(obj_gui_popup_error);

			scr_battle_reposition_hand();

			hscr_battle_check_card_oom(_list_battle_hand);

			_state_player = ENUM_PLAYER_STATE.SELECT_CARD;

			break;
		}

		//----------------//
		//SELECT DISCARD//
		//----------------//
		if (
			mouse_check_button_pressed(mb_left) &&
			!_flag_clicked &&
			instance_exists(_ref_hover_card)
		){

			var _ref_card = _ref_hover_card;

			if (
				instance_exists(_ref_card) &&
				_ref_card._str_team == "PLAYER" &&
				_ref_card._str_location == "HAND"
			){

				audio_play_sound(snd_battle_card_move,0,false);

				_flag_clicked = true;

				scr_battle_discard_card(_ref_card);

				_ct_effect_discards_pending--;
			}
		}

		//------------------//
		//RELEASE CLICK LOCK//
		//------------------//
		if (mouse_check_button_released(mb_left)){
			_flag_clicked = false;
		}

	break;
	#endregion

//
// DISCARD DOWN
//
#region DISCARD DOWN
case ENUM_PLAYER_STATE.DISCARD_DOWN:

	//-----------------//
	//DISCARD COMPLETE//
	//-----------------//
	if (ds_list_size(_list_battle_hand) <= _ct_hand_size){

		instance_destroy(obj_gui_popup_error);

		scr_battle_reposition_hand();

		//---------------//
		//DRAW NEW CARDS//
		//---------------//
		scr_battle_draw_cards(_ct_draw_amount);

		hscr_battle_check_card_oom(_list_battle_hand);

		hscr_battle_finish_player_turn();

		break;
	}

	//----------------//
	//SELECT DISCARD//
	//----------------//
	if (
		!_flag_clicked &&
		mouse_check_button_pressed(mb_left) &&
		instance_exists(_ref_hover_card)
	){

		var _ref_card = _ref_hover_card;

		if (
			instance_exists(_ref_card) &&
			_ref_card._str_team == "PLAYER" &&
			_ref_card._str_location == "HAND"
		){

			audio_play_sound(snd_battle_card_move,0,false);

			_flag_clicked = true;

			scr_battle_discard_card(_ref_card);
		}
	}

	//------------------//
	//RELEASE CLICK LOCK//
	//------------------//
	if (mouse_check_button_released(mb_left)){
		_flag_clicked = false;
	}

break;
#endregion
}

#region CLICK COOLDOWN

//----------------------//
//UPDATE CLICK COOLDOWN//
//----------------------//
if (_val_cooldown > 0){

	_val_cooldown--;

	if (_val_cooldown <= 0){

		_val_cooldown = 10;
		_flag_clicked = false;
	}
}

#endregion
