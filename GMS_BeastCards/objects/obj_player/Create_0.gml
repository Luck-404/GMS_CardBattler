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
	
	//green testing
	//scr_add_beast_to_party(scr_init_beast_random("BEAVINE"));
	//scr_add_beast_to_party(scr_init_beast_random("FLITSAGE"));
	//scr_add_beast_to_party(scr_init_beast_random("FURN"));
	//scr_add_beast_to_party(scr_init_beast_random("TURFRANTULA"));
	
	//BLUE testing
	scr_add_beast_to_party(scr_init_beast_random("SALTWAGG"));
	scr_add_beast_to_party(scr_init_beast_random("FROSTUSK"));
	scr_add_beast_to_party(scr_init_beast_random("GULFLOW"));
	scr_add_beast_to_party(scr_init_beast_random("CHELONSEA"));	
	

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

	//scr_add_card_to_deck(scr_get_card_info("ARTIFACT_HOURGLASS"));
	//scr_add_card_to_deck(scr_get_card_info("BLOCK"));
	//scr_add_card_to_deck(scr_get_card_info("BULWARK"));
	//scr_add_card_to_deck(scr_get_card_info("CLEARCAST"));
	//scr_add_card_to_deck(scr_get_card_info("DEFT_STRIKE"));
	//scr_add_card_to_deck(scr_get_card_info("ECHO"));
	//scr_add_card_to_deck(scr_get_card_info("HIDDEN_CARD"));
	//scr_add_card_to_deck(scr_get_card_info("INSPIRATION"));
	//scr_add_card_to_deck(scr_get_card_info("MALLEABILITY"));
	//scr_add_card_to_deck(scr_get_card_info("POWER_STRIKE"));
	//scr_add_card_to_deck(scr_get_card_info("RAPID_STRIKES"));
	//scr_add_card_to_deck(scr_get_card_info("REPOSITION"));
	//scr_add_card_to_deck(scr_get_card_info("SHIV"));
	//scr_add_card_to_deck(scr_get_card_info("SOULCLEANSE"));
	//scr_add_card_to_deck(scr_get_card_info("SPELLBOOK_WILDCARD"));
	//scr_add_card_to_deck(scr_get_card_info("STRIKE"));
	//scr_add_card_to_deck(scr_get_card_info("THOUGHTSTEAL"));

	#endregion


	#region VIRIDIAN

	//---------------//
	//ATTACK: DIRECT//
	//---------------//

	//scr_add_card_to_deck(scr_get_card_info("BIOBOLT"));
	//scr_add_card_to_deck(scr_get_card_info("BIOSTORM"));
	//scr_add_card_to_deck(scr_get_card_info("BRAMBLE_ERUPTION"));
	//scr_add_card_to_deck(scr_get_card_info("CLAW"));
	//scr_add_card_to_deck(scr_get_card_info("FELL"));
	//scr_add_card_to_deck(scr_get_card_info("FERAL_FRENZY"));
	//scr_add_card_to_deck(scr_get_card_info("HUNTERS_JAVELIN"));
	//scr_add_card_to_deck(scr_get_card_info("NATURES_FURY"));
	//scr_add_card_to_deck(scr_get_card_info("PRIMAL_BLAST"));
	//scr_add_card_to_deck(scr_get_card_info("SAVAGE_MAUL"));
	//scr_add_card_to_deck(scr_get_card_info("SPIKE_PIERCE"));
	//scr_add_card_to_deck(scr_get_card_info("SPINESLING"));
	//scr_add_card_to_deck(scr_get_card_info("SPIRIT_PIERCE"));
	//scr_add_card_to_deck(scr_get_card_info("SPORE_CLOUD"));
	//scr_add_card_to_deck(scr_get_card_info("STALKING_SWIPE"));
	//scr_add_card_to_deck(scr_get_card_info("STAMPEDE"));
	//scr_add_card_to_deck(scr_get_card_info("UNSEEN_ROOT"));
	//scr_add_card_to_deck(scr_get_card_info("VERDANT_SWIPES"));
	//scr_add_card_to_deck(scr_get_card_info("WILDSTRIKE"));


	//-------------------------//
	//ATTACK: DIRECT SPECIALTY//
	//-------------------------//
	//scr_add_card_to_deck(scr_get_card_info("BEASTIAL_WRATH"));
	//scr_add_card_to_deck(scr_get_card_info("GREENFLOW"));
	//scr_add_card_to_deck(scr_get_card_info("HUNTERS_INSTINCT"));
	//scr_add_card_to_deck(scr_get_card_info("NATURES_WRATH"));
	//scr_add_card_to_deck(scr_get_card_info("OLD_GROWTH_PUMMEL"));
	//scr_add_card_to_deck(scr_get_card_info("ROT_BLOOM"));
	//scr_add_card_to_deck(scr_get_card_info("SEED_BARRAGE"));
	//scr_add_card_to_deck(scr_get_card_info("SNARLING_BITE"));
	//scr_add_card_to_deck(scr_get_card_info("THORN_STORM"));
	//scr_add_card_to_deck(scr_get_card_info("TOXIC_ERUPTION"));
	//scr_add_card_to_deck(scr_get_card_info("VERDANT_BOLT"));
	//scr_add_card_to_deck(scr_get_card_info("VIRIDIAN_BURST"));


	//------------//
	//ATTACK: DOT//
	//------------//
	//scr_add_card_to_deck(scr_get_card_info("BLOWDART"));
	//scr_add_card_to_deck(scr_get_card_info("POTENT_SPORE"));
	//scr_add_card_to_deck(scr_get_card_info("RAKE"));
	//scr_add_card_to_deck(scr_get_card_info("SPIRIT_FANG"));
	//scr_add_card_to_deck(scr_get_card_info("SPIT_VENOM"));
	//scr_add_card_to_deck(scr_get_card_info("VIRAL_SURGE"));


	//-------//
	//DEFENSE//
	//-------//
	//scr_add_card_to_deck(scr_get_card_info("BARKSKIN"));
	//scr_add_card_to_deck(scr_get_card_info("BLOOMING_SHIELD"));
	//scr_add_card_to_deck(scr_get_card_info("INTERLOCKING_SCALES"));
	//scr_add_card_to_deck(scr_get_card_info("NATURAL_RECOVERY"));
	//scr_add_card_to_deck(scr_get_card_info("NATURES_GRACE"));
	//scr_add_card_to_deck(scr_get_card_info("OVERGROWTH"));
	//scr_add_card_to_deck(scr_get_card_info("REGENERATE"));
	//scr_add_card_to_deck(scr_get_card_info("ROOTED_DEFENSE"));
	//scr_add_card_to_deck(scr_get_card_info("SECOND_BLOOM"));
	//scr_add_card_to_deck(scr_get_card_info("SINEWY_VINES"));
	//scr_add_card_to_deck(scr_get_card_info("STEELFUR"));
	//scr_add_card_to_deck(scr_get_card_info("SYMBIOSIS"));
	//scr_add_card_to_deck(scr_get_card_info("THICK_HIDE"));
	//scr_add_card_to_deck(scr_get_card_info("THORNMAIL"));
	//scr_add_card_to_deck(scr_get_card_info("WILDWARD"));


	//-------//
	//UTILITY//
	//-------//
	//scr_add_card_to_deck(scr_get_card_info("BLOOMING_SPRITE"));
	//scr_add_card_to_deck(scr_get_card_info("BLOOMTIDE"));
	//scr_add_card_to_deck(scr_get_card_info("DISTRACTING_TRAP"));
	//scr_add_card_to_deck(scr_get_card_info("DORMANT_SEED"));
	//scr_add_card_to_deck(scr_get_card_info("EMERALD_WISDOM"));
	//scr_add_card_to_deck(scr_get_card_info("FUNGAL_RECYCLING"));
	//scr_add_card_to_deck(scr_get_card_info("GERMINATE"));
	//scr_add_card_to_deck(scr_get_card_info("GREENSTEP"));
	//scr_add_card_to_deck(scr_get_card_info("GROWTH_SIGIL"));
	//scr_add_card_to_deck(scr_get_card_info("LIFE_SPIRIT"));
	//scr_add_card_to_deck(scr_get_card_info("MANAVINE"));
	//scr_add_card_to_deck(scr_get_card_info("NATURAL_CYCLE"));
	//scr_add_card_to_deck(scr_get_card_info("PHEROMONES"));
	//scr_add_card_to_deck(scr_get_card_info("RETURN_TO_NATURE"));
	//scr_add_card_to_deck(scr_get_card_info("ROTTING_SPORES"));
	//scr_add_card_to_deck(scr_get_card_info("SEED_THE_FIELD"));
	//scr_add_card_to_deck(scr_get_card_info("SERPENT_SUMMON"));
	//scr_add_card_to_deck(scr_get_card_info("THORN_NET"));
	//scr_add_card_to_deck(scr_get_card_info("TOXIC_SNARE"));
	//scr_add_card_to_deck(scr_get_card_info("TRANQUILITY"));
	//scr_add_card_to_deck(scr_get_card_info("VENOM_BLOOM"));


	//-------//
	//SUPPORT//
	//-------//
	//scr_add_card_to_deck(scr_get_card_info("BRAMBLE_HIDE"));
	//scr_add_card_to_deck(scr_get_card_info("BURGEONING_BLOOM"));
	//scr_add_card_to_deck(scr_get_card_info("BURSTING_SEED"));
	//scr_add_card_to_deck(scr_get_card_info("CRIPPLING_VINES"));
	//scr_add_card_to_deck(scr_get_card_info("CULTIVATE"));
	//scr_add_card_to_deck(scr_get_card_info("CURE_ALL"));
	//scr_add_card_to_deck(scr_get_card_info("DECAYING_TOUCH"));
	//scr_add_card_to_deck(scr_get_card_info("DISEASE"));
	//scr_add_card_to_deck(scr_get_card_info("DRAINING_KISS"));
	//scr_add_card_to_deck(scr_get_card_info("EMERALD_SLAM"));
	//scr_add_card_to_deck(scr_get_card_info("ENTANGLE"));
	//scr_add_card_to_deck(scr_get_card_info("HONEYED_SCENT"));
	//scr_add_card_to_deck(scr_get_card_info("LIFEBLOOM"));
	//scr_add_card_to_deck(scr_get_card_info("MIRACLE_MUSA"));
	//scr_add_card_to_deck(scr_get_card_info("NATURES_BOND"));
	//scr_add_card_to_deck(scr_get_card_info("NATURES_MEND"));
	//scr_add_card_to_deck(scr_get_card_info("PACK_INSTINCT"));
	//scr_add_card_to_deck(scr_get_card_info("POLLINATE"));
	//scr_add_card_to_deck(scr_get_card_info("POTENT_FRUIT"));
	//scr_add_card_to_deck(scr_get_card_info("PREDATORS_MARK"));
	//scr_add_card_to_deck(scr_get_card_info("PREDATORY_SCENT"));
	//scr_add_card_to_deck(scr_get_card_info("REJUVENATE"));
	//scr_add_card_to_deck(scr_get_card_info("SAPSPRING"));
	//scr_add_card_to_deck(scr_get_card_info("SHIMMERING_SPORES"));
	//scr_add_card_to_deck(scr_get_card_info("SLEEP_DART"));
	//scr_add_card_to_deck(scr_get_card_info("SLEEPING_POLLEN"));
	//scr_add_card_to_deck(scr_get_card_info("TOXIC_HIDE"));
	//scr_add_card_to_deck(scr_get_card_info("VERDANT_EMBRACE"));
	//scr_add_card_to_deck(scr_get_card_info("VERDANT_INSIGHT"));
	//scr_add_card_to_deck(scr_get_card_info("WILD_VIGOR"));
	//scr_add_card_to_deck(scr_get_card_info("WILT"));


	//---------//
	//ARCHETYPE//
	//---------//
	//scr_add_card_to_deck(scr_get_card_info("ANCIENT_GROVE"));
	//scr_add_card_to_deck(scr_get_card_info("APEX_PREDATOR"));
	//scr_add_card_to_deck(scr_get_card_info("CHANNEL_THE_SPIRITS"));
	//scr_add_card_to_deck(scr_get_card_info("CIRCLE_OF_LIFE"));
	//scr_add_card_to_deck(scr_get_card_info("ENDLESS_BLOOM"));
	//scr_add_card_to_deck(scr_get_card_info("FOR_THE_THROAT"));
	//scr_add_card_to_deck(scr_get_card_info("HEART_OF_THE_FOREST"));
	//scr_add_card_to_deck(scr_get_card_info("PLAGUE_GARDEN"));
	//scr_add_card_to_deck(scr_get_card_info("PROLIFERATE"));

	#endregion

	#region CERULEAN
	//ATTACK - DIRECT & ATTACK - DOT
		//scr_add_card_to_deck(scr_get_card_info("HAILSTONES"));
		//scr_add_card_to_deck(scr_get_card_info("AVALANCHE_STRIKE"));
		//scr_add_card_to_deck(scr_get_card_info("ICE_LANCE"));
		//scr_add_card_to_deck(scr_get_card_info("TORRENT"));
		//scr_add_card_to_deck(scr_get_card_info("BURST"));
		//scr_add_card_to_deck(scr_get_card_info("TIDAL_SLASH"));
		//scr_add_card_to_deck(scr_get_card_info("GLACIAL_CRUSH"));
		//scr_add_card_to_deck(scr_get_card_info("RAZOR_FIN"));
		//scr_add_card_to_deck(scr_get_card_info("ABYSSAL_TOUCH"));
		//scr_add_card_to_deck(scr_get_card_info("DEEP_CURRENT"));
		//scr_add_card_to_deck(scr_get_card_info("FROZEN_FANG"));
		//scr_add_card_to_deck(scr_get_card_info("FROSTBOLT"));
		//scr_add_card_to_deck(scr_get_card_info("CHILLING_WORD"));
		//scr_add_card_to_deck(scr_get_card_info("FROZEN_SPEAR"));
		//scr_add_card_to_deck(scr_get_card_info("ARCTIC_VOLLEY"));
		//scr_add_card_to_deck(scr_get_card_info("CRASHING_WAVE"));
		//scr_add_card_to_deck(scr_get_card_info("WHITEWATER"));
		
	//ATTACK - DIRECT (SPECIALITY)
		//scr_add_card_to_deck(scr_get_card_info("SHATTER_STRIKE"));
		//scr_add_card_to_deck(scr_get_card_info("PRESSURE_SPIKE"));
		//scr_add_card_to_deck(scr_get_card_info("COLD_SNAP"));
		//scr_add_card_to_deck(scr_get_card_info("TIDAL_BREAK"));
		//scr_add_card_to_deck(scr_get_card_info("DEPTH_CHARGE"));
		//scr_add_card_to_deck(scr_get_card_info("WINTERS_BITE"));
		//scr_add_card_to_deck(scr_get_card_info("WINTER_RESONANCE"));
		//scr_add_card_to_deck(scr_get_card_info("ABSOLUTE_ZERO"));
		//scr_add_card_to_deck(scr_get_card_info("BITTER_CHILL"));
		//scr_add_card_to_deck(scr_get_card_info("PRESSURE_CRUSH"));
		//scr_add_card_to_deck(scr_get_card_info("KRAKENSLAM"));
		//scr_add_card_to_deck(scr_get_card_info("FROSTBURN_NOVA"));
		//scr_add_card_to_deck(scr_get_card_info("GLACIAL_ERUPTION"));
		//scr_add_card_to_deck(scr_get_card_info("FRACTURE"));
			
		//DEFENSE
		//scr_add_card_to_deck(scr_get_card_info("SHELL_SHIELD"));
		//scr_add_card_to_deck(scr_get_card_info("ICE_PLATING"));
		//scr_add_card_to_deck(scr_get_card_info("FROZEN_BULWARK"));
		//scr_add_card_to_deck(scr_get_card_info("SNOWFORT"));
		//scr_add_card_to_deck(scr_get_card_info("SNOWDRIFT"));
		scr_add_card_to_deck(scr_get_card_info("ICE_ACCRETION"));
		scr_add_card_to_deck(scr_get_card_info("FROZEN_BASTION"));
		scr_add_card_to_deck(scr_get_card_info("BUBBLE"));
		scr_add_card_to_deck(scr_get_card_info("CRYSTAL_SHELL"));
		scr_add_card_to_deck(scr_get_card_info("FROZEN_ARMOR"));
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