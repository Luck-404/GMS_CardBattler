//////////////////////////////////////////////////////////////////////
//						OBJ_PLAYER CREATE							//
//																	//
// > THE MAIN PLAYER UNIT, MOST USER-GAME INTERACTIONS ARE RAN		//
//	 THROUGH THIS OBJECT											//
//////////////////////////////////////////////////////////////////////

//overworld state enumerator
enum PLAYER_OW_STATE {
	IDLE,
	MOVE_CHECK,
	MOVE,
	MOVE_TICK,
	PAUSE
}
global.player_ow_state = PLAYER_OW_STATE.IDLE;

//location and movement
global.player_xpos = 0;
global.player_ypos = 0;
global.saved_room = room;
_move_speed = 0;
_target_x = x; // Current position
_target_y = y;
_hop_start = false;
_hop_offset = 0;
_hop_dx = 0;
_hop_dy = 0;
global.step_count = 0;
_move_left = 0;
_move_right = 0;
_move_up = 0;
_move_down = 0;
	
//deck stuff
_flag_deck_created = false;
global.card_inventory = ds_list_create(); //create inventory

//creature stuff
_flag_party_spawned = false;
global.player_team = ds_list_create(); 
global.player_team_in_play = ds_list_create(); 
global.player_team_dead = ds_list_create();
global.graveyard = ds_list_create(); 

//blessings
global.blessings_list = ds_list_create();

//general stats
global.hand_size = 3; // Maximum of 3 cards in the hand
global.max_mana_saved = 3;
global.max_mana = 3;
global.current_mana = 3;
global.gold = 0;
global.randgold = 0;

// CAMERA 
_flag_created_camera = false; 
global._camera = undefined;

_flag_transition_start = false; //HAVE I STARTED A TRANSITION
_counter_particles = 0;

//encounter state enumerator
enum PLAYER_ENCOUNTER_STATE {
	INIT,
	BEGIN_TURN,
	MINIONS_CAST,
	SHUFFLING,
	DRAW,
	PICK_CARD,
	PICK_CHANNEL,
	PICK_TARGET,
	CASTING,
	END_TURN,
	ENEMY_TURN_IDLE,
	EXIT_ENC,
	PAUSE
}
global.player_enc_state = PLAYER_ENCOUNTER_STATE.PAUSE;