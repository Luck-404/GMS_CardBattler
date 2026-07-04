//===============================================================================//
//
// STEP: OBJ_BATTLE_PLAYER_CONTROLLER
// FUNCTION: Executes the player battle state machine.
//           Handles beast setup, card setup, turn flow, casting selection,
//           status processing, minions, and discard-down behavior.
//
//===============================================================================//

switch(_state_player){

	//
	// INIT BEASTS
	//
	#region INIT BEASTS
	case ENUM_PLAYER_STATE.INIT_BEASTS:

		var _val_spawn_index = 0;

		for (var _it_beast = 0; _it_beast < ds_list_size(global.list_player_party); _it_beast++){

			var _stct_unit = ds_list_find_value(global.list_player_party,_it_beast);

			if (_stct_unit == undefined){
				continue;
			}

			// SKIP DEAD UNITS
			if (_stct_unit._val_beast_hp_cur <= 0){
				continue;
			}

			var _ref_beast = instance_create_layer(room_width * 0.5 - 80 - (100 * _val_spawn_index),room_height * 0.5,"ily_player",obj_battle_beast);

			
			_ref_beast._spr_beast = _stct_unit._spr_beast;
			_ref_beast._ref_unit = _stct_unit;
			_ref_beast._str_team = "PLAYER";
			_ref_beast._uid_beast = _stct_unit._uid_beast;

			// COMPACT SLOT INDEX
			_ref_beast._val_pos = _val_spawn_index;

			_ref_beast._ct_minions_max = _stct_unit._val_beast_min_stat;
			_ref_beast._val_cur_hp = _stct_unit._val_beast_hp_cur;
			_ref_beast._val_max_hp = _stct_unit._val_beast_hp_max;

			ds_list_add(_list_beasts,_ref_beast);
			ds_list_add(_list_beasts_alive,_ref_beast);

			_val_spawn_index++;
		}

		_state_player = ENUM_PLAYER_STATE.INIT_CARDS;

	break;
	#endregion
	
	//
	// INIT CARDS
	//
	#region INIT CARDS
	case ENUM_PLAYER_STATE.INIT_CARDS:

		for (var _it_card = 0; _it_card < ds_list_size(global.list_player_deck); _it_card++){

			var _stct_card = ds_list_find_value(global.list_player_deck,_it_card);

			if (_stct_card == undefined){
				continue;
			}

			var _ref_card = instance_create_layer(70,room_height - 100,"ily_player",obj_battle_card);

			_ref_card._spr_card = _stct_card._spr_card;
			_ref_card._uid_card = _stct_card._uid_card;
			_ref_card._str_team = "PLAYER";
			_ref_card._ref_card = _stct_card;
			_ref_card._str_location = "DECK";

			ds_list_add(_list_battle_deck,_ref_card);
		}

		ds_list_shuffle(_list_battle_deck);

		scr_draw_cards(_ct_hand_size);

		_state_player = ENUM_PLAYER_STATE.TRIGGER_ENTRY_EFFECTS;

	break;
	#endregion

	//
	// TRIGGER ENTRY EFFECTS
	//
	#region TRIGGER ENTRY EFFECTS
	case ENUM_PLAYER_STATE.TRIGGER_ENTRY_EFFECTS:

		obj_battle_turn_controller._flag_game_start = true;

		_state_player = ENUM_PLAYER_STATE.WAIT;

	break;
	#endregion
	
	//
	// WAIT
	//
	#region WAIT
	case ENUM_PLAYER_STATE.WAIT:

		_flag_statuses_init = false;
		_flag_minions_init = false;

	break;
	#endregion
	
	//
	// TURN START
	//
	#region TURN START
	case ENUM_PLAYER_STATE.TURN_START:

		if (!_flag_statuses_init){

			_flag_statuses_init = true;

			// RESTORE MANA
			_val_max_mana = _val_max_mana;
			_val_cur_mana = _val_max_mana;

			// DEGRADE SHIELDS
			for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

				var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

				scr_degrade_shield(_ref_beast);
			}

			// BUILD STATUS QUEUE
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

		if (!_flag_minions_init){

			_flag_minions_init = true;
			_list_casting_minions = ds_list_create();

			for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

				var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

				for (var _it_minion = 0; _it_minion < ds_list_size(_ref_beast._list_minions); _it_minion++){
					ds_list_add(_list_casting_minions,ds_list_find_value(_ref_beast._list_minions,_it_minion));
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

				_state_player = ENUM_PLAYER_STATE.SELECT_CARD;

				hscr_check_battle_card_oom(_list_battle_hand);
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

		//
		// END TURN
		//
		#region END TURN
		if (mouse_check_button_pressed(mb_left) && !_flag_clicked && position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_battle_end_turn_button)){
			_flag_clicked = true;
			_state_player = ENUM_PLAYER_STATE.TURN_END;
			break;
		}
		#endregion

		//
		// LEFT CLICK SELECTS CARD
		//
		#region LEFT CLICK SELECTS CARD
		if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_battle_card) && mouse_check_button_pressed(mb_left) && !_flag_clicked){

			_flag_clicked = true;

			var _ref_card = instance_nearest(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_battle_card);

			if (_ref_card != undefined && _ref_card._str_location == "HAND" && _ref_card._str_team == "PLAYER" && !_ref_card._flag_card_oom_check){

				global.ref_cast_card = _ref_card;

				_state_player = ENUM_PLAYER_STATE.SELECT_CASTER;

				hscr_check_battle_beast_able(_list_beasts_alive);
				hscr_check_battle_beast_color(_list_beasts_alive);
				hscr_check_battle_beast_archetype(_list_beasts_alive);
				hscr_check_battle_beast_class(_list_beasts_alive);
			}
		}
		#endregion

	break;
	#endregion
	
	//
	// SELECT CASTER
	//
	#region SELECT CASTER
	case ENUM_PLAYER_STATE.SELECT_CASTER:

		//
		// END TURN
		//
		#region END TURN
		if (mouse_check_button_pressed(mb_left) && !_flag_clicked && position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_battle_end_turn_button)){
			_flag_clicked = true;
			_state_player = ENUM_PLAYER_STATE.TURN_END;
			break;
		}
		#endregion

		//
		// RIGHT CLICK SENDS BACK
		//
		#region RIGHT CLICK SENDS BACK
		if (mouse_check_button_pressed(mb_right) && !_flag_clicked){
			_flag_clicked = true;

			_state_player = ENUM_PLAYER_STATE.SELECT_CARD;
			global.ref_cast_card = undefined;

			hscr_check_battle_card_oom(_list_battle_hand);

			break;
		}
		#endregion

		//
		// LEFT CLICK SELECTS CASTER
		//
		#region LEFT CLICK SELECTS CASTER
		if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_battle_beast) && mouse_check_button_pressed(mb_left) && !_flag_clicked){

			_flag_clicked = true;

			var _ref_beast_clicked = instance_nearest(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_battle_beast);

			if (_ref_beast_clicked != undefined && _ref_beast_clicked._val_cur_hp > 0){

				if (_ref_beast_clicked._str_team == "PLAYER" && _ref_beast_clicked._flag_beast_color_check && _ref_beast_clicked._flag_beast_able_check && _ref_beast_clicked._flag_beast_archetype_check && _ref_beast_clicked._flag_beast_class_check){

					global.ref_caster_beast = _ref_beast_clicked;

					_state_player = ENUM_PLAYER_STATE.SELECT_TARGET;

					var _str_card_range = global.ref_cast_card._ref_card._str_card_range;

					if (_str_card_range != "GLOBAL"){
						hscr_check_battle_beast_range(_list_beasts_alive,_str_card_range);
					}
				}
			}
		}
		#endregion

	break;
	#endregion
	
	//
	// SELECT TARGET
	//
	#region SELECT TARGET
	case ENUM_PLAYER_STATE.SELECT_TARGET:

		//
		// END TURN
		//
		#region END TURN
		if (mouse_check_button_pressed(mb_left) && !_flag_clicked && position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_battle_end_turn_button)){
			_flag_clicked = true;
			_state_player = ENUM_PLAYER_STATE.TURN_END;
			break;
		}
		#endregion

		//
		// RIGHT CLICK SENDS BACK
		//
		#region RIGHT CLICK SENDS BACK
		if (mouse_check_button_pressed(mb_right) && !_flag_clicked){
			_flag_clicked = true;

			_state_player = ENUM_PLAYER_STATE.SELECT_CASTER;
			global.ref_caster_beast = undefined;

			hscr_check_battle_beast_able(_list_beasts_alive);
			hscr_check_battle_beast_color(_list_beasts_alive);
			hscr_check_battle_beast_archetype(_list_beasts_alive);
			hscr_check_battle_beast_class(_list_beasts_alive);

			break;
		}
		#endregion

		var _str_card_range = global.ref_cast_card._ref_card._str_card_range;

		//
		// GLOBAL CARD HANDLE
		//
		#region GLOBAL CARD HANDLE
		if (_str_card_range == "GLOBAL"){

			if (mouse_check_button_pressed(mb_left) && !_flag_clicked){
				_flag_clicked = true;

				global.ref_target_beast = "GLOBAL";

				_state_player = ENUM_PLAYER_STATE.CARD_EXECUTE;
			}
		}
		#endregion

		//
		// LEFT CLICK SELECTS TARGET
		//
		#region LEFT CLICK SELECTS TARGET
		if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_battle_beast) && mouse_check_button_pressed(mb_left) && !_flag_clicked && _str_card_range != "GLOBAL"){

			_flag_clicked = true;

			var _ref_beast_clicked = instance_nearest(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_battle_beast);

			if (_ref_beast_clicked != undefined && _ref_beast_clicked._val_cur_hp > 0){

				if (_ref_beast_clicked._flag_beast_range_check){
					global.ref_target_beast = _ref_beast_clicked;

					_state_player = ENUM_PLAYER_STATE.CARD_EXECUTE;
				}
			}
		}
		#endregion

	break;
	#endregion
	
	//
	// CARD EXECUTE
	//
	#region CARD EXECUTE
	case ENUM_PLAYER_STATE.CARD_EXECUTE:

		scr_cast_card();

		_state_player = ENUM_PLAYER_STATE.SELECT_CARD;

		hscr_check_battle_card_oom(_list_battle_hand);

	break;
	#endregion
	
	//
	// TURN END
	//
	#region TURN END
	case ENUM_PLAYER_STATE.TURN_END:

		if (!_flag_statuses_init){

			_flag_statuses_init = true;

			// BUILD STATUS QUEUE
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

			for (var _it_global_statuses = 0; _it_global_statuses < ds_list_size(_list_beasts_alive); _it_global_statuses++){

				var _ref_status = ds_list_find_value(global.list_statuses,_it_global_statuses)
					ds_list_add(
						_list_statuses,
						_ref_status
					);
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

				// DISCARD DOWN TO HAND SIZE
				if (ds_list_size(_list_battle_hand) > _ct_hand_size){
					scr_spawn_popup_error("DISCARD DOWN TO 5 CARDS",1000000000);
					_state_player = ENUM_PLAYER_STATE.DISCARD_DOWN;
				}
				else{

					// DRAW NEW CARDS
					scr_draw_cards(_ct_draw_amount);

					hscr_check_battle_card_oom(_list_battle_hand);

					obj_battle_turn_controller.hscr_pass_turn();

					_state_player = ENUM_PLAYER_STATE.WAIT;
				}
			}
		}

	break;
	#endregion
	
	//
	// DISCARD DOWN
	//
	#region DISCARD DOWN
	case ENUM_PLAYER_STATE.DISCARD_DOWN:

		if (ds_list_size(_list_battle_hand) <= _ct_hand_size){

			instance_destroy(obj_popup_error);

			scr_reposition_cards();

			_state_player = ENUM_PLAYER_STATE.WAIT;

			obj_battle_turn_controller.hscr_pass_turn();

			break;
		}

		if (!_flag_clicked){

			if (mouse_check_button_pressed(mb_left)){

				if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_battle_card)){

					_flag_clicked = true;

					var _ref_card = instance_nearest(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_battle_card);

					if (instance_exists(_ref_card)){
						scr_discard_card(_ref_card);
					}
				}
			}
		}

		if (mouse_check_button_released(mb_left)){
			_flag_clicked = false;
		}

	break;
	#endregion
}

//
// CLICK COOLDOWNS
//
#region CLICK COOLDOWNS
if (_val_cooldown > 0){

	_val_cooldown--;

	if (_val_cooldown <= 0){
		_val_cooldown = 10;
		_flag_clicked = false;
	}
}
#endregion