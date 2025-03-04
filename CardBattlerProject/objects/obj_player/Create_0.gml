//////////////////////////////////////////////////////////////////////
//						OBJ_PLAYER CREATE							//
//																	//
// > THE MAIN PLAYER UNIT, MOST USER-GAME INTERACTIONS ARE RAN		//
//	 THROUGH THIS OBJECT											//
//////////////////////////////////////////////////////////////////////
image_speed = 0;
image_index = 0;
	
//overworld state enumerator
enum PLAYER_OW_STATE {
	GENERAL,
	INTERACT,
	PAUSED
}
global.player_ow_state = PLAYER_OW_STATE.GENERAL;

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
global.steps_rand = irandom_range(10,15);
_counter_particles = 0;
_moving = false;
_finish_move = false;
_move_left = 0;
_move_right = 0;
_move_up = 0;
_move_down = 0;
	
//deck stuff
_flag_deck_created = false;
global.player_deck = ds_list_create(); //create inventory
global.player_hand = ds_list_create(); //create hand to hold in an encounter turn
global.player_discard_pile = ds_list_create(); //create discard pile
global.player_exhaust_pile = ds_list_create(); //create exhaust pile
_card_selected = undefined;

//creature stuff
_flag_party_spawned = false;
global.player_party = ds_list_create(); 
global.player_party_in_play = ds_list_create(); 
global.player_party_dead = ds_list_create();
global.graveyard = ds_list_create(); 
_target_selected = undefined;

//blessings
global.player_blessings_list = ds_list_create();

//general stats
global.max_hand_size = 3; // Maximum of 3 cards in the hand
global.max_hand_size_saved = global.max_hand_size;
global.cur_hand_size = global.max_hand_size;

global.max_mana_saved = 3;
global.max_mana = 3;
global.cur_mana = 3;

global.gold = 0;
global.gold_randomizer = 0;

// CAMERA 
_flag_created_camera = false; 
global.camera = undefined;

_flag_transition_start = false; //HAVE I STARTED A TRANSITION


//encounter state enumerator
enum PLAYER_ENCOUNTER_STATE {
	INIT,
	BEGIN_TURN,
	MINIONS_CAST,
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