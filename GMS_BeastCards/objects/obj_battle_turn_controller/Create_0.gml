//===============================================================================//
//
// CREATE: OBJ_BATTLE_TURN_CONTROLLER
// FUNCTION: Initializes battle controllers and turn order.
//           Manages ordered battle-entry trigger execution.
//           Defines helper scripts for entry queues and passing turns.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//

_arr_team_traps = [];

// CONTROLLERS
_ref_player_controller = instance_create_layer(x,y,"ily_player",obj_battle_player_controller);
_ref_enemy_controller = instance_create_layer(x,y,"ily_enemy",obj_battle_enemy_controller);

_ref_end_turn_button = instance_create_layer(928,650,"ily_fx",obj_battle_end_turn_button);

// TURN ORDER
_arr_turn_order = [_ref_player_controller,_ref_enemy_controller];
_val_turn_tracker = 0;

// ENTRY TRIGGERS
_list_entry_triggers = undefined;

_flag_entry_triggers_init = false;
_flag_entry_triggers_complete = false;

// BATTLE STATE
_flag_game_start = false;
_flag_started_game = false;
_flag_battle_ended = false;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_add_entry_item_triggers
// FUNCTION: Checks battle beasts for ENTRY held items.
//           Adds valid item triggers to the battle entry trigger queue.
//—------------------------------------------------------------------------------//
function hscr_add_entry_item_triggers(_list_beasts){

	for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts); _it_beast++){

		var _ref_beast = ds_list_find_value(_list_beasts,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		var _stct_item = _ref_beast._stct_held_item;

		if (_stct_item == undefined || _stct_item == "EMPTY"){
			continue;
		}

		if (_stct_item._str_item_trigger_type != "ENTRY"){
			continue;
		}

		var _stct_trigger = {
			_str_trigger_source : "ITEM",
			_ref_beast : _ref_beast,
			_stct_item : _stct_item
		};

		ds_list_add(_list_entry_triggers,_stct_trigger);
	}
}

//—------------------------------------------------------------------------------//
// hscr_build_entry_trigger_queue
// FUNCTION: Builds the battle-entry trigger queue.
//           Collects Beast-owned entry triggers from both teams.
//           Sorts simultaneous triggers by current Beast Speed.
//           Exact Speed ties receive a randomized Beast order.
//—------------------------------------------------------------------------------//
function hscr_build_entry_trigger_queue(){

	_list_entry_triggers = ds_list_create();

	//--------------------//
	//COLLECT ALL TRIGGERS//
	//--------------------//
	hscr_add_entry_item_triggers(_ref_player_controller._list_beasts_alive);
	hscr_add_entry_item_triggers(_ref_enemy_controller._list_beasts_alive);

	//----------------//
	//SORT BY SPEED//
	//----------------//
	scr_sort_beast_trigger_queue_by_speed(_list_entry_triggers);

	_flag_entry_triggers_init = true;
}

//—------------------------------------------------------------------------------//
// hscr_set_initial_turn_order
// FUNCTION: Calculates each team's average current Speed.
//           Gives the first turn to the team with the higher average Speed.
//           Resolves an exact team-average tie with a 50/50 coin flip.
//           Sets the turn tracker so normal alternating turn flow continues.
//
//—------------------------------------------------------------------------------//
function hscr_set_initial_turn_order(){

	var _val_player_speed =
		scr_get_team_average_speed(
			_ref_player_controller._list_beasts_alive
		);

	var _val_enemy_speed =
		scr_get_team_average_speed(
			_ref_enemy_controller._list_beasts_alive
		);

	var _flag_player_first = false;

	//--------------------//
	//PLAYER FASTER//
	//--------------------//
	if (_val_player_speed > _val_enemy_speed){

		_flag_player_first = true;
	}

	//-------------------//
	//ENEMY FASTER//
	//-------------------//
	else if (_val_enemy_speed > _val_player_speed){

		_flag_player_first = false;
	}

	//----------------//
	//EXACT SPEED TIE//
	//----------------//
	else{

		_flag_player_first = (irandom(1) == 0);
	}


	//----------------//
	//START FIRST TURN//
	//----------------//
	if (_flag_player_first){

		_val_turn_tracker = 0;

		_ref_player_controller._state_player =
			ENUM_PLAYER_STATE.TURN_START;

		show_debug_message(
			"BATTLE INITIATIVE | PLAYER FIRST | PLAYER AVG SPEED: " +
			string(_val_player_speed) +
			" | ENEMY AVG SPEED: " +
			string(_val_enemy_speed)
		);
	}
	else{

		/*
			Tracker 1 represents the enemy side of the normal
			player/enemy turn alternation. This ensures that
			hscr_pass_turn() sends control to the player after
			the enemy's opening turn.
		*/
		_val_turn_tracker = 1;

		_ref_enemy_controller._state_enemy =
			ENUM_ENEMY_STATE.TURN_START;

		show_debug_message(
			"BATTLE INITIATIVE | ENEMY FIRST | PLAYER AVG SPEED: " +
			string(_val_player_speed) +
			" | ENEMY AVG SPEED: " +
			string(_val_enemy_speed)
		);
	}
}

//—------------------------------------------------------------------------------//
// hscr_execute_entry_trigger
// FUNCTION: Executes one battle-entry trigger.
//           Calls the source item's TRIGGER behavior.
//           Consumes held items after successful trigger resolution.
//—------------------------------------------------------------------------------//
function hscr_execute_entry_trigger(_stct_trigger){

	if (_stct_trigger == undefined){
		return false;
	}

	var _ref_beast = _stct_trigger._ref_beast;

	if (!instance_exists(_ref_beast)){
		return false;
	}

	switch(_stct_trigger._str_trigger_source){

		case "ITEM":

			var _stct_item = _stct_trigger._stct_item;

			if (_stct_item == undefined){
				return false;
			}

			if (_stct_item._scr_item == undefined){
				return false;
			}

			var _str_popup = _stct_item._str_item_name + " " + _stct_item._str_trigger_text;
			scr_spawn_popup_trigger_banner(_str_popup);

			var _flag_triggered = _stct_item._scr_item(
				"TRIGGER",
				_stct_item,
				_ref_beast._ref_unit
			);

			if (_flag_triggered){
				_ref_beast._stct_held_item = "EMPTY";
			}

			return _flag_triggered;

		break;
	}

	return false;
}

//—------------------------------------------------------------------------------//
// hscr_pass_turn
// FUNCTION: Passes turn control between player and enemy controllers.
//—------------------------------------------------------------------------------//
function hscr_pass_turn(){

	//----------------//
	//UPDATE BANISH//
	//----------------//
	scr_update_banished_beasts();

	if (_val_turn_tracker == 0){
		_val_turn_tracker++;
		_ref_enemy_controller._state_enemy = ENUM_ENEMY_STATE.TURN_START;
	}
	else{
		_val_turn_tracker = 0;
		_ref_player_controller._state_player = ENUM_PLAYER_STATE.TURN_START;
	}
}

#endregion