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
	_flag_player_moving = false;
	_flag_player_sprinting = false;	
	_val_player_speed = 3;
	_ct_player_bounce = 0;
	_val_player_bounce_frame = 0;
	_ct_player_step_particle_timer = 0;
	#endregion

	#region BEAST GLOBALS
	global.uid_next_beast = 0;
	global.list_player_party = ds_list_create();
	global.list_player_ranch = ds_list_create();
	#endregion

	#region CARD GLOBALS
	global.uid_next_card = 0;
	global.list_player_deck = ds_list_create();
	global.list_player_library = ds_list_create();

	global.list_pool_cards_rarity_I = ds_list_create();
	global.list_pool_cards_rarity_II = ds_list_create();
	global.list_pool_cards_rarity_III = ds_list_create();
	global.list_pool_cards_rarity_IV = ds_list_create();
	#endregion

	#region MINIONS
	global.list_pool_viridian_minions = ds_list_create();
	#endregion

	#region ITEM GLOBALS
	global.uid_next_item = 0;	
	global.list_player_inventory = ds_list_create();	
	global.list_pool_items = ds_list_create();
	scr_init_item_pool();
	#endregion
	
	#region PLAYER TRACKING
	global.val_player_gold = 0;

	global.map_player_chests_opened = ds_map_create();
	#endregion

	#region TRANSITIONS
	global.val_last_player_x = 0;
	global.val_last_player_y = 0;
	global.ref_last_player_room = rm_ow_center;
	global.str_last_player_banner = "";
	global.arr_last_enemy_pool = "";
	#endregion

	#region CAMERA
	_flag_created_camera = false; 
	global.val_cam_min_size = 500;
	global.val_cam_max_size = 1056;

	global.val_cam_width = 500;
	global.val_cam_height = 500;

	global.val_cam_target_width = global.val_cam_width;
	global.val_cam_target_height = global.val_cam_height;
	global.ref_camera = undefined;
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
	ds_list_add(global.list_player_ranch,scr_init_beast_random("ARBRAWN"));
	ds_list_add(global.list_player_ranch,scr_init_beast_random("ARGENTBUD"));
	ds_list_add(global.list_player_ranch,scr_init_beast_random("BEAVINE"));

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
	repeat (70)
	{	
		scr_add_card_to_deck(scr_get_card_info("POWER_STRIKE"));
	}

	//—------------------------------------------------------------------------------//
	// ADD TEST CARDS TO LIBRARY
	//—------------------------------------------------------------------------------//
	//ds_list_add(global.player_library,scr_get_card_info("STRIKE"));
	//ds_list_add(global.player_library,scr_get_card_info("POWER_STRIKE"));
	//ds_list_add(global.player_library,scr_get_card_info("BLOCK"));
	
	//—------------------------------------------------------------------------------//
	// ADD ITEMS TO INVENTORY
	//—------------------------------------------------------------------------------//
	scr_add_item_to_inventory("QUEST_IMPORTANT_NOTEBOOK",1);
	//scr_add_item_to_inventory("CONSUMABLE_HEALING_SALVE",22);
	//scr_add_item_to_inventory("PRISM_BASIC_PRISM",7);
	//scr_add_item_to_inventory("HELD_POWERFUL_STONE",1);
	//scr_add_item_to_inventory("EGG_ARBRAWN",45);	
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
	function hscr_spawn_step_particles(){
		var _ct_random_particles = irandom_range(1,3);
		if (_flag_player_sprinting){
			_ct_random_particles *= 3;
		}
		//SPAWN THE PARTICLES
		for (var _it_particle = 0; _it_particle < _ct_random_particles; _it_particle++){
			var _ref_particle = instance_create_layer(obj_player.x,obj_player.y,"ily_fx",obj_scene_fx_step_particle);	
		}	
	}
	#endregion
#endregion