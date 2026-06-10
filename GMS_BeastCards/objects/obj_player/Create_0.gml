//===============================================================================//
//
// CREATE: OBJ_PLAYER
// FUNCTION: Initializes player movement and camera settings.
//           Creates and initializes all persistent player data.
//           Sets up beast, card, ranch, minion, and tracking systems.
//           Loads test/debug data and prepares the game state.
//
//===============================================================================//

//---------//
//VARIABLES//
//—--------//
#region VARIABLES
	#region PLAYER VARIABLES
	_flag_player_moving  = false;
	_flag_player_sprinting = false;	
	_player_speed = 3;
	_player_bounce_counter = 0;
	_player_bounce_frame = 0;
	_player_step_particle_timer = 0;
	#endregion

	#region BEAST GLOBALS
	global.beast_uid = 0;
	global.player_party = ds_list_create();
	global.player_ranch = ds_list_create();
	#endregion

	#region CARD GLOBALS
	global.card_uid = 0;
	global.player_deck = ds_list_create();
	global.player_library = ds_list_create();

	global.rarity_I_cards = ds_list_create();
	global.rarity_II_cards = ds_list_create();
	global.rarity_III_cards = ds_list_create();
	global.rarity_IV_cards = ds_list_create();
	#endregion

	#region MINIONS
	global.viridian_minions = ds_list_create();
	#endregion

	#region PLAYER TRACKING
	global.player_gold = 0;
	global.player_chests_opened = ds_map_create();
	#endregion

	#region TRANSITIONS
	global.last_player_x = 0;
	global.last_player_y = 0;
	global.last_player_rm = rm_ow_center;
	global.last_player_banner = "";
	global.last_enemy_pool = "";
	#endregion

	#region CAMERA
	_flag_created_camera = false; 
	global.cam_min_size = 500;
	global.cam_max_size = 1056;

	global.cam_width = 500;
	global.cam_height = 500;

	global.cam_target_width = global.cam_width;
	global.cam_target_height = global.cam_height;
	global.camera = undefined;
	#endregion
#endregion

//----//
//INIT//
//----//
#region INIT
	randomize(); //RANDOMIZE THE GAME ON STARTUP

	//—------------------------------------------------------------------------------//
	// SETUP CARD POOLS
	//—------------------------------------------------------------------------------//
	scr_init_card_pools();

	//—------------------------------------------------------------------------------//
	// SETUP MINION POOLS
	//—------------------------------------------------------------------------------//
	scr_init_minion_pools();

	//—------------------------------------------------------------------------------//
	// SETUP TEST BEASTS AND CARDS
	//—------------------------------------------------------------------------------//
	#region TESTING
	//—------------------------------------------------------------------------------//
	// ADD TEST BEASTS TO PARTY
	//—------------------------------------------------------------------------------//
	scr_add_beast_to_party(scr_init_beast_random("ARBRAWN"));
	scr_add_beast_to_party(scr_init_beast_random("BEAVINE"));
	scr_add_beast_to_party(scr_init_beast_random("FLITSAGE"));
	scr_add_beast_to_party(scr_init_beast_random("ARGENTBUD"));
	scr_add_beast_to_party(scr_init_beast_random("FURN"));

	//—------------------------------------------------------------------------------//
	// ADD TEST BEASTS TO RANCH
	//—------------------------------------------------------------------------------//
	ds_list_add(global.player_ranch,scr_init_beast_random("ARBRAWN"));
	ds_list_add(global.player_ranch,scr_init_beast_random("ARGENTBUD"));
	ds_list_add(global.player_ranch,scr_init_beast_random("BEAVINE"));

	//—------------------------------------------------------------------------------//
	// ADD TEST CARDS TO DECK
	//—------------------------------------------------------------------------------//
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

	//—------------------------------------------------------------------------------//
	// ADD TEST CARDS TO LIBRARY
	//—------------------------------------------------------------------------------//
	ds_list_add(global.player_library,scr_get_card_info("STRIKE"));
	ds_list_add(global.player_library,scr_get_card_info("POWER_STRIKE"));
	ds_list_add(global.player_library,scr_get_card_info("BLOCK"));
	#endregion
#endregion

//-------//
//METHODS//
//-------//
#region METHODS
	#region HELPER SCRIPT: SPAWN STEP PARTICLES
	//—------------------------------------------------------------------------------//
	// SPAWN STEP PARTICLES | Spawns step particle objects as scene fx when player 
	//						  moves.
	//—------------------------------------------------------------------------------//
	function scr_helper_spawn_step_particles(){
		var _random_particles = irandom_range(1,3);
		if (_flag_player_sprinting){
			_random_particles = _random_particles*3;
		}
		//SPAWN THE PARTICLES
		for (var _i = 0; _i < _random_particles; _i++){
			var _particle = instance_create_layer(obj_player.x,obj_player.y,"ily_fx",obj_scene_fx_step_particle);	
		}	
	}
	#endregion
#endregion