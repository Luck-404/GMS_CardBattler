//
//
// CREATE - OBJ_PLAYER
//
//

//VARIABLES
_flag_moving = false;
_player_speed = 3;

_player_bounce_counter = 0;
_player_bounce_frame = 0;

_step_particle_timer = 0;

global.beast_uid = 0;
global.player_party = ds_list_create();
global.player_ranch = ds_list_create();

global.card_uid = 0;
global.player_deck = ds_list_create();
global.player_card_collection = ds_list_create();

//INIT

randomize();
//ADD TEST UNITS TO PARTY
ds_list_add(global.player_party,scr_init_beast_random("ARBRAWN")); //START PLAYER WITH AN ARBRAWN WITH RANDOMIZED TYPE, ABILITY, BREED
ds_list_add(global.player_party,scr_init_beast_random("ARGENTBUD"));
ds_list_add(global.player_party,scr_init_beast_random("BEAVINE"));
ds_list_add(global.player_party,scr_init_beast_random("FLITSAGE"));
ds_list_add(global.player_party,scr_init_beast_random("FURN"));

//ADD TEST UNITS TO RANCH
ds_list_add(global.player_ranch,scr_init_beast_random("ARBRAWN"));
ds_list_add(global.player_ranch,scr_init_beast_random("ARGENTBUD"));
ds_list_add(global.player_ranch,scr_init_beast_random("BEAVINE"));
ds_list_add(global.player_ranch,scr_init_beast_random("FLITSAGE"));
ds_list_add(global.player_ranch,scr_init_beast_random("FURN"));

//ADD TEST CARDS TO DECK
ds_list_add(global.player_deck,scr_get_card_info("STRIKE"));
ds_list_add(global.player_deck,scr_get_card_info("POWER_STRIKE"));
ds_list_add(global.player_deck,scr_get_card_info("BLOCK"));
ds_list_add(global.player_deck,scr_get_card_info("BULWARK"));
ds_list_add(global.player_deck,scr_get_card_info("INSPIRATION"));
ds_list_add(global.player_deck,scr_get_card_info("ECHO"));
ds_list_add(global.player_deck,scr_get_card_info("DEFT_STRIKE"));
ds_list_add(global.player_deck,scr_get_card_info("RESPOSITION"));
ds_list_add(global.player_deck,scr_get_card_info("CLEARCAST"));
ds_list_add(global.player_deck,scr_get_card_info("RAPID_STRIKES"));

//ADD TEST CARDS TO COLLECTION
ds_list_add(global.player_card_collection,scr_get_card_info("STRIKE"));
ds_list_add(global.player_card_collection,scr_get_card_info("POWER_STRIKE"));
ds_list_add(global.player_card_collection,scr_get_card_info("BLOCK"));
ds_list_add(global.player_card_collection,scr_get_card_info("BULWARK"));
ds_list_add(global.player_card_collection,scr_get_card_info("INSPIRATION"));
ds_list_add(global.player_card_collection,scr_get_card_info("ECHO"));
ds_list_add(global.player_card_collection,scr_get_card_info("DEFT_STRIKE"));
ds_list_add(global.player_card_collection,scr_get_card_info("RESPOSITION"));
ds_list_add(global.player_card_collection,scr_get_card_info("CLEARCAST"));
ds_list_add(global.player_card_collection,scr_get_card_info("RAPID_STRIKES"));

//METHODS