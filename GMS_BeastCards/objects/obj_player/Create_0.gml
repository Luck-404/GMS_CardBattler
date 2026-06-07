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
_flag_sprinting = false;
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

global.viridian_minions = ds_list_create();


global.player_gold = 0;

global.chests_opened = ds_map_create();

global.last_player_x = 0;
global.last_player_y = 0;
global.last_player_rm = rm_ow_center;
global.last_player_banner = "";
global.last_enemy_pool = "";

// CAMERA 
_flag_created_camera = false; 
global._cam_min_size = 500;
global._cam_max_size = 1056;

global._cam_width = 500;
global._cam_height = 500;

global._cam_target_width = global._cam_width;
global._cam_target_height = global._cam_height;
global.camera = undefined;
#endregion

//
//INIT
//
#region INIT
randomize();

//SETUP CARD POOLS
scr_init_card_pools();

//SETUP MINION POOLS
scr_init_minion_pools();

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

//ADD TEST CARDS TO DECK
//scr_add_card_to_deck(scr_get_card_info("STRIKE"));
//scr_add_card_to_deck(scr_get_card_info("POWER_STRIKE"));
//scr_add_card_to_deck(scr_get_card_info("BLOCK"));
//scr_add_card_to_deck(scr_get_card_info("BULWARK"));
//scr_add_card_to_deck(scr_get_card_info("INSPIRATION"));
//scr_add_card_to_deck(scr_get_card_info("ECHO"));
//scr_add_card_to_deck(scr_get_card_info("DEFT_STRIKE"));
//scr_add_card_to_deck(scr_get_card_info("RESPOSITION"));
//scr_add_card_to_deck(scr_get_card_info("CLEARCAST"));
//scr_add_card_to_deck(scr_get_card_info("RAPID_STRIKES"));
//scr_add_card_to_deck(scr_get_card_info("LIFE_SPIRIT"));
//scr_add_card_to_deck(scr_get_card_info("MIRACLE_MUSA"));
//scr_add_card_to_deck(scr_get_card_info("INSPIRATION"));
//scr_add_card_to_deck(scr_get_card_info("DISEASE"));
//scr_add_card_to_deck(scr_get_card_info("EMERALD_SLAM"));
//scr_add_card_to_deck(scr_get_card_info("GROWTH_SIGIL"));
//scr_add_card_to_deck(scr_get_card_info("HIDDEN_CARD"));
//scr_add_card_to_deck(scr_get_card_info("EMERALD_WISDOM"));
scr_add_card_to_deck(scr_get_card_info("POWER_STRIKE"));
scr_add_card_to_deck(scr_get_card_info("POWER_STRIKE"));
scr_add_card_to_deck(scr_get_card_info("POWER_STRIKE"));
scr_add_card_to_deck(scr_get_card_info("POWER_STRIKE"));
scr_add_card_to_deck(scr_get_card_info("POWER_STRIKE"));
scr_add_card_to_deck(scr_get_card_info("POWER_STRIKE"));
scr_add_card_to_deck(scr_get_card_info("POWER_STRIKE"));
scr_add_card_to_deck(scr_get_card_info("POWER_STRIKE"));
scr_add_card_to_deck(scr_get_card_info("POWER_STRIKE"));
scr_add_card_to_deck(scr_get_card_info("POWER_STRIKE"));

//ADD TEST CARDS TO COLLECTION
ds_list_add(global.player_card_collection,scr_get_card_info("STRIKE"));
ds_list_add(global.player_card_collection,scr_get_card_info("POWER_STRIKE"));
ds_list_add(global.player_card_collection,scr_get_card_info("BLOCK"));

#endregion

//
//METHODS
//