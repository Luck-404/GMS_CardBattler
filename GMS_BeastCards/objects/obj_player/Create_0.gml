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
	global._val_bonus_speed_scalar = 1;
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
	
	global.ref_interacting_npc = undefined;	
	
	#region ITEM GLOBALS
	
	#region MARKET TRACKING
	global.map_market_stock = ds_map_create();

	global.ct_market_restock_battles = 0;
	global.ct_market_restock_battles_max = 3;

	global.arr_market_egg_beast_pool = [
		"ARBRAWN",
		"ARGENTBUD",
		"BEAVINE",
		"FLITSAGE",
		"FURN"
	];
	

	
	global.uid_next_item = 0;	
	global.list_player_inventory = ds_list_create();	
	global.list_pool_items = ds_list_create();
	global.ct_inventory_revision = 0;
	scr_init_item_pool();
	#endregion
	
	#region PLAYER TRACKING
	global.val_player_gold = 500;

	global.map_player_chests_opened = ds_map_create();
	#endregion

	#region LOGBOOK GLOBALS
	global.list_logbook_beasts = ds_list_create();
	global.map_logbook_beasts = ds_map_create();

	global.list_logbook_cards = ds_list_create();
	global.map_logbook_cards = ds_map_create();

	global.ct_logbook_revision = 0;
	#endregion

	#region TRANSITIONS
	global.val_last_player_x = 0;
	global.val_last_player_y = 0;
	global.rm_last_player = rm_ow_center;
	global.str_last_player_banner = "";
	global.arr_last_enemy_pool = "";
	global.stct_forced_enemy_unit = undefined;
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
	
	global.c_dk_gray = make_colour_rgb(50,50,50);
	global.flag_companion_summoned = true;	
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
	// SETUP LOGBOOK
	//—------------------------------------------------------------------------------//
	scr_init_logbook_beasts();
	scr_init_logbook_cards();		

	//—------------------------------------------------------------------------------//
	// SETUP TEST BEASTS AND CARDS
	//—------------------------------------------------------------------------------//
	#region TESTING
	//—------------------------------------------------------------------------------//
	// ADD TEST BEASTS TO PARTY
	//—------------------------------------------------------------------------------//
	//for (var _it_beast = 0; _it_beast < 5; _it_beast++){
	//	var _beast = choose("ARBRAWN","ARGENTBUD","BEAVINE","BRYOBITE","CHITROOPER","CRUSABER","DRYADAE","FIGHTREE","FLITSAGE","FURN","LEPOROOT","LUMBUCK","MAMBARK","MORELUSH","SPOROSE","STRIGIBLOOM","TURFRANTULA","AMMOMARSH","BLIZZDRIFT","CAUDAQUA","CEPHARIME","CHELONSEA","CORALLIARC","FROSTUSK","GALENATRIUM","GLACIMIGHT","GULFLOW","ISTIRAIN","KELPLATANI","LONTRIVER","MARITIMICE","SALTWAGG","SPHENISKIP","ASCHEMASS","CANIGNIS","DAIMONIS","DRAKOAL","EMBEROOST","HELLSHROOM","IMPARCH","INFERNUS","LAVAROWANA","PYREKNIGHT","PYROPLUME","SANGUINAUT","SLAGOLEM","SOLEMOLD","WRATHOOD","WYRMELTA")
	//	scr_add_beast_to_party(scr_init_beast_random(_beast));
	//}
	
	scr_add_beast_to_party(scr_init_beast_random("BEAVINE"));
	scr_add_beast_to_party(scr_init_beast_random("FLITSAGE"));
	scr_add_beast_to_party(scr_init_beast_random("FURN"));

	//—------------------------------------------------------------------------------//
	// ADD TEST BEASTS TO RANCH
	//—------------------------------------------------------------------------------//
	var _stct_test_ranch_arbrawn = scr_init_beast_random("ARBRAWN");
	ds_list_add(global.list_player_ranch,_stct_test_ranch_arbrawn);
	scr_logbook_mark_beast_captured(_stct_test_ranch_arbrawn._str_beast_name);

	//var _stct_test_ranch_argentbud = scr_init_beast_random("ARGENTBUD");
	//ds_list_add(global.list_player_ranch,_stct_test_ranch_argentbud);
	//scr_logbook_mark_beast_captured(_stct_test_ranch_argentbud._str_beast_name);

	//var _stct_test_ranch_beavine = scr_init_beast_random("BEAVINE");
	//ds_list_add(global.list_player_ranch,_stct_test_ranch_beavine);
	//scr_logbook_mark_beast_captured(_stct_test_ranch_beavine._str_beast_name);

	//—------------------------------------------------------------------------------//
	// ADD TEST CARDS TO DECK
	//—------------------------------------------------------------------------------//

	#region UNCOLORED

	scr_add_card_to_deck(scr_get_card_info("ARTIFACT_HOURGLASS"));
	scr_add_card_to_deck(scr_get_card_info("BLOCK"));
	scr_add_card_to_deck(scr_get_card_info("BULWARK"));
	scr_add_card_to_deck(scr_get_card_info("CLEARCAST"));
	scr_add_card_to_deck(scr_get_card_info("DEFT_STRIKE"));
	scr_add_card_to_deck(scr_get_card_info("ECHO"));
	scr_add_card_to_deck(scr_get_card_info("HIDDEN_CARD"));
	scr_add_card_to_deck(scr_get_card_info("INSPIRATION"));
	scr_add_card_to_deck(scr_get_card_info("MALLEABILITY"));
	scr_add_card_to_deck(scr_get_card_info("POWER_STRIKE"));
	scr_add_card_to_deck(scr_get_card_info("RAPID_STRIKES"));
	scr_add_card_to_deck(scr_get_card_info("REPOSITION"));
	scr_add_card_to_deck(scr_get_card_info("SHIV"));
	scr_add_card_to_deck(scr_get_card_info("SPELLBOOK_WILDCARD"));
	scr_add_card_to_deck(scr_get_card_info("STRIKE"));
	scr_add_card_to_deck(scr_get_card_info("THOUGHTSTEAL"));

	#endregion


	#region VIRIDIAN

	scr_add_card_to_deck(scr_get_card_info("BARKSKIN"));
	scr_add_card_to_deck(scr_get_card_info("BEASTIAL_WRATH"));
	scr_add_card_to_deck(scr_get_card_info("BIOBOLT"));
	scr_add_card_to_deck(scr_get_card_info("BIOSTORM"));
	scr_add_card_to_deck(scr_get_card_info("BLOOMING_SHIELD"));
	scr_add_card_to_deck(scr_get_card_info("BLOWDART"));
	scr_add_card_to_deck(scr_get_card_info("BRAMBLE_ERUPTION"));
	scr_add_card_to_deck(scr_get_card_info("CLAW"));
	scr_add_card_to_deck(scr_get_card_info("DISEASE"));
	scr_add_card_to_deck(scr_get_card_info("EMERALD_SLAM"));
	scr_add_card_to_deck(scr_get_card_info("EMERALD_WISDOM"));
	scr_add_card_to_deck(scr_get_card_info("FELL"));
	scr_add_card_to_deck(scr_get_card_info("FERAL_FRENZY"));
	scr_add_card_to_deck(scr_get_card_info("GREENFLOW"));
	scr_add_card_to_deck(scr_get_card_info("GROWTH_SIGIL"));
	scr_add_card_to_deck(scr_get_card_info("HUNTERS_INSTINCT"));
	scr_add_card_to_deck(scr_get_card_info("HUNTERS_JAVELIN"));
	scr_add_card_to_deck(scr_get_card_info("LIFE_SPIRIT"));
	scr_add_card_to_deck(scr_get_card_info("MIRACLE_MUSA"));
	scr_add_card_to_deck(scr_get_card_info("NATURES_FURY"));
	scr_add_card_to_deck(scr_get_card_info("NATURES_WRATH"));
	scr_add_card_to_deck(scr_get_card_info("OLD_GROWTH_PUMMEL"));
	scr_add_card_to_deck(scr_get_card_info("OVERGROWTH"));
	scr_add_card_to_deck(scr_get_card_info("POTENT_SPORE"));
	scr_add_card_to_deck(scr_get_card_info("PRIMAL_BLAST"));
	scr_add_card_to_deck(scr_get_card_info("RAKE"));
	scr_add_card_to_deck(scr_get_card_info("REGENERATE"));
	scr_add_card_to_deck(scr_get_card_info("ROT_BLOOM"));
	scr_add_card_to_deck(scr_get_card_info("SAVAGE_MAUL"));
	scr_add_card_to_deck(scr_get_card_info("SEED_BARRAGE"));
	scr_add_card_to_deck(scr_get_card_info("SNARLING_BITE"));
	scr_add_card_to_deck(scr_get_card_info("SPINESLING"));
	scr_add_card_to_deck(scr_get_card_info("SPIKE_PIERCE"));
	scr_add_card_to_deck(scr_get_card_info("SPIRIT_FANG"));
	scr_add_card_to_deck(scr_get_card_info("SPIRIT_PIERCE"));
	scr_add_card_to_deck(scr_get_card_info("SPIT_VENOM"));
	scr_add_card_to_deck(scr_get_card_info("SPORE_CLOUD"));
	scr_add_card_to_deck(scr_get_card_info("STALKING_SWIPE"));
	scr_add_card_to_deck(scr_get_card_info("STAMPEDE"));
	scr_add_card_to_deck(scr_get_card_info("SYMBIOSIS"));
	scr_add_card_to_deck(scr_get_card_info("THORN_STORM"));
	scr_add_card_to_deck(scr_get_card_info("TOXIC_ERUPTION"));
	scr_add_card_to_deck(scr_get_card_info("UNSEEN_ROOT"));
	scr_add_card_to_deck(scr_get_card_info("VERDANT_BOLT"));
	scr_add_card_to_deck(scr_get_card_info("VERDANT_SWIPES"));
	scr_add_card_to_deck(scr_get_card_info("VIRAL_SURGE"));
	scr_add_card_to_deck(scr_get_card_info("VIRIDIAN_BURST"));
	scr_add_card_to_deck(scr_get_card_info("WILDSTRIKE"));
	
	scr_add_card_to_deck(scr_get_card_info("INTERLOCKING_SCALES"));	

	#endregion

	
	//—------------------------------------------------------------------------------//
	// ADD TEST CARDS TO LIBRARY
	//—------------------------------------------------------------------------------//
	//ds_list_add(global.player_library,scr_get_card_info("STRIKE"));

	//—------------------------------------------------------------------------------//
	// ADD ITEMS TO INVENTORY
	//—------------------------------------------------------------------------------//
	//scr_add_item_to_inventory("QUEST_IMPORTANT_NOTEBOOK",1);
	//scr_add_item_to_inventory("CONSUMABLE_HEALING_SALVE",3);
	//scr_add_item_to_inventory("PRISM_COMMON",7);
	//scr_add_item_to_inventory("PRISM_ARCWORK",7);
	//scr_add_item_to_inventory("PRISM_RARE",7);
	//scr_add_item_to_inventory("HELD_VERDANT_SEED",1);
	//scr_add_item_to_inventory("HELD_POWERFUL_STONE",1);
	//scr_add_item_to_inventory("HELD_SORCEROUS_GEM",1);
	//scr_add_item_to_inventory("HELD_INSPIRING_CHIME",5);
	//scr_add_item_to_inventory("EGG_ARBRAWN",2);	
	scr_add_item_to_inventory("HELD_EMERALD_TALISMAN",2);	
	scr_add_item_to_inventory("HELD_BURNING_ASH",1);	
	scr_add_item_to_inventory("HELD_BOLSTERING_SHELL",1);	
	scr_add_item_to_inventory("HELD_HEALING_FRUIT",1);	
	scr_add_item_to_inventory("HELD_GOLD_FANG",1);	
	
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