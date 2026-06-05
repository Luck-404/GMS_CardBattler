//
//
// CREATE - OBJ_PLAYER
//
//

//
//VARIABLES
//
#region VARIABLES
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

global.rarity_I_cards = ds_list_create();
global.rarity_II_cards = ds_list_create();
global.rarity_III_cards = ds_list_create();
global.rarity_IV_cards = ds_list_create();

global.player_gold = 0;

global.chests_opened = ds_map_create();

global.last_player_x = 0;
global.last_player_y = 0;
global.last_player_rm = rm_ow_center;
global.last_player_banner = "";
global.last_enemy_pool = "";
#endregion

//
//INIT
//
#region INIT
randomize();

//SETUP CARD POOLS
scr_init_card_pools();

//ADD TEST UNITS TO PARTY
scr_add_beast_to_party(scr_init_beast_random("ARBRAWN"));
scr_add_beast_to_party(scr_init_beast_random("BEAVINE"));
scr_add_beast_to_party(scr_init_beast_random("FLITSAGE"));
scr_add_beast_to_party(scr_init_beast_random("ARGENTBUD"));
scr_add_beast_to_party(scr_init_beast_random("FURN"));

//ADD TEST UNITS TO RANCH
ds_list_add(global.player_ranch,scr_init_beast_random("ARBRAWN"));
ds_list_add(global.player_ranch,scr_init_beast_random("ARGENTBUD"));
ds_list_add(global.player_ranch,scr_init_beast_random("BEAVINE"));
ds_list_add(global.player_ranch,scr_init_beast_random("FLITSAGE"));
ds_list_add(global.player_ranch,scr_init_beast_random("FURN"));

//ADD TEST CARDS TO DECK
scr_add_card_to_deck(scr_get_card_info("STRIKE"));
scr_add_card_to_deck(scr_get_card_info("POWER_STRIKE"));
scr_add_card_to_deck(scr_get_card_info("BLOCK"));
scr_add_card_to_deck(scr_get_card_info("BULWARK"));
scr_add_card_to_deck(scr_get_card_info("INSPIRATION"));
scr_add_card_to_deck(scr_get_card_info("ECHO"));
scr_add_card_to_deck(scr_get_card_info("DEFT_STRIKE"));
scr_add_card_to_deck(scr_get_card_info("RESPOSITION"));
scr_add_card_to_deck(scr_get_card_info("CLEARCAST"));
scr_add_card_to_deck(scr_get_card_info("RAPID_STRIKES"));

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
#endregion

//
//METHODS
//