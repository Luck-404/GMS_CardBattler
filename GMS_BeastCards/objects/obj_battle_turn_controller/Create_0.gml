//===============================================================================//
//
// CREATE: OBJ_BATTLE_TURN_CONTROLLER
// FUNCTION: Initializes battle controllers, turn order, entry-trigger state,
//           team Trap storage, and battle lifecycle state.
//           Defines local helpers for battle-entry triggers, initiative,
//           and turn passing.
//
//===============================================================================//

//========================//
//PREVENT DUPLICATE BATTLE//
//========================//
if (instance_number(obj_battle_turn_controller) > 1){

	scr_debug_log(
		"BATTLE",
		"TURN_CONTROLLER",
		self,
		"DUPLICATE TURN CONTROLLER DETECTED - DESTROYING DUPLICATE",
		"WARNING",
		"OBJ_BATTLE_TURN_CONTROLLER:CREATE"
	);

	instance_destroy();
	exit;
}

//---------//
//VARIABLES//
//---------//
#region VARIABLES

//------------//
//TEAM TRAPS//
//------------//
_arr_team_traps = [];

//-------------------//
//TURN DEBUG DISPLAY//
//-------------------//
_flag_show_turn_debug = true;

//-------------//
//CONTROLLERS//
//-------------//
_ref_player_controller = instance_create_layer(
	x,
	y,
	"ily_player",
	obj_battle_player_controller
);

_ref_enemy_controller = instance_create_layer(
	x,
	y,
	"ily_enemy",
	obj_battle_enemy_controller
);

_ref_end_turn_button = instance_create_layer(
	1055,
	793,
	"ily_fx",
	obj_battle_end_turn_button
);

//------------//
//TURN ORDER//
//------------//
_arr_turn_order = [
	_ref_player_controller,
	_ref_enemy_controller
];

_val_turn_tracker = 0;

_ct_round = 1;
_ct_normal_turns_completed = 0;

//----------------//
//ENTRY TRIGGERS//
//----------------//
_list_entry_triggers = undefined;

_flag_entry_triggers_init = false;
_flag_entry_triggers_complete = false;

//--------------//
//BATTLE STATE//
//--------------//
_flag_game_start = false;
_flag_started_game = false;
_flag_battle_ended = false;

//-------------------//
//START CONFIRMATION//
//-------------------//
_flag_start_confirmation_created = false;
_flag_start_confirmation_accepted = false;

_ref_start_battle_pane = undefined;

//------------------//
//OPENING INITIATIVE//
//------------------//
_val_player_opening_speed = 0;
_val_enemy_opening_speed = 0;

_str_opening_team = "";

#endregion

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_battle_add_entry_item_triggers
// FUNCTION: Checks active battle Beasts for ENTRY held items.
//           Adds valid held-item triggers to the battle-entry trigger queue.
//—------------------------------------------------------------------------------//
function hscr_battle_add_entry_item_triggers(_list_beasts){

	if (!ds_exists(_list_beasts,ds_type_list)){
		return;
	}

	var _ct_beasts = ds_list_size(_list_beasts);

	for (var _it_beast = 0; _it_beast < _ct_beasts; _it_beast++){

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

		//-----------------//
		//ADD ITEM TRIGGER//
		//-----------------//
		var _stct_trigger = {
			_str_trigger_source : "ITEM",
			_ref_beast : _ref_beast,
			_stct_item : _stct_item
		};

		ds_list_add(_list_entry_triggers,_stct_trigger);
	}
}

//—------------------------------------------------------------------------------//
// hscr_battle_build_entry_trigger_queue
// FUNCTION: Builds the battle-entry trigger queue from both active teams.
//           Sorts simultaneous Beast-owned triggers by current host Speed.
//           Exact Speed ties receive a randomized Beast order.
//—------------------------------------------------------------------------------//
function hscr_battle_build_entry_trigger_queue(){

	//--------------------//
	//RESET EXISTING QUEUE//
	//--------------------//
	if (
		_list_entry_triggers != undefined &&
		ds_exists(_list_entry_triggers,ds_type_list)
	){
		ds_list_destroy(_list_entry_triggers);
	}

	_list_entry_triggers = ds_list_create();

	//--------------------//
	//COLLECT ALL TRIGGERS//
	//--------------------//
	hscr_battle_add_entry_item_triggers(
		_ref_player_controller._list_beasts_alive
	);

	hscr_battle_add_entry_item_triggers(
		_ref_enemy_controller._list_beasts_alive
	);

	//---------------//
	//SORT BY SPEED//
	//---------------//
	scr_battle_sort_beast_trigger_queue_by_speed(
		_list_entry_triggers
	);

	_flag_entry_triggers_init = true;
}

//—------------------------------------------------------------------------------//
// hscr_battle_set_initial_turn_order
// FUNCTION: Calculates opening initiative without starting gameplay.
//—------------------------------------------------------------------------------//
function hscr_battle_set_initial_turn_order(){

	//========================//
	//GET TEAM AVERAGE SPEEDS//
	//========================//
	_val_player_opening_speed =
		scr_battle_get_team_average_speed(
			_ref_player_controller._list_beasts_alive
		);

	_val_enemy_opening_speed =
		scr_battle_get_team_average_speed(
			_ref_enemy_controller._list_beasts_alive
		);

	//================//
	//PLAYER FASTER//
	//================//
	if (_val_player_opening_speed > _val_enemy_opening_speed){

		_str_opening_team = "PLAYER";
		return;
	}

	//================//
	//ENEMY FASTER//
	//================//
	if (_val_enemy_opening_speed > _val_player_opening_speed){

		_str_opening_team = "ENEMY";
		return;
	}

	//================//
	//EXACT SPEED TIE//
	//================//
	_str_opening_team =
		(irandom(1) == 0)
		? "PLAYER"
		: "ENEMY";
}
//—------------------------------------------------------------------------------//
// hscr_battle_begin_initial_turn
// FUNCTION: Begins the opening turn using the initiative result already stored
//           for the pre-battle confirmation pane.
//—------------------------------------------------------------------------------//
function hscr_battle_begin_initial_turn(){

	//================//
//PLAYER FIRST//
//================//

	if (_str_opening_team == "PLAYER"){

		_val_turn_tracker = 0;

		_ref_player_controller._state_player =
			ENUM_PLAYER_STATE.TURN_START;

		scr_debug_log(
			"BATTLE",
			"INITIATIVE",
			self,
			"PLAYER FIRST" +
			" | PLAYER AVG SPEED: " +
			string(_val_player_opening_speed) +
			" | ENEMY AVG SPEED: " +
			string(_val_enemy_opening_speed),
			"BATTLE",
			"OBJ_BATTLE_TURN_CONTROLLER"
		);

		return;
	}

	//================//
//ENEMY FIRST//
//================//

	_val_turn_tracker = 1;

	_ref_enemy_controller._state_enemy =
		ENUM_ENEMY_STATE.TURN_START;

	scr_debug_log(
		"BATTLE",
		"INITIATIVE",
		self,
		"ENEMY FIRST" +
		" | PLAYER AVG SPEED: " +
		string(_val_player_opening_speed) +
		" | ENEMY AVG SPEED: " +
		string(_val_enemy_opening_speed),
		"BATTLE",
		"OBJ_BATTLE_TURN_CONTROLLER"
	);
}

//—------------------------------------------------------------------------------//
// hscr_battle_execute_entry_trigger
// FUNCTION: Executes one queued battle-entry trigger.
//           Resolves the source held item's TRIGGER behavior and consumes the
//           held item after a successful trigger.
//—------------------------------------------------------------------------------//
function hscr_battle_execute_entry_trigger(_stct_trigger){

	//------------------//
	//VALIDATE TRIGGER//
	//------------------//
	if (!is_struct(_stct_trigger)){
		return false;
	}

	if (!variable_struct_exists(_stct_trigger,"_ref_beast")){
		return false;
	}

	var _ref_beast = _stct_trigger._ref_beast;

	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (!variable_struct_exists(_stct_trigger,"_str_trigger_source")){
		return false;
	}

	//----------------//
	//EXECUTE TRIGGER//
	//----------------//
	switch(_stct_trigger._str_trigger_source){

		case "ITEM":

			if (!variable_struct_exists(_stct_trigger,"_stct_item")){
				return false;
			}

			var _stct_item = _stct_trigger._stct_item;

			if (_stct_item == undefined){
				return false;
			}

			if (_stct_item._scr_item == undefined){
				return false;
			}

			//----------------//
			//TRIGGER FEEDBACK//
			//----------------//
			var _str_popup =
				_stct_item._str_item_name +
				" " +
				_stct_item._str_trigger_text;

			scr_gui_spawn_popup_trigger_banner(_str_popup);

			//----------------//
			//EXECUTE ITEM//
			//----------------//
			var _flag_triggered = _stct_item._scr_item(
				"TRIGGER",
				_stct_item,
				_ref_beast._ref_unit
			);

			//----------------//
			//CONSUME ITEM//
			//----------------//
			if (_flag_triggered){
				_ref_beast._stct_held_item = "EMPTY";
			}

			return _flag_triggered;
	}

	return false;
}

//—------------------------------------------------------------------------------//
// HSCR_BATTLE_PASS_TURN
// FUNCTION: Advances Banish durations and passes normal turn control between
//           player and enemy teams. Tracks completed normal team turns and
//           advances the battle round after both teams complete one turn slot.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//—------------------------------------------------------------------------------//
function hscr_battle_pass_turn(){

	//----------------//
	//GET ENDING TEAM//
	//----------------//
	var _str_ending_team = "PLAYER";

	if (_val_turn_tracker == 1){
		_str_ending_team = "ENEMY";
	}

	//----------------//
	//UPDATE BANISH//
	//----------------//
	scr_cc_update_banished_beasts();

	//----------------------//
	//COUNT COMPLETED TURN//
	//----------------------//
	_ct_normal_turns_completed++;

	var _flag_round_complete =
		(_ct_normal_turns_completed mod 2 == 0);

	var _ct_completed_round = _ct_round;

	if (_flag_round_complete){
		_ct_round++;
	}

	//-------------------//
	//PASS TO ENEMY TURN//
	//-------------------//
	if (_val_turn_tracker == 0){

		_val_turn_tracker = 1;

		_ref_enemy_controller._state_enemy =
			ENUM_ENEMY_STATE.TURN_START;

		if (_flag_round_complete){

			scr_debug_log(
				"BATTLE",
				"ROUND",
				self,
				"ROUND " + string(_ct_completed_round) +
				" COMPLETE | " + _str_ending_team +
				" TURN COMPLETE -> ROUND " + string(_ct_round) +
				" | ENEMY TURN START",
				"BATTLE",
				"OBJ_BATTLE_TURN_CONTROLLER:HSCR_BATTLE_PASS_TURN"
			);
		}
		else{

			scr_debug_log(
				"BATTLE",
				"TURN",
				self,
				"ROUND " + string(_ct_round) +
				" | " + _str_ending_team +
				" TURN COMPLETE -> ENEMY TURN START",
				"BATTLE",
				"OBJ_BATTLE_TURN_CONTROLLER:HSCR_BATTLE_PASS_TURN"
			);
		}

		return;
	}

	//--------------------//
	//PASS TO PLAYER TURN//
	//--------------------//
	_val_turn_tracker = 0;

	_ref_player_controller._state_player =
		ENUM_PLAYER_STATE.TURN_START;

	if (_flag_round_complete){

		scr_debug_log(
			"BATTLE",
			"ROUND",
			self,
			"ROUND " + string(_ct_completed_round) +
			" COMPLETE | " + _str_ending_team +
			" TURN COMPLETE -> ROUND " + string(_ct_round) +
			" | PLAYER TURN START",
			"BATTLE",
			"OBJ_BATTLE_TURN_CONTROLLER:HSCR_BATTLE_PASS_TURN"
		);
	}
	else{

		scr_debug_log(
			"BATTLE",
			"TURN",
			self,
			"ROUND " + string(_ct_round) +
			" | " + _str_ending_team +
			" TURN COMPLETE -> PLAYER TURN START",
			"BATTLE",
			"OBJ_BATTLE_TURN_CONTROLLER:HSCR_BATTLE_PASS_TURN"
		);
	}
}

#endregion