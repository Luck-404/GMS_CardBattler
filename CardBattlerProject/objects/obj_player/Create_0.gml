//////////////////////////////////////////////////////////////////////
//							OBJ_PLAYER								//
//																	//
// > THE MAIN PLAYER UNIT, MOST USER-GAME INTERACTIONS ARE RAN		//
//	 THROUGH THIS OBJECT											//
//////////////////////////////////////////////////////////////////////
randomize();

//location and movement
global.player_xpos = 0;
global.player_ypos = 0;
global.saved_room = room;
_move_speed = 0;
_target_x = x; // Current position
_target_y = y;
_flag_moving = false; // Movement status
_hop_start = false;
_hop_offset = 0;
_hop_dx = 0;
_hop_dy = 0;

//deck stuff
_flag_deck_created = false;
global.card_inventory = ds_list_create(); //create inventory

//creature stuff
_flag_party_spawned = false;
global.player_team = ds_list_create(); 
global.player_team_in_play = ds_list_create(); 
global.player_team_dead = ds_list_create();
global.graveyard = ds_list_create(); 

//gear and blessings
global.blessings_list = ds_list_create();

//general stats
global.hand_size = 3; // Maximum of 3 cards in the hand
global.max_mana_saved = 3;
global.max_mana = 3;
global.current_mana = 3;
global.gold = 0;
global.randgold = 0;

//other
global.trigger_loss = false;

_flag_created_camera = false; // CAMERA 

instance_create_layer(x,y,"GUI",obj_encounter_trigger); // ENCOUNTER TRIGGER

_flag_can_touch = true;

_flag_transition_start = false;
global._camera = undefined;