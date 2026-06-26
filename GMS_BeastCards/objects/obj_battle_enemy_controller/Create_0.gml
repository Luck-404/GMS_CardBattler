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
_ct_beast = irandom_range(1,1);

_list_beasts = ds_list_create();
_list_beasts_alive = ds_list_create();
_list_beasts_graveyard = ds_list_create();

_list_casting_units = ds_list_create();

// STATE FLAGS
_flag_statuses_init = false;
_flag_cast_init = false;
_flag_minions_init = false;

// ENEMY STATE
enum ENEMY_STATE{
	INIT_BEASTS,
	INIT_CARDS,
	TRIGGER_ENTRY_EFFECTS,
	WAIT,
	TURN_START,
	TRIGGER_MINIONS,
	CAST_CARDS,
	NEW_CARDS,
	TURN_END
}

_enemy_state = ENEMY_STATE.INIT_BEASTS;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//