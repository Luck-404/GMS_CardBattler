//===============================================================================//
//
// CREATE: OBJ_BATTLE_ENEMY_CONTROLLER
// FUNCTION: Initializes enemy battle state.
//           Stores enemy beast lists, casting trackers, and state flags.
//           Defines the enemy battle state machine enum.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//

// BEASTS
//_ct_beast = irandom_range(1,3);
//_ct_beast = 3;


_list_beasts = ds_list_create();
_list_beasts_alive = ds_list_create();
_list_beasts_graveyard = ds_list_create();

_list_casting_units = ds_list_create();

// STATE FLAGS
_flag_statuses_init = false;
_flag_cast_init = false;
_flag_minions_init = false;

// TURN START ITEMS
_flag_turn_start_items_init = false;
_flag_turn_start_items_complete = false;
_list_turn_start_items = undefined;
// TURN END ITEMS
_flag_turn_end_items_init = false;
_flag_turn_end_items_complete = false;
_list_turn_end_items = undefined;

// ENEMY STATE
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

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//