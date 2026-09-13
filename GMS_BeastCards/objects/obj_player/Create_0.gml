//===============================================================================//
//
// CREATE: OBJ_PLAYER
// FUNCTION: Initializes player movement and camera settings.
//           Creates persistent player data and runtime pools.
//           Initializes Beast, Card, Inventory, Logbook, Market, and test data.
//
//===============================================================================//

//================//
//DEBUG STARTUP//
//================//
show_debug_message("\n\n");
scr_debug_log(
	"PLAYER",
	"INIT",
	self,
	"PLAYER SESSION INITIALIZATION STARTED",
	"INIT",
	"OBJ_PLAYER:CREATE"
);

//================//
//VARIABLES//
//================//
#region VARIABLES

	//----------------//
	//PLAYER VARIABLES//
	//----------------//
	#region PLAYER VARIABLES

	global.val_bonus_speed_scalar = 1;

	_flag_player_moving = false;
	_flag_player_sprinting = false;

	_val_player_speed = 3 * global.val_bonus_speed_scalar;

	_ct_player_bounce_timer = 0;
	_val_player_bounce_offset = 0;

	_ct_player_step_particle_timer = 0;

	global.flag_companion_summoned = true;

	#endregion

	//----------------//
	//BEAST GLOBALS//
	//----------------//
	#region BEAST GLOBALS

	global.uid_next_beast = 0;

	global.list_player_party = ds_list_create();
	global.list_player_ranch = ds_list_create();

	#endregion

	//----------------//
	//CARD GLOBALS//
	//----------------//
	#region CARD GLOBALS

	global.uid_next_card = 0;

	global.list_player_deck = ds_list_create();
	global.list_player_library = ds_list_create();

	global.list_pool_cards_rarity_I = ds_list_create();
	global.list_pool_cards_rarity_II = ds_list_create();
	global.list_pool_cards_rarity_III = ds_list_create();
	global.list_pool_cards_rarity_IV = ds_list_create();

	#endregion

	//----------------//
	//MINION GLOBALS//
	//----------------//
	#region MINION GLOBALS

	global.list_pool_viridian_minions = ds_list_create();
	global.list_pool_cerulean_minions = ds_list_create();
	global.list_pool_vermilion_minions = ds_list_create();

	#endregion

	//----------------//
	//NPC GLOBALS//
	//----------------//
	#region NPC GLOBALS

	global.ref_interacting_npc = undefined;

	#endregion

	//----------------//
	//ITEM GLOBALS//
	//----------------//
	#region ITEM GLOBALS

	global.uid_next_item = 0;

	global.list_player_inventory = ds_list_create();
	global.list_pool_items = ds_list_create();

	global.ct_inventory_revision = 0;

	#endregion

	//----------------//
	//MARKET GLOBALS//
	//----------------//
	#region MARKET GLOBALS

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

	#endregion

	//----------------//
	//PLAYER TRACKING//
	//----------------//
	#region PLAYER TRACKING

	global.val_player_gold = 500;

	global.map_player_chests_opened = ds_map_create();

	#endregion

	//----------------//
	//LOGBOOK GLOBALS//
	//----------------//
	#region LOGBOOK GLOBALS

	global.list_logbook_beasts = ds_list_create();
	global.map_logbook_beasts = ds_map_create();

	global.list_logbook_cards = ds_list_create();
	global.map_logbook_cards = ds_map_create();

	global.ct_logbook_revision = 0;

	#endregion

	//----------------//
	//TRANSITIONS//
	//----------------//
	#region TRANSITIONS

	global.val_last_player_x = 0;
	global.val_last_player_y = 0;

	global.rm_last_player = rm_ow_center;

	global.str_last_player_banner = "";

	global.arr_last_enemy_pool = [];
	global.stct_forced_enemy_unit = undefined;

	#endregion

	//----------------//
	//CAMERA//
	//----------------//
	#region CAMERA

	_flag_camera_created = false;

	global.val_cam_min_size = 500;
	global.val_cam_max_size = 1056;

	global.val_cam_width = 500;
	global.val_cam_height = 500;

	global.val_cam_target_width = global.val_cam_width;
	global.val_cam_target_height = global.val_cam_height;

	global.ref_camera = undefined;

	#endregion

	//----------------//
	//GLOBAL COLORS//
	//----------------//
	global.c_dk_gray = make_colour_rgb(50,50,50);

#endregion

//----------------------//
//DEBUG GLOBAL CREATION//
//----------------------//
scr_debug_log(
	"PLAYER",
	"INIT",
	self,
	"PERSISTENT RUNTIME DATA CREATED",
	"INIT",
	"OBJ_PLAYER:CREATE"
);

//================//
//INIT//
//================//
#region INIT

//----------------//
//RANDOMIZE GAME//
//----------------//
randomize();

scr_debug_log(
	"CORE",
	"INIT",
	self,
	"RANDOM GENERATOR INITIALIZED",
	"INIT",
	"OBJ_PLAYER:CREATE"
);

//----------------//
//INITIALIZE CARDS//
//----------------//
scr_card_init_pools();

scr_debug_log(
	"CARDS",
	"INIT",
	self,
	"CARD POOLS INITIALIZED | I: " + string(ds_list_size(global.list_pool_cards_rarity_I)) +
	" | II: " + string(ds_list_size(global.list_pool_cards_rarity_II)) +
	" | III: " + string(ds_list_size(global.list_pool_cards_rarity_III)) +
	" | IV: " + string(ds_list_size(global.list_pool_cards_rarity_IV)),
	"INIT",
	"OBJ_PLAYER:CREATE"
);

//------------------//
//INITIALIZE MINIONS//
//------------------//
scr_minion_init_pools();

scr_debug_log(
	"MINIONS",
	"INIT",
	self,
	"MINION POOLS INITIALIZED | VIRIDIAN: " + string(ds_list_size(global.list_pool_viridian_minions)) +
	" | CERULEAN: " + string(ds_list_size(global.list_pool_cerulean_minions)) +
	" | VERMILION: " + string(ds_list_size(global.list_pool_vermilion_minions)),
	"INIT",
	"OBJ_PLAYER:CREATE"
);

//--------------------//
//INITIALIZE INVENTORY//
//--------------------//
scr_inventory_init_item_pool();

scr_debug_log(
	"INVENTORY",
	"INIT",
	self,
	"ITEM POOL INITIALIZED | ITEMS: " + string(ds_list_size(global.list_pool_items)),
	"INIT",
	"OBJ_PLAYER:CREATE"
);

//------------------//
//INITIALIZE LOGBOOK//
//------------------//
scr_logbook_init_beasts();
scr_logbook_init_cards();

scr_debug_log(
	"LOGBOOK",
	"INIT",
	self,
	"LOGBOOK INITIALIZED | BEASTS: " + string(ds_list_size(global.list_logbook_beasts)) +
	" | CARDS: " + string(ds_list_size(global.list_logbook_cards)),
	"INIT",
	"OBJ_PLAYER:CREATE"
);

//================//
//TESTING//
//================//
#region TESTING

//----------------//
//TEST PARTY//
//----------------//
//scr_party_add_beast(scr_beast_init_random("ARBRAWN"));
//scr_party_add_beast(scr_beast_init_random("FLITSAGE"));
//scr_party_add_beast(scr_beast_init_random("FURN"));
//scr_party_add_beast(scr_beast_init_random("TURFRANTULA"));

//scr_party_add_beast(scr_beast_init_random("SALTWAGG"));
//scr_party_add_beast(scr_beast_init_random("FROSTUSK"));
//scr_party_add_beast(scr_beast_init_random("GULFLOW"));
//scr_party_add_beast(scr_beast_init_random("CHELONSEA"));

scr_party_add_beast(scr_beast_init_random("PYREKNIGHT"));
scr_party_add_beast(scr_beast_init_random("DRAKOAL"));
scr_party_add_beast(scr_beast_init_random("PYROPLUME"));
scr_party_add_beast(scr_beast_init_random("LAVAROWANA"));

//----------------//
//TEST RANCH//
//----------------//
var _stct_test_ranch_arbrawn = scr_beast_init_random("ARBRAWN");

ds_list_add(
	global.list_player_ranch,
	_stct_test_ranch_arbrawn
);

scr_logbook_mark_beast_captured(
	_stct_test_ranch_arbrawn._str_beast_name
);

//----------------//
//TEST CARDS//
//----------------//

#region UNCOLORED

//scr_deck_add_card(scr_card_get_info("ARTIFACT_HOURGLASS"));
//scr_deck_add_card(scr_card_get_info("BLOCK"));
//scr_deck_add_card(scr_card_get_info("BULWARK"));
//scr_deck_add_card(scr_card_get_info("CLEARCAST"));
//scr_deck_add_card(scr_card_get_info("DEFT_STRIKE"));
//scr_deck_add_card(scr_card_get_info("ECHO"));
//scr_deck_add_card(scr_card_get_info("HIDDEN_CARD"));
//scr_deck_add_card(scr_card_get_info("INSPIRATION"));
//scr_deck_add_card(scr_card_get_info("MALLEABILITY"));
//scr_deck_add_card(scr_card_get_info("POWER_STRIKE"));
//scr_deck_add_card(scr_card_get_info("RAPID_STRIKES"));
//scr_deck_add_card(scr_card_get_info("REPOSITION"));
//scr_deck_add_card(scr_card_get_info("SHIV"));
//scr_deck_add_card(scr_card_get_info("SOULCLEANSE"));
//scr_deck_add_card(scr_card_get_info("SPELLBOOK_WILDCARD"));
//scr_deck_add_card(scr_card_get_info("STRIKE"));
//scr_deck_add_card(scr_card_get_info("THOUGHTSTEAL"));

#endregion

#region VIRIDIAN

//----------------//
//ATTACK: DIRECT//
//----------------//
//scr_deck_add_card(scr_card_get_info("BIOBOLT"));
//scr_deck_add_card(scr_card_get_info("BIOSTORM"));
//scr_deck_add_card(scr_card_get_info("BRAMBLE_ERUPTION"));
//scr_deck_add_card(scr_card_get_info("CLAW"));
//scr_deck_add_card(scr_card_get_info("FELL"));
//scr_deck_add_card(scr_card_get_info("FERAL_FRENZY"));
//scr_deck_add_card(scr_card_get_info("HUNTERS_JAVELIN"));
//scr_deck_add_card(scr_card_get_info("NATURES_FURY"));
//scr_deck_add_card(scr_card_get_info("PRIMAL_BLAST"));
//scr_deck_add_card(scr_card_get_info("SAVAGE_MAUL"));
//scr_deck_add_card(scr_card_get_info("SPIKE_PIERCE"));
//scr_deck_add_card(scr_card_get_info("SPINESLING"));
//scr_deck_add_card(scr_card_get_info("SPIRIT_PIERCE"));
//scr_deck_add_card(scr_card_get_info("SPORE_CLOUD"));
//scr_deck_add_card(scr_card_get_info("STALKING_SWIPE"));
//scr_deck_add_card(scr_card_get_info("STAMPEDE"));
//scr_deck_add_card(scr_card_get_info("UNSEEN_ROOT"));
//scr_deck_add_card(scr_card_get_info("VERDANT_SWIPES"));
//scr_deck_add_card(scr_card_get_info("WILDSTRIKE"));

//----------------//
//ATTACK: SPECIALTY//
//----------------//
//scr_deck_add_card(scr_card_get_info("BEASTIAL_WRATH"));
//scr_deck_add_card(scr_card_get_info("GREENFLOW"));
//scr_deck_add_card(scr_card_get_info("HUNTERS_INSTINCT"));
//scr_deck_add_card(scr_card_get_info("NATURES_WRATH"));
//scr_deck_add_card(scr_card_get_info("OLD_GROWTH_PUMMEL"));
//scr_deck_add_card(scr_card_get_info("ROT_BLOOM"));
//scr_deck_add_card(scr_card_get_info("SEED_BARRAGE"));
//scr_deck_add_card(scr_card_get_info("SNARLING_BITE"));
//scr_deck_add_card(scr_card_get_info("THORN_STORM"));
//scr_deck_add_card(scr_card_get_info("TOXIC_ERUPTION"));
//scr_deck_add_card(scr_card_get_info("VERDANT_BOLT"));
//scr_deck_add_card(scr_card_get_info("VIRIDIAN_BURST"));

//----------------//
//ATTACK: DOT//
//----------------//
//scr_deck_add_card(scr_card_get_info("BLOWDART"));
//scr_deck_add_card(scr_card_get_info("POTENT_SPORE"));
//scr_deck_add_card(scr_card_get_info("RAKE"));
//scr_deck_add_card(scr_card_get_info("SPIRIT_FANG"));
//scr_deck_add_card(scr_card_get_info("SPIT_VENOM"));
//scr_deck_add_card(scr_card_get_info("VIRAL_SURGE"));

//----------------//
//DEFENSE//
//----------------//
//scr_deck_add_card(scr_card_get_info("BARKSKIN"));
//scr_deck_add_card(scr_card_get_info("BLOOMING_SHIELD"));
//scr_deck_add_card(scr_card_get_info("INTERLOCKING_SCALES"));
//scr_deck_add_card(scr_card_get_info("NATURAL_RECOVERY"));
//scr_deck_add_card(scr_card_get_info("NATURES_GRACE"));
//scr_deck_add_card(scr_card_get_info("OVERGROWTH"));
//scr_deck_add_card(scr_card_get_info("REGENERATE"));
//scr_deck_add_card(scr_card_get_info("ROOTED_DEFENSE"));
//scr_deck_add_card(scr_card_get_info("SECOND_BLOOM"));
//scr_deck_add_card(scr_card_get_info("SINEWY_VINES"));
//scr_deck_add_card(scr_card_get_info("STEELFUR"));
//scr_deck_add_card(scr_card_get_info("SYMBIOSIS"));
//scr_deck_add_card(scr_card_get_info("THICK_HIDE"));
//scr_deck_add_card(scr_card_get_info("THORNMAIL"));
//scr_deck_add_card(scr_card_get_info("WILDWARD"));

//----------------//
//UTILITY//
//----------------//
//scr_deck_add_card(scr_card_get_info("BLOOMING_SPRITE"));
//scr_deck_add_card(scr_card_get_info("BLOOMTIDE"));
//scr_deck_add_card(scr_card_get_info("DISTRACTING_TRAP"));
//scr_deck_add_card(scr_card_get_info("DORMANT_SEED"));
//scr_deck_add_card(scr_card_get_info("EMERALD_WISDOM"));
//scr_deck_add_card(scr_card_get_info("FUNGAL_RECYCLING"));
//scr_deck_add_card(scr_card_get_info("GERMINATE"));
//scr_deck_add_card(scr_card_get_info("GREENSTEP"));
//scr_deck_add_card(scr_card_get_info("GROWTH_SIGIL"));
//scr_deck_add_card(scr_card_get_info("LIFE_SPIRIT"));
//scr_deck_add_card(scr_card_get_info("MANAVINE"));
//scr_deck_add_card(scr_card_get_info("NATURAL_CYCLE"));
//scr_deck_add_card(scr_card_get_info("PHEROMONES"));
//scr_deck_add_card(scr_card_get_info("RETURN_TO_NATURE"));
//scr_deck_add_card(scr_card_get_info("ROTTING_SPORES"));
//scr_deck_add_card(scr_card_get_info("SEED_THE_FIELD"));
//scr_deck_add_card(scr_card_get_info("SERPENT_SUMMON"));
//scr_deck_add_card(scr_card_get_info("THORN_NET"));
//scr_deck_add_card(scr_card_get_info("TOXIC_SNARE"));
//scr_deck_add_card(scr_card_get_info("TRANQUILITY"));
//scr_deck_add_card(scr_card_get_info("VENOM_BLOOM"));

//----------------//
//SUPPORT//
//----------------//
//scr_deck_add_card(scr_card_get_info("BRAMBLE_HIDE"));
//scr_deck_add_card(scr_card_get_info("BURGEONING_BLOOM"));
//scr_deck_add_card(scr_card_get_info("BURSTING_SEED"));
//scr_deck_add_card(scr_card_get_info("CRIPPLING_VINES"));
//scr_deck_add_card(scr_card_get_info("CULTIVATE"));
//scr_deck_add_card(scr_card_get_info("CURE_ALL"));
//scr_deck_add_card(scr_card_get_info("DECAYING_TOUCH"));
//scr_deck_add_card(scr_card_get_info("DISEASE"));
//scr_deck_add_card(scr_card_get_info("DRAINING_KISS"));
//scr_deck_add_card(scr_card_get_info("EMERALD_SLAM"));
//scr_deck_add_card(scr_card_get_info("ENTANGLE"));
//scr_deck_add_card(scr_card_get_info("HONEYED_SCENT"));
//scr_deck_add_card(scr_card_get_info("LIFEBLOOM"));
//scr_deck_add_card(scr_card_get_info("MIRACLE_MUSA"));
//scr_deck_add_card(scr_card_get_info("NATURES_BOND"));
//scr_deck_add_card(scr_card_get_info("NATURES_MEND"));
//scr_deck_add_card(scr_card_get_info("PACK_INSTINCT"));
//scr_deck_add_card(scr_card_get_info("POLLINATE"));
//scr_deck_add_card(scr_card_get_info("POTENT_FRUIT"));
//scr_deck_add_card(scr_card_get_info("PREDATORS_MARK"));
//scr_deck_add_card(scr_card_get_info("PREDATORY_SCENT"));
//scr_deck_add_card(scr_card_get_info("REJUVENATE"));
//scr_deck_add_card(scr_card_get_info("SAPSPRING"));
//scr_deck_add_card(scr_card_get_info("SHIMMERING_SPORES"));
//scr_deck_add_card(scr_card_get_info("SLEEP_DART"));
//scr_deck_add_card(scr_card_get_info("SLEEPING_POLLEN"));
//scr_deck_add_card(scr_card_get_info("TOXIC_HIDE"));
//scr_deck_add_card(scr_card_get_info("VERDANT_EMBRACE"));
//scr_deck_add_card(scr_card_get_info("VERDANT_INSIGHT"));
//scr_deck_add_card(scr_card_get_info("WILD_VIGOR"));
//scr_deck_add_card(scr_card_get_info("WILT"));

//----------------//
//ARCHETYPE//
//----------------//
//scr_deck_add_card(scr_card_get_info("ANCIENT_GROVE"));
//scr_deck_add_card(scr_card_get_info("APEX_PREDATOR"));
//scr_deck_add_card(scr_card_get_info("CHANNEL_THE_SPIRITS"));
//scr_deck_add_card(scr_card_get_info("CIRCLE_OF_LIFE"));
//scr_deck_add_card(scr_card_get_info("ENDLESS_BLOOM"));
//scr_deck_add_card(scr_card_get_info("FOR_THE_THROAT"));
//scr_deck_add_card(scr_card_get_info("HEART_OF_THE_FOREST"));
//scr_deck_add_card(scr_card_get_info("PLAGUE_GARDEN"));
//scr_deck_add_card(scr_card_get_info("PROLIFERATE"));

#endregion

#region CERULEAN

//----------------//
//ATTACK//
//----------------//
//scr_deck_add_card(scr_card_get_info("HAILSTONES"));
//scr_deck_add_card(scr_card_get_info("AVALANCHE_STRIKE"));
//scr_deck_add_card(scr_card_get_info("ICE_LANCE"));
//scr_deck_add_card(scr_card_get_info("TORRENT"));
//scr_deck_add_card(scr_card_get_info("BURST"));
//scr_deck_add_card(scr_card_get_info("TIDAL_SLASH"));
//scr_deck_add_card(scr_card_get_info("GLACIAL_CRUSH"));
//scr_deck_add_card(scr_card_get_info("RAZOR_FIN"));
//scr_deck_add_card(scr_card_get_info("ABYSSAL_TOUCH"));
//scr_deck_add_card(scr_card_get_info("DEEP_CURRENT"));
//scr_deck_add_card(scr_card_get_info("FROZEN_FANG"));
//scr_deck_add_card(scr_card_get_info("FROSTBOLT"));
//scr_deck_add_card(scr_card_get_info("CHILLING_WORD"));
//scr_deck_add_card(scr_card_get_info("FROZEN_SPEAR"));
//scr_deck_add_card(scr_card_get_info("ARCTIC_VOLLEY"));
//scr_deck_add_card(scr_card_get_info("CRASHING_WAVE"));
//scr_deck_add_card(scr_card_get_info("WHITEWATER"));

//----------------//
//ATTACK: SPECIALTY//
//----------------//
//scr_deck_add_card(scr_card_get_info("SHATTER_STRIKE"));
//scr_deck_add_card(scr_card_get_info("PRESSURE_SPIKE"));
//scr_deck_add_card(scr_card_get_info("COLD_SNAP"));
//scr_deck_add_card(scr_card_get_info("TIDAL_BREAK"));
//scr_deck_add_card(scr_card_get_info("DEPTH_CHARGE"));
//scr_deck_add_card(scr_card_get_info("WINTERS_BITE"));
//scr_deck_add_card(scr_card_get_info("WINTER_RESONANCE"));
//scr_deck_add_card(scr_card_get_info("ABSOLUTE_ZERO"));
//scr_deck_add_card(scr_card_get_info("BITTER_CHILL"));
//scr_deck_add_card(scr_card_get_info("PRESSURE_CRUSH"));
//scr_deck_add_card(scr_card_get_info("KRAKENSLAM"));
//scr_deck_add_card(scr_card_get_info("FROSTBURN_NOVA"));
//scr_deck_add_card(scr_card_get_info("GLACIAL_ERUPTION"));
//scr_deck_add_card(scr_card_get_info("FRACTURE"));

//----------------//
//DEFENSE//
//----------------//
//scr_deck_add_card(scr_card_get_info("SHELL_SHIELD"));
//scr_deck_add_card(scr_card_get_info("ICE_PLATING"));
//scr_deck_add_card(scr_card_get_info("FROZEN_BULWARK"));
//scr_deck_add_card(scr_card_get_info("SNOWFORT"));
//scr_deck_add_card(scr_card_get_info("SNOWDRIFT"));
//scr_deck_add_card(scr_card_get_info("ICE_ACCRETION"));
//scr_deck_add_card(scr_card_get_info("FROZEN_BASTION"));
//scr_deck_add_card(scr_card_get_info("BUBBLE"));
//scr_deck_add_card(scr_card_get_info("CRYSTAL_SHELL"));
//scr_deck_add_card(scr_card_get_info("FROZEN_ARMOR"));
//scr_deck_add_card(scr_card_get_info("STATIC_BARRIER"));
//scr_deck_add_card(scr_card_get_info("RAZOR_SHELL"));
//scr_deck_add_card(scr_card_get_info("ICE_MIRROR"));
//scr_deck_add_card(scr_card_get_info("ARMOR_TRANSFER"));
//scr_deck_add_card(scr_card_get_info("SHARED_BULWARK"));
//scr_deck_add_card(scr_card_get_info("COLD_RESERVE"));

//----------------//
//UTILITY//
//----------------//
//scr_deck_add_card(scr_card_get_info("RAIN"));
//scr_deck_add_card(scr_card_get_info("SNOWFALL"));
//scr_deck_add_card(scr_card_get_info("THUNDERSTORM"));
//scr_deck_add_card(scr_card_get_info("THIN_ICE"));
//scr_deck_add_card(scr_card_get_info("STORM_BEACON"));
//scr_deck_add_card(scr_card_get_info("PULLED_UNDER"));
//scr_deck_add_card(scr_card_get_info("ICE_WALL"));
//scr_deck_add_card(scr_card_get_info("RIMEFROST_ELEMENTAL"));
//scr_deck_add_card(scr_card_get_info("STORM_WISP"));
//scr_deck_add_card(scr_card_get_info("ABYSSAL_HARPOON"));
//scr_deck_add_card(scr_card_get_info("CORAL_GUARDIAN"));
//scr_deck_add_card(scr_card_get_info("ANCHOR_STONE"));
//scr_deck_add_card(scr_card_get_info("DEEPFLOW_WHISPERSONG"));
//scr_deck_add_card(scr_card_get_info("UNDERTOW"));
//scr_deck_add_card(scr_card_get_info("RIP_CURRENT"));
//scr_deck_add_card(scr_card_get_info("AQUA_STEP"));
//scr_deck_add_card(scr_card_get_info("RIPPLING_POOL"));
//scr_deck_add_card(scr_card_get_info("DEEP_REFLECTION"));
//scr_deck_add_card(scr_card_get_info("ANCIENT_CHARTS"));
//scr_deck_add_card(scr_card_get_info("TIDAL_FLOW"));
//scr_deck_add_card(scr_card_get_info("MANA_SPRING"));
//scr_deck_add_card(scr_card_get_info("PURIFY_WATERS"));
//scr_deck_add_card(scr_card_get_info("ICEBOUND_SEAL"));
//scr_deck_add_card(scr_card_get_info("TIDEHEART"));

//----------------//
//SUPPORT//
//----------------//
//scr_deck_add_card(scr_card_get_info("SEA_LEGS"));
//scr_deck_add_card(scr_card_get_info("DROP_ANCHOR"));
//scr_deck_add_card(scr_card_get_info("SAILORS_RESOLVE"));
//scr_deck_add_card(scr_card_get_info("ARCTIC_FOCUS"));
//scr_deck_add_card(scr_card_get_info("FROST_WEAPON"));
//scr_deck_add_card(scr_card_get_info("FROZEN_PRECISION"));
//scr_deck_add_card(scr_card_get_info("DEEP_MOMENTUM"));
//scr_deck_add_card(scr_card_get_info("ICEBOUND_INSTINCT"));
//scr_deck_add_card(scr_card_get_info("HYPOTHERMIA"));
//scr_deck_add_card(scr_card_get_info("BRITTLE_CONSTITUTION"));
//scr_deck_add_card(scr_card_get_info("WHITEOUT"));
//scr_deck_add_card(scr_card_get_info("FROZEN_CURSE"));
//scr_deck_add_card(scr_card_get_info("PERMAFROST"));
//scr_deck_add_card(scr_card_get_info("CHILLING_WEAKNESS"));
//scr_deck_add_card(scr_card_get_info("SOOTHING_CURRENT"));
//scr_deck_add_card(scr_card_get_info("COOLING_MIST"));
//scr_deck_add_card(scr_card_get_info("CRYOGENIC_RECOVERY"));
//scr_deck_add_card(scr_card_get_info("TIDAL_RECOVERY"));
//scr_deck_add_card(scr_card_get_info("OCEANS_BLESSING"));
//scr_deck_add_card(scr_card_get_info("ICE_PRISON"));
//scr_deck_add_card(scr_card_get_info("DENSE_FOG"));
//scr_deck_add_card(scr_card_get_info("WHIRLPOOL"));
//scr_deck_add_card(scr_card_get_info("CALM_SEAS"));
//scr_deck_add_card(scr_card_get_info("ROUGH_SEAS"));
//scr_deck_add_card(scr_card_get_info("FROSTFORM"));
//scr_deck_add_card(scr_card_get_info("KRAKENS_CHOSEN"));
//scr_deck_add_card(scr_card_get_info("MARINE_MEND"));
//scr_deck_add_card(scr_card_get_info("CALL_THE_DEEP"));
//scr_deck_add_card(scr_card_get_info("ICE_AGE"));
//scr_deck_add_card(scr_card_get_info("KRAKEN_AWAKENS"));
//scr_deck_add_card(scr_card_get_info("WINTERS_HOUR"));
//scr_deck_add_card(scr_card_get_info("CERULEAN_GODS_WRATH"));
//scr_deck_add_card(scr_card_get_info("LEVIATHANS_BLESSING"));
//scr_deck_add_card(scr_card_get_info("OCEANS_EMBRACE"));
//scr_deck_add_card(scr_card_get_info("SHATTERSTORM"));
//scr_deck_add_card(scr_card_get_info("THE_ABYSS_STARES_BACK"));

#endregion

#region VERMILION
//----------------//
//ATTACK//
//----------------//
//scr_deck_add_card(scr_card_get_info("FIERY_BLOW"));
//scr_deck_add_card(scr_card_get_info("HELLFIRE_STRIKE"));
//scr_deck_add_card(scr_card_get_info("CINDER_SPEAR"));
//scr_deck_add_card(scr_card_get_info("BLOODFLAME_BOLT"));
//scr_deck_add_card(scr_card_get_info("BERSERKER_CHARGE"));
//scr_deck_add_card(scr_card_get_info("FLAME_LANCE"));
//scr_deck_add_card(scr_card_get_info("BERSERKER_FLURRY"));
//scr_deck_add_card(scr_card_get_info("EMBER_BARRAGE"));
//scr_deck_add_card(scr_card_get_info("MOLTEN_EDGE"));
//scr_deck_add_card(scr_card_get_info("SEARING_RAY"));
//scr_deck_add_card(scr_card_get_info("RAGING_BLOW"));
//scr_deck_add_card(scr_card_get_info("PYROCLAST"));
//scr_deck_add_card(scr_card_get_info("BURNING_CLEAVE"));
//scr_deck_add_card(scr_card_get_info("FLAME_SPOUT"));
//scr_deck_add_card(scr_card_get_info("BLOODLETTING"));
//scr_deck_add_card(scr_card_get_info("COMBUSTION"));
//scr_deck_add_card(scr_card_get_info("EMBER_SHOT"));
//scr_deck_add_card(scr_card_get_info("SCORCHING_CLAW"));
//scr_deck_add_card(scr_card_get_info("BARBED_BOLT"));
//scr_deck_add_card(scr_card_get_info("RENDING_BLOW"));
scr_deck_add_card(scr_card_get_info("FORWARD_MARCH"));
scr_deck_add_card(scr_card_get_info("FURIOUS_SLICE"));
scr_deck_add_card(scr_card_get_info("RAGING_SPARK"));
scr_deck_add_card(scr_card_get_info("BLOODFLAME_NEEDLE"));
scr_deck_add_card(scr_card_get_info("FLASHPOINT"));
 
#endregion

//----------------//
//TEST INVENTORY//
//----------------//
//scr_inventory_add_item("QUEST_IMPORTANT_NOTEBOOK",1);
//scr_inventory_add_item("CONSUMABLE_HEALING_SALVE",3);
//scr_inventory_add_item("PRISM_COMMON",7);
//scr_inventory_add_item("PRISM_ARCWORK",7);
//scr_inventory_add_item("PRISM_RARE",7);
//scr_inventory_add_item("HELD_VERDANT_SEED",1);
//scr_inventory_add_item("HELD_POWERFUL_STONE",1);
//scr_inventory_add_item("HELD_SORCEROUS_GEM",1);
//scr_inventory_add_item("HELD_INSPIRING_CHIME",5);
//scr_inventory_add_item("EGG_ARBRAWN",2);

//scr_inventory_add_item("HELD_EMERALD_TALISMAN",2);
//scr_inventory_add_item("HELD_BURNING_ASH",1);
//scr_inventory_add_item("HELD_BOLSTERING_SHELL",1);
//scr_inventory_add_item("HELD_HEALING_FRUIT",1);
//scr_inventory_add_item("HELD_GOLD_FANG",1);

//----------------------//
//DEBUG PLAYER CONTENT//
//----------------------//
scr_debug_log(
	"PLAYER",
	"INIT",
	self,
	"STARTING DATA READY | PARTY: " + string(ds_list_size(global.list_player_party)) +
	" | RANCH: " + string(ds_list_size(global.list_player_ranch)) +
	" | DECK: " + string(ds_list_size(global.list_player_deck)) +
	" | LIBRARY: " + string(ds_list_size(global.list_player_library)) +
	" | INVENTORY: " + string(ds_list_size(global.list_player_inventory)) +
	" | GOLD: " + string(global.val_player_gold),
	"INIT",
	"OBJ_PLAYER:CREATE"
);

#endregion

//----------------//
//DEBUG COMPLETE//
//----------------//
scr_debug_log(
	"PLAYER",
	"INIT",
	self,
	"PLAYER SESSION INITIALIZATION COMPLETE | ROOM: " + room_get_name(room) +
	" | POSITION: (" + string(round(x)) + "," + string(round(y)) + ")",
	"INIT",
	"OBJ_PLAYER:CREATE"
);

#endregion

//================//
//METHODS//
//================//
#region METHODS

//-------------------------------------------------------------------------------//
// HSCR_PLAYER_SPAWN_STEP_PARTICLES
// FUNCTION: Spawns overworld footstep particles while the player moves.
//           Sprinting increases the number of particles spawned.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_player_spawn_step_particles = function(){

	var _ct_particles = irandom_range(1,3);

	if (_flag_player_sprinting){
		_ct_particles *= 3;
	}

	for (var _it_particle = 0; _it_particle < _ct_particles; _it_particle++){

		instance_create_layer(
			x,
			y,
			"ily_fx",
			obj_overworld_vfx_step_particle
		);
	}
};

#endregion