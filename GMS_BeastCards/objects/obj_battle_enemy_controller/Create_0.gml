//===============================================================================//
//
// CREATE: OBJ_BATTLE_ENEMY_CONTROLLER
// FUNCTION: Initializes enemy battle state.
//           Stores enemy Beast lists, temporary turn-processing queues,
//           enemy level range, state flags, and the enemy state machine.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
#region VARIABLES

//--------//
//BEASTS//
//--------//
//_ct_beasts = irandom_range(1,3);
_ct_beasts = 3;

_list_beasts = ds_list_create();
_list_beasts_alive = ds_list_create();
_list_beasts_graveyard = ds_list_create();

//-------------------//
//ENEMY LEVEL SCALING//
//-------------------//
_val_enemy_level_min = 3;
_val_enemy_level_max = 5;

//-------------//
//TURN QUEUES//
//-------------//
_list_casting_beasts = undefined;
_list_casting_minions = undefined;
_list_statuses = undefined;

_list_turn_start_items = undefined;
_list_turn_end_items = undefined;

//------------------//
//PROCESSING FLAGS//
//------------------//
_flag_statuses_init = false;
_flag_cast_init = false;
_flag_minions_init = false;

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

#endregion

//----//
//INIT//
//----//
#region INIT

//-------------//
//ENEMY STATE//
//-------------//
enum ENUM_ENEMY_STATE{
	INIT_BEASTS,
	INIT_CARDS,
	WAIT,
	TURN_START,
	TRIGGER_MINIONS,
	CAST_CARDS,
	NEW_CARDS,
	TURN_END
}

_state_enemy = ENUM_ENEMY_STATE.INIT_BEASTS;

//-------------------//
//GET ENCOUNTER STATE//
//-------------------//
var _ct_encounter_pool = 0;
var _flag_forced_enemy = false;

if (
	variable_global_exists("arr_last_enemy_pool") &&
	is_array(global.arr_last_enemy_pool)
){
	_ct_encounter_pool = array_length(global.arr_last_enemy_pool);
}

if (
	variable_global_exists("stct_forced_enemy_unit") &&
	is_struct(global.stct_forced_enemy_unit)
){
	_flag_forced_enemy = true;
}

//----------------//
//DEBUG INITIALIZE//
//----------------//
scr_debug_log(
	"BATTLE",
	"ENEMY",
	self,
	"ENEMY BATTLE CONTROLLER INITIALIZED | TEAM SIZE: " + string(_ct_beasts) +
	" | LEVEL RANGE: " + string(_val_enemy_level_min) +
	"-" + string(_val_enemy_level_max) +
	" | ENCOUNTER POOL: " + string(_ct_encounter_pool) +
	" | FORCED SLOT 0: " + (_flag_forced_enemy ? "YES" : "NO"),
	"INIT",
	"OBJ_BATTLE_ENEMY_CONTROLLER:CREATE"
);

#endregion

//-------//
//METHODS//
//-------//