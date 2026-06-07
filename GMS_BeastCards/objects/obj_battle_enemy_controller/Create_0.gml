//
//
// CREATE: OBJ_BATTLE_ENEMY_CONTROLLER
//
//

//
//VARIABLES
//

//BEASTS
_beast_number = irandom_range(1,1);
_statuses_init = false;
_beasts_list = ds_list_create();
_beasts_alive = ds_list_create();
_beasts_graveyard = ds_list_create();
_casting_units = ds_list_create();
_cast_init = false;
_minions_init = false;

//ENEMY STATE
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

//
//INIT
//

//
//METHODS
//
