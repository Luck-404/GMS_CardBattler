//===============================================================================//
//
// SCRIPT: SCR_LOGBOOK_INIT_CARDS
// FUNCTION: Initializes the card logbook catalog.
//           Creates one persistent logbook entry for each known card id.
//           Stores entries in both an ordered list and lookup map.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_logbook_init_cards(){

	//================//
	//RESET LOGBOOK//
	//================//
	ds_list_clear(global.list_logbook_cards);
	ds_map_clear(global.map_logbook_cards);

	//================//
	//LOCAL METHODS//
	//================//

	//-------------------------------------------------------------------------------//
	// HSCR_LOGBOOK_ADD_CARD_ENTRY
	// FUNCTION: Creates and registers one card logbook entry.
	//           Prevents duplicate card ids from being registered.
	//
	// ARGUMENTS: _str_card_id is the card id; _str_color_group is its color group.
	// RETURNS: Nothing.
	//
	//-------------------------------------------------------------------------------//
	function hscr_logbook_add_card_entry(_str_card_id,_str_color_group){

		//----------------//
		//PREVENT DUPLICATE//
		//----------------//
		if (ds_map_exists(global.map_logbook_cards,_str_card_id)){
			return;
		}

		//----------------//
		//GET CARD INFO//
		//----------------//
		var _stct_card_info = scr_card_get_info(_str_card_id);
		var _flag_has_card_info =
			is_struct(_stct_card_info) &&
			_stct_card_info._str_card_name != "DEFAULT";

		//----------------//
		//MISSING CARD INFO//
		//----------------//
		if (!_flag_has_card_info){

			_stct_card_info = undefined;

			scr_debug_log(
				"LOGBOOK",
				"INIT_CARDS",
				undefined,
				"Missing card info for id: " + string(_str_card_id)
			);
		}

		//----------------//
		//CREATE ENTRY//
		//----------------//
		var _stct_entry = {
			_str_card_id : _str_card_id,
			_str_card_name : _str_card_id,
			_str_color_group : _str_color_group,
			_stct_card_info : _stct_card_info,
			_flag_has_card_info : _flag_has_card_info,
			_flag_seen : false,
			_flag_obtained : false,
			_ct_seen : 0,
			_ct_obtained : 0
		};

		//----------------//
		//SET DISPLAY NAME//
		//----------------//
		if (_flag_has_card_info){
			_stct_entry._str_card_name = _stct_card_info._str_card_name;
		}

		//----------------//
		//REGISTER ENTRY//
		//----------------//
		ds_list_add(global.list_logbook_cards,_stct_entry);
		global.map_logbook_cards[? _str_card_id] = _stct_entry;
	}

	#region UNCOLORED

	//----------------//
	//ATTACK - BASIC//
	//----------------//
	#region ATTACK_BASIC

	hscr_logbook_add_card_entry("POWER_STRIKE","UNCOLORED");
	hscr_logbook_add_card_entry("RAPID_STRIKES","UNCOLORED");
	hscr_logbook_add_card_entry("STRIKE","UNCOLORED");

	#endregion

	//----------------//
	//ATTACK - DOT//
	//----------------//
	#region ATTACK_DOT

	hscr_logbook_add_card_entry("DEFT_STRIKE","UNCOLORED");
	hscr_logbook_add_card_entry("SPELLBOOK_WILDCARD","UNCOLORED");

	#endregion

	//----------------//
	//ATTACK - SPECIAL//
	//----------------//
	#region ATTACK_SPECIAL

	hscr_logbook_add_card_entry("SHIV","UNCOLORED");

	#endregion

	//----------------//
	//DEFENSE//
	//----------------//
	#region DEFENSE

	hscr_logbook_add_card_entry("BLOCK","UNCOLORED");
	hscr_logbook_add_card_entry("BULWARK","UNCOLORED");

	#endregion

	//----------------//
	//UTILITY//
	//----------------//
	#region UTILITY

	hscr_logbook_add_card_entry("ARTIFACT_HOURGLASS","UNCOLORED");
	hscr_logbook_add_card_entry("CLEARCAST","UNCOLORED");
	hscr_logbook_add_card_entry("ECHO","UNCOLORED");
	hscr_logbook_add_card_entry("HIDDEN_CARD","UNCOLORED");
	hscr_logbook_add_card_entry("INSPIRATION","UNCOLORED");
	hscr_logbook_add_card_entry("MALLEABILITY","UNCOLORED");
	hscr_logbook_add_card_entry("REPOSITION","UNCOLORED");
	hscr_logbook_add_card_entry("THOUGHTSTEAL","UNCOLORED");

	#endregion

	//----------------//
	//SUPPORT//
	//----------------//
	#region SUPPORT

	hscr_logbook_add_card_entry("SOULCLEANSE","UNCOLORED");

	#endregion

	#endregion

	#region VIRIDIAN

	//----------------//
	//ATTACK - BASIC//
	//----------------//
	#region ATTACK_BASIC

	hscr_logbook_add_card_entry("BIOBOLT","VIRIDIAN");
	hscr_logbook_add_card_entry("CLAW","VIRIDIAN");
	hscr_logbook_add_card_entry("FELL","VIRIDIAN");
	hscr_logbook_add_card_entry("FERAL_FRENZY","VIRIDIAN");
	hscr_logbook_add_card_entry("HUNTERS_JAVELIN","VIRIDIAN");
	hscr_logbook_add_card_entry("NATURES_FURY","VIRIDIAN");
	hscr_logbook_add_card_entry("PRIMAL_BLAST","VIRIDIAN");
	hscr_logbook_add_card_entry("SAVAGE_MAUL","VIRIDIAN");
	hscr_logbook_add_card_entry("SPINESLING","VIRIDIAN");
	hscr_logbook_add_card_entry("SPORE_CLOUD","VIRIDIAN");
	hscr_logbook_add_card_entry("STALKING_SWIPE","VIRIDIAN");
	hscr_logbook_add_card_entry("UNSEEN_ROOT","VIRIDIAN");
	hscr_logbook_add_card_entry("VERDANT_SWIPES","VIRIDIAN");
	hscr_logbook_add_card_entry("WILDSTRIKE","VIRIDIAN");

	#endregion

	//----------------//
	//ATTACK - DOT//
	//----------------//
	#region ATTACK_DOT

	hscr_logbook_add_card_entry("BLOWDART","VIRIDIAN");
	hscr_logbook_add_card_entry("POTENT_SPORE","VIRIDIAN");
	hscr_logbook_add_card_entry("RAKE","VIRIDIAN");
	hscr_logbook_add_card_entry("SPIRIT_FANG","VIRIDIAN");
	hscr_logbook_add_card_entry("SPIT_VENOM","VIRIDIAN");
	hscr_logbook_add_card_entry("VERDANT_BOLT","VIRIDIAN");
	hscr_logbook_add_card_entry("VIRAL_SURGE","VIRIDIAN");
	hscr_logbook_add_card_entry("VIRIDIAN_BURST","VIRIDIAN");

	#endregion

	//----------------//
	//ATTACK - SPECIAL//
	//----------------//
	#region ATTACK_SPECIAL

	hscr_logbook_add_card_entry("BEASTIAL_WRATH","VIRIDIAN");
	hscr_logbook_add_card_entry("BIOSTORM","VIRIDIAN");
	hscr_logbook_add_card_entry("BRAMBLE_ERUPTION","VIRIDIAN");
	hscr_logbook_add_card_entry("GREENFLOW","VIRIDIAN");
	hscr_logbook_add_card_entry("HUNTERS_INSTINCT","VIRIDIAN");
	hscr_logbook_add_card_entry("NATURES_WRATH","VIRIDIAN");
	hscr_logbook_add_card_entry("OLD_GROWTH_PUMMEL","VIRIDIAN");
	hscr_logbook_add_card_entry("ROT_BLOOM","VIRIDIAN");
	hscr_logbook_add_card_entry("SEED_BARRAGE","VIRIDIAN");
	hscr_logbook_add_card_entry("SNARLING_BITE","VIRIDIAN");
	hscr_logbook_add_card_entry("SPIKE_PIERCE","VIRIDIAN");
	hscr_logbook_add_card_entry("SPIRIT_PIERCE","VIRIDIAN");
	hscr_logbook_add_card_entry("STAMPEDE","VIRIDIAN");
	hscr_logbook_add_card_entry("THORN_STORM","VIRIDIAN");
	hscr_logbook_add_card_entry("TOXIC_ERUPTION","VIRIDIAN");

	#endregion

	//----------------//
	//DEFENSE//
	//----------------//
	#region DEFENSE

	hscr_logbook_add_card_entry("BARKSKIN","VIRIDIAN");
	hscr_logbook_add_card_entry("BLOOMING_SHIELD","VIRIDIAN");
	hscr_logbook_add_card_entry("INTERLOCKING_SCALES","VIRIDIAN");
	hscr_logbook_add_card_entry("NATURAL_RECOVERY","VIRIDIAN");
	hscr_logbook_add_card_entry("NATURES_GRACE","VIRIDIAN");
	hscr_logbook_add_card_entry("OVERGROWTH","VIRIDIAN");
	hscr_logbook_add_card_entry("REGENERATE","VIRIDIAN");
	hscr_logbook_add_card_entry("ROOTED_DEFENSE","VIRIDIAN");
	hscr_logbook_add_card_entry("SECOND_BLOOM","VIRIDIAN");
	hscr_logbook_add_card_entry("SINEWY_VINES","VIRIDIAN");
	hscr_logbook_add_card_entry("STEELFUR","VIRIDIAN");
	hscr_logbook_add_card_entry("SYMBIOSIS","VIRIDIAN");
	hscr_logbook_add_card_entry("THICK_HIDE","VIRIDIAN");
	hscr_logbook_add_card_entry("THORNMAIL","VIRIDIAN");
	hscr_logbook_add_card_entry("WILDWARD","VIRIDIAN");

	#endregion

	//----------------//
	//UTILITY//
	//----------------//
	#region UTILITY

	hscr_logbook_add_card_entry("BLOOMING_SPRITE","VIRIDIAN");
	hscr_logbook_add_card_entry("BLOOMTIDE","VIRIDIAN");
	hscr_logbook_add_card_entry("DISTRACTING_TRAP","VIRIDIAN");
	hscr_logbook_add_card_entry("DORMANT_SEED","VIRIDIAN");
	hscr_logbook_add_card_entry("EMERALD_WISDOM","VIRIDIAN");
	hscr_logbook_add_card_entry("FUNGAL_RECYCLING","VIRIDIAN");
	hscr_logbook_add_card_entry("GERMINATE","VIRIDIAN");
	hscr_logbook_add_card_entry("GREENSTEP","VIRIDIAN");
	hscr_logbook_add_card_entry("GROWTH_SIGIL","VIRIDIAN");
	hscr_logbook_add_card_entry("LIFE_SPIRIT","VIRIDIAN");
	hscr_logbook_add_card_entry("MANAVINE","VIRIDIAN");
	hscr_logbook_add_card_entry("NATURAL_CYCLE","VIRIDIAN");
	hscr_logbook_add_card_entry("PHEROMONES","VIRIDIAN");
	hscr_logbook_add_card_entry("RETURN_TO_NATURE","VIRIDIAN");
	hscr_logbook_add_card_entry("ROTTING_SPORES","VIRIDIAN");
	hscr_logbook_add_card_entry("SEED_THE_FIELD","VIRIDIAN");
	hscr_logbook_add_card_entry("SERPENT_SUMMON","VIRIDIAN");
	hscr_logbook_add_card_entry("THORN_NET","VIRIDIAN");
	hscr_logbook_add_card_entry("TOXIC_RECLAIMATION","VIRIDIAN");
	hscr_logbook_add_card_entry("TOXIC_SNARE","VIRIDIAN");
	hscr_logbook_add_card_entry("TRANQUILITY","VIRIDIAN");
	hscr_logbook_add_card_entry("VENOM_BLOOM","VIRIDIAN");

	#endregion

	//----------------//
	//SUPPORT//
	//----------------//
	#region SUPPORT

	hscr_logbook_add_card_entry("BRAMBLE_HIDE","VIRIDIAN");
	hscr_logbook_add_card_entry("BURGEONING_BLOOM","VIRIDIAN");
	hscr_logbook_add_card_entry("BURSTING_SEED","VIRIDIAN");
	hscr_logbook_add_card_entry("CRIPPLING_VINES","VIRIDIAN");
	hscr_logbook_add_card_entry("CULTIVATE","VIRIDIAN");
	hscr_logbook_add_card_entry("CURE_ALL","VIRIDIAN");
	hscr_logbook_add_card_entry("DECAYING_TOUCH","VIRIDIAN");
	hscr_logbook_add_card_entry("DISEASE","VIRIDIAN");
	hscr_logbook_add_card_entry("DRAINING_KISS","VIRIDIAN");
	hscr_logbook_add_card_entry("EMERALD_SLAM","VIRIDIAN");
	hscr_logbook_add_card_entry("ENTANGLE","VIRIDIAN");
	hscr_logbook_add_card_entry("HONEYED_SCENT","VIRIDIAN");
	hscr_logbook_add_card_entry("LIFEBLOOM","VIRIDIAN");
	hscr_logbook_add_card_entry("MIRACLE_MUSA","VIRIDIAN");
	hscr_logbook_add_card_entry("NATURES_BOND","VIRIDIAN");
	hscr_logbook_add_card_entry("NATURES_MEND","VIRIDIAN");
	hscr_logbook_add_card_entry("PACK_INSTINCT","VIRIDIAN");
	hscr_logbook_add_card_entry("POLLINATE","VIRIDIAN");
	hscr_logbook_add_card_entry("POTENT_FRUIT","VIRIDIAN");
	hscr_logbook_add_card_entry("PREDATORS_MARK","VIRIDIAN");
	hscr_logbook_add_card_entry("PREDATORY_SCENT","VIRIDIAN");
	hscr_logbook_add_card_entry("REJUVENATE","VIRIDIAN");
	hscr_logbook_add_card_entry("SAPSPRING","VIRIDIAN");
	hscr_logbook_add_card_entry("SHIMMERING_SPORES","VIRIDIAN");
	hscr_logbook_add_card_entry("SLEEP_DART","VIRIDIAN");
	hscr_logbook_add_card_entry("SLEEPING_POLLEN","VIRIDIAN");
	hscr_logbook_add_card_entry("TOXIC_HIDE","VIRIDIAN");
	hscr_logbook_add_card_entry("VERDANT_EMBRACE","VIRIDIAN");
	hscr_logbook_add_card_entry("VERDANT_INSIGHT","VIRIDIAN");
	hscr_logbook_add_card_entry("WILD_VIGOR","VIRIDIAN");
	hscr_logbook_add_card_entry("WILT","VIRIDIAN");

	#endregion

	//----------------//
	//ARCHETYPE//
	//----------------//
	#region ARCHETYPE

	hscr_logbook_add_card_entry("ANCIENT_GROVE","VIRIDIAN");
	hscr_logbook_add_card_entry("APEX_PREDATOR","VIRIDIAN");
	hscr_logbook_add_card_entry("CHANNEL_THE_SPIRITS","VIRIDIAN");
	hscr_logbook_add_card_entry("CIRCLE_OF_LIFE","VIRIDIAN");
	hscr_logbook_add_card_entry("ENDLESS_BLOOM","VIRIDIAN");
	hscr_logbook_add_card_entry("FOR_THE_THROAT","VIRIDIAN");
	hscr_logbook_add_card_entry("HEART_OF_THE_FOREST","VIRIDIAN");
	hscr_logbook_add_card_entry("PLAGUE_GARDEN","VIRIDIAN");
	hscr_logbook_add_card_entry("PROLIFERATE","VIRIDIAN");

	#endregion

	#endregion

	#region CERULEAN

	//----------------//
	//ATTACK - BASIC//
	//----------------//
	#region ATTACK_BASIC

	hscr_logbook_add_card_entry("ABYSSAL_TOUCH","CERULEAN");
	hscr_logbook_add_card_entry("ARCTIC_VOLLEY","CERULEAN");
	hscr_logbook_add_card_entry("BURST","CERULEAN");
	hscr_logbook_add_card_entry("FROZEN_SPEAR","CERULEAN");
	hscr_logbook_add_card_entry("GLACIAL_CRUSH","CERULEAN");
	hscr_logbook_add_card_entry("TORRENT","CERULEAN");

	#endregion

	//----------------//
	//ATTACK - DOT//
	//----------------//
	#region ATTACK_DOT

	hscr_logbook_add_card_entry("BITTER_CHILL","CERULEAN");
	hscr_logbook_add_card_entry("CHILLING_WORD","CERULEAN");
	hscr_logbook_add_card_entry("FROSTBURN_NOVA","CERULEAN");

	#endregion

	//----------------//
	//ATTACK - SPECIAL//
	//----------------//
	#region ATTACK_SPECIAL

	hscr_logbook_add_card_entry("ABSOLUTE_ZERO","CERULEAN");
	hscr_logbook_add_card_entry("AVALANCHE_STRIKE","CERULEAN");
	hscr_logbook_add_card_entry("COLD_SNAP","CERULEAN");
	hscr_logbook_add_card_entry("CRASHING_WAVE","CERULEAN");
	hscr_logbook_add_card_entry("DEEP_CURRENT","CERULEAN");
	hscr_logbook_add_card_entry("DEPTH_CHARGE","CERULEAN");
	hscr_logbook_add_card_entry("FORCED_OVERLOAD","CERULEAN");
	hscr_logbook_add_card_entry("FRACTURE","CERULEAN");
	hscr_logbook_add_card_entry("FROSTBOLT","CERULEAN");
	hscr_logbook_add_card_entry("FROZEN_FANG","CERULEAN");
	hscr_logbook_add_card_entry("GLACIAL_ERUPTION","CERULEAN");
	hscr_logbook_add_card_entry("HAILSTONES","CERULEAN");
	hscr_logbook_add_card_entry("ICE_LANCE","CERULEAN");
	hscr_logbook_add_card_entry("KRAKENSLAM","CERULEAN");
	hscr_logbook_add_card_entry("PRESSURE_CRUSH","CERULEAN");
	hscr_logbook_add_card_entry("PRESSURE_SPIKE","CERULEAN");
	hscr_logbook_add_card_entry("RAZOR_FIN","CERULEAN");
	hscr_logbook_add_card_entry("SHATTER_STRIKE","CERULEAN");
	hscr_logbook_add_card_entry("TIDAL_BREAK","CERULEAN");
	hscr_logbook_add_card_entry("TIDAL_SLASH","CERULEAN");
	hscr_logbook_add_card_entry("THUNDERCLAP","CERULEAN");
	hscr_logbook_add_card_entry("WHITEWATER","CERULEAN");
	hscr_logbook_add_card_entry("WINTER_RESONANCE","CERULEAN");
	hscr_logbook_add_card_entry("WINTERS_BITE","CERULEAN");

	#endregion

	//----------------//
	//DEFENSE//
	//----------------//
	#region DEFENSE

	hscr_logbook_add_card_entry("ARMOR_TRANSFER","CERULEAN");
	hscr_logbook_add_card_entry("BUBBLE","CERULEAN");
	hscr_logbook_add_card_entry("COLD_RESERVE","CERULEAN");
	hscr_logbook_add_card_entry("CRYSTAL_SHELL","CERULEAN");
	hscr_logbook_add_card_entry("FROZEN_BASTION","CERULEAN");
	hscr_logbook_add_card_entry("FROZEN_BULWARK","CERULEAN");
	hscr_logbook_add_card_entry("ICE_ACCRETION","CERULEAN");
	hscr_logbook_add_card_entry("ICE_PLATING","CERULEAN");
	hscr_logbook_add_card_entry("SHARED_BULWARK","CERULEAN");
	hscr_logbook_add_card_entry("SHELL_SHIELD","CERULEAN");
	hscr_logbook_add_card_entry("SNOWDRIFT","CERULEAN");
	hscr_logbook_add_card_entry("SNOWFORT","CERULEAN");

	#endregion

	//----------------//
	//UTILITY//
	//----------------//
	#region UTILITY

	hscr_logbook_add_card_entry("ABYSSAL_HARPOON","CERULEAN");
	hscr_logbook_add_card_entry("ANCHOR_STONE","CERULEAN");
	hscr_logbook_add_card_entry("ANCIENT_CHARTS","CERULEAN");
	hscr_logbook_add_card_entry("AQUA_STEP","CERULEAN");
	hscr_logbook_add_card_entry("CORAL_GUARDIAN","CERULEAN");
	hscr_logbook_add_card_entry("DEEP_REFLECTION","CERULEAN");
	hscr_logbook_add_card_entry("DEEPFLOW_WHISPERSONG","CERULEAN");
	hscr_logbook_add_card_entry("GATHERING_STORM","CERULEAN");
	hscr_logbook_add_card_entry("ICE_WALL","CERULEAN");
	hscr_logbook_add_card_entry("ICEBOUND_SEAL","CERULEAN");
	hscr_logbook_add_card_entry("MANA_SPRING","CERULEAN");
	hscr_logbook_add_card_entry("PULLED_UNDER","CERULEAN");
	hscr_logbook_add_card_entry("PURIFY_WATERS","CERULEAN");
	hscr_logbook_add_card_entry("RAIN","CERULEAN");
	hscr_logbook_add_card_entry("RIMEFROST_ELEMENTAL","CERULEAN");
	hscr_logbook_add_card_entry("RIP_CURRENT","CERULEAN");
	hscr_logbook_add_card_entry("RIPPLING_POOL","CERULEAN");
	hscr_logbook_add_card_entry("SNOWFALL","CERULEAN");
	hscr_logbook_add_card_entry("STORM_BEACON","CERULEAN");
	hscr_logbook_add_card_entry("STORM_WISP","CERULEAN");
	hscr_logbook_add_card_entry("THIN_ICE","CERULEAN");
	hscr_logbook_add_card_entry("THUNDERSTORM","CERULEAN");
	hscr_logbook_add_card_entry("TIDAL_FLOW","CERULEAN");
	hscr_logbook_add_card_entry("TIDEHEART","CERULEAN");
	hscr_logbook_add_card_entry("UNDERTOW","CERULEAN");

	#endregion

	//----------------//
	//SUPPORT//
	//----------------//
	#region SUPPORT

	hscr_logbook_add_card_entry("ARCTIC_FOCUS","CERULEAN");
	hscr_logbook_add_card_entry("BRITTLE_CONSTITUTION","CERULEAN");
	hscr_logbook_add_card_entry("CALM_SEAS","CERULEAN");
	hscr_logbook_add_card_entry("CHILLING_WEAKNESS","CERULEAN");
	hscr_logbook_add_card_entry("COOLING_MIST","CERULEAN");
	hscr_logbook_add_card_entry("CRYOGENIC_RECOVERY","CERULEAN");
	hscr_logbook_add_card_entry("DEEP_MOMENTUM","CERULEAN");
	hscr_logbook_add_card_entry("DENSE_FOG","CERULEAN");
	hscr_logbook_add_card_entry("DROP_ANCHOR","CERULEAN");
	hscr_logbook_add_card_entry("FROST_WEAPON","CERULEAN");
	hscr_logbook_add_card_entry("FROSTFORM","CERULEAN");
	hscr_logbook_add_card_entry("FROZEN_ARMOR","CERULEAN");
	hscr_logbook_add_card_entry("FROZEN_CURSE","CERULEAN");
	hscr_logbook_add_card_entry("FROZEN_PRECISION","CERULEAN");
	hscr_logbook_add_card_entry("HYPOTHERMIA","CERULEAN");
	hscr_logbook_add_card_entry("ICE_MIRROR","CERULEAN");
	hscr_logbook_add_card_entry("ICE_PRISON","CERULEAN");
	hscr_logbook_add_card_entry("ICEBOUND_INSTINCT","CERULEAN");
	hscr_logbook_add_card_entry("KRAKENS_CHOSEN","CERULEAN");
	hscr_logbook_add_card_entry("MARINE_MEND","CERULEAN");
	hscr_logbook_add_card_entry("OCEANS_BLESSING","CERULEAN");
	hscr_logbook_add_card_entry("PERMAFROST","CERULEAN");
	hscr_logbook_add_card_entry("RAZOR_SHELL","CERULEAN");
	hscr_logbook_add_card_entry("ROUGH_SEAS","CERULEAN");
	hscr_logbook_add_card_entry("SAILORS_RESOLVE","CERULEAN");
	hscr_logbook_add_card_entry("SEA_LEGS","CERULEAN");
	hscr_logbook_add_card_entry("SOOTHING_CURRENT","CERULEAN");
	hscr_logbook_add_card_entry("STATIC_BARRIER","CERULEAN");
	hscr_logbook_add_card_entry("STATIC_RESONANCE","CERULEAN");
	hscr_logbook_add_card_entry("TIDAL_RECOVERY","CERULEAN");
	hscr_logbook_add_card_entry("UNSTABLE_COIL","CERULEAN");
	hscr_logbook_add_card_entry("WHIRLPOOL","CERULEAN");
	hscr_logbook_add_card_entry("WHITEOUT","CERULEAN");

	#endregion

	//----------------//
	//ARCHETYPE//
	//----------------//
	#region ARCHETYPE

	hscr_logbook_add_card_entry("CALL_THE_DEEP","CERULEAN");
	hscr_logbook_add_card_entry("CERULEAN_GODS_WRATH","CERULEAN");
	hscr_logbook_add_card_entry("ICE_AGE","CERULEAN");
	hscr_logbook_add_card_entry("KRAKEN_AWAKENS","CERULEAN");
	hscr_logbook_add_card_entry("LEVIATHANS_BLESSING","CERULEAN");
	hscr_logbook_add_card_entry("OCEANS_EMBRACE","CERULEAN");
	hscr_logbook_add_card_entry("SHATTERSTORM","CERULEAN");
	hscr_logbook_add_card_entry("THE_ABYSS_STARES_BACK","CERULEAN");
	hscr_logbook_add_card_entry("WINTERS_HOUR","CERULEAN");
	
	#endregion

	#endregion

	#region VERMILION

	//----------------//
	//ATTACK - BASIC//
	//----------------//
	#region ATTACK_BASIC

	hscr_logbook_add_card_entry("BERSERKER_CHARGE","VERMILION");
	hscr_logbook_add_card_entry("BERSERKER_FLURRY","VERMILION");
	hscr_logbook_add_card_entry("BLOODFLAME_BOLT","VERMILION");
	hscr_logbook_add_card_entry("CINDER_SPEAR","VERMILION");
	hscr_logbook_add_card_entry("COMBUSTION","VERMILION");
	hscr_logbook_add_card_entry("EMBER_BARRAGE","VERMILION");
	hscr_logbook_add_card_entry("FIERY_BLOW","VERMILION");
	hscr_logbook_add_card_entry("FLAME_LANCE","VERMILION");
	hscr_logbook_add_card_entry("HELLFIRE_STRIKE","VERMILION");
	hscr_logbook_add_card_entry("PYROCLAST","VERMILION");
	hscr_logbook_add_card_entry("RAGING_BLOW","VERMILION");

	#endregion

	//----------------//
	//ATTACK - DOT//
	//----------------//
	#region ATTACK_DOT

	hscr_logbook_add_card_entry("BARBED_BOLT","VERMILION");
	hscr_logbook_add_card_entry("BLOODFLAME_NEEDLE","VERMILION");
	hscr_logbook_add_card_entry("EMBER_SHOT","VERMILION");
	hscr_logbook_add_card_entry("RAGING_SPARK","VERMILION");
	hscr_logbook_add_card_entry("RENDING_BLOW","VERMILION");
	hscr_logbook_add_card_entry("SCORCHING_CLAW","VERMILION");

	#endregion

	//----------------//
	//ATTACK - SPECIAL//
	//----------------//
	#region ATTACK_SPECIAL

	hscr_logbook_add_card_entry("ARTERIAL_BURST","VERMILION");
	hscr_logbook_add_card_entry("BLOOD_FURNACE","VERMILION");
	hscr_logbook_add_card_entry("BLOOD_PRICE","VERMILION");
	hscr_logbook_add_card_entry("BLOODLETTING","VERMILION");
	hscr_logbook_add_card_entry("BLOODLUST_LUNGE","VERMILION");
	hscr_logbook_add_card_entry("BLOODY_SWIPE","VERMILION");
	hscr_logbook_add_card_entry("BREAKJAW","VERMILION");
	hscr_logbook_add_card_entry("BURNING_CLEAVE","VERMILION");
	hscr_logbook_add_card_entry("BURNING_MISSILES","VERMILION");
	hscr_logbook_add_card_entry("BURSTING_METEOR","VERMILION");
	hscr_logbook_add_card_entry("CHAIN_COMBUSTION","VERMILION");
	hscr_logbook_add_card_entry("CINDER_CHASE","VERMILION");
	hscr_logbook_add_card_entry("CINDER_KICK","VERMILION");
	hscr_logbook_add_card_entry("ERUPTING_SLAM","VERMILION");
	hscr_logbook_add_card_entry("EXSANGUINATE","VERMILION");
	hscr_logbook_add_card_entry("FEED_THE_FLAME","VERMILION");
	hscr_logbook_add_card_entry("FINISHING_BLOW","VERMILION");
	hscr_logbook_add_card_entry("FIREBALL","VERMILION");
	hscr_logbook_add_card_entry("FLAME_SPOUT","VERMILION");
	hscr_logbook_add_card_entry("FLASHPOINT","VERMILION");
	hscr_logbook_add_card_entry("FORWARD_MARCH","VERMILION");
	hscr_logbook_add_card_entry("FURIOUS_SLICE","VERMILION");
	hscr_logbook_add_card_entry("HEADSMANS_DUE","VERMILION");
	hscr_logbook_add_card_entry("MELTPLATE","VERMILION");
	hscr_logbook_add_card_entry("MOLTEN_EDGE","VERMILION");
	hscr_logbook_add_card_entry("OPEN_VEIN","VERMILION");
	hscr_logbook_add_card_entry("OVERHEAT","VERMILION");
	hscr_logbook_add_card_entry("RAGEFIRE","VERMILION");
	hscr_logbook_add_card_entry("RAGEHOOK","VERMILION");
	hscr_logbook_add_card_entry("RECKLESS_ASSAULT","VERMILION");
	hscr_logbook_add_card_entry("SEARING_RAY","VERMILION");

	#endregion

	//----------------//
	//DEFENSE//
	//----------------//
	#region DEFENSE

	hscr_logbook_add_card_entry("ASHEN_FORMATION","VERMILION");
	hscr_logbook_add_card_entry("BACKDRAFT","VERMILION");
	hscr_logbook_add_card_entry("BLOOD_OATH","VERMILION");
	hscr_logbook_add_card_entry("BLOODY_SHIELD","VERMILION");
	hscr_logbook_add_card_entry("BURNING_PARRY","VERMILION");
	hscr_logbook_add_card_entry("CINDERGUARD","VERMILION");
	hscr_logbook_add_card_entry("FURNACE_HEART","VERMILION");
	hscr_logbook_add_card_entry("HARDEN_BLOOD","VERMILION");
	hscr_logbook_add_card_entry("LAST_STAND","VERMILION");
	hscr_logbook_add_card_entry("MOLTEN_AEGIS","VERMILION");
	hscr_logbook_add_card_entry("RAGEPLATE","VERMILION");

	#endregion

	//----------------//
	//UTILITY//
	//----------------//
	#region UTILITY

	hscr_logbook_add_card_entry("BATTLE_TRANCE","VERMILION");
	hscr_logbook_add_card_entry("BLOOD_OFFERING","VERMILION");
	hscr_logbook_add_card_entry("BLOOD_RUSH","VERMILION");
	hscr_logbook_add_card_entry("BLOODLINE","VERMILION");
	hscr_logbook_add_card_entry("BLOODMIST","VERMILION");
	hscr_logbook_add_card_entry("BLOODSTEP","VERMILION");
	hscr_logbook_add_card_entry("CREMATE","VERMILION");
	hscr_logbook_add_card_entry("DRAGON_MINE","VERMILION");
	hscr_logbook_add_card_entry("EMBER_TURRET","VERMILION");
	hscr_logbook_add_card_entry("FEED_THE_FURNACE","VERMILION");
	hscr_logbook_add_card_entry("FIRESTORM","VERMILION");
	hscr_logbook_add_card_entry("FLAMEFORGED","VERMILION");
	hscr_logbook_add_card_entry("FLAMESPAWN","VERMILION");
	hscr_logbook_add_card_entry("FUEL_THE_FIRE","VERMILION");
	hscr_logbook_add_card_entry("HEATWAVE","VERMILION");
	hscr_logbook_add_card_entry("LIVING_FLAME","VERMILION");
	hscr_logbook_add_card_entry("MAGMA_CANNON","VERMILION");
	hscr_logbook_add_card_entry("POWDER_KEG","VERMILION");
	hscr_logbook_add_card_entry("REKINDLE","VERMILION");
	hscr_logbook_add_card_entry("SANGUINE_SONG","VERMILION");
	hscr_logbook_add_card_entry("VOLATILE_BRAND","VERMILION");

	#endregion

	//----------------//
	//SUPPORT//
	//----------------//
	#region SUPPORT

	hscr_logbook_add_card_entry("3RD_DEGREE","VERMILION");
	hscr_logbook_add_card_entry("ANEMIA","VERMILION");
	hscr_logbook_add_card_entry("BATTLE_FRENZY","VERMILION");
	hscr_logbook_add_card_entry("BLOODCOATED","VERMILION");
	hscr_logbook_add_card_entry("BLOODHUNGER","VERMILION");
	hscr_logbook_add_card_entry("CAUTERIZED_WOUND","VERMILION");
	hscr_logbook_add_card_entry("CRIMSON_FOCUS","VERMILION");
	hscr_logbook_add_card_entry("DANCING_FLAME","VERMILION");
	hscr_logbook_add_card_entry("FLAMING_LASHES","VERMILION");
	hscr_logbook_add_card_entry("FRONTLINE_ORDER","VERMILION");
	hscr_logbook_add_card_entry("HEAT_UP","VERMILION");
	hscr_logbook_add_card_entry("HEMOPHILIA","VERMILION");
	hscr_logbook_add_card_entry("HUNGERING_FLAMES","VERMILION");
	hscr_logbook_add_card_entry("INNER_FLAME","VERMILION");
	hscr_logbook_add_card_entry("MELTING_ARMAMENTS","VERMILION");
	hscr_logbook_add_card_entry("MENACING_ROAR","VERMILION");
	hscr_logbook_add_card_entry("MOLTEN_BRAND","VERMILION");
	hscr_logbook_add_card_entry("PAIN_RESPONSE","VERMILION");
	hscr_logbook_add_card_entry("PYRE_WEAPON","VERMILION");
	hscr_logbook_add_card_entry("RAGING_HOWL","VERMILION");
	hscr_logbook_add_card_entry("RELENTLESS","VERMILION");
	hscr_logbook_add_card_entry("SECOND_WIND","VERMILION");
	hscr_logbook_add_card_entry("WAR_CRY","VERMILION");

	#endregion

	//----------------//
	//ARCHETYPE//
	//----------------//
	#region ARCHETYPE

	hscr_logbook_add_card_entry("BLOOD_MOON","VERMILION");
	hscr_logbook_add_card_entry("CATACLYSM","VERMILION");
	hscr_logbook_add_card_entry("DRAGONSTORM","VERMILION");
	hscr_logbook_add_card_entry("ENDLESS_RAGE","VERMILION");
	hscr_logbook_add_card_entry("INFERNO_ETERNAL","VERMILION");
	hscr_logbook_add_card_entry("MOLTEN_RUIN","VERMILION");
	hscr_logbook_add_card_entry("PHOENIX_REBIRTH","VERMILION");
	hscr_logbook_add_card_entry("SACRIFICIAL_PYRE","VERMILION");
	hscr_logbook_add_card_entry("THE_RED_FEAST","VERMILION");

	#endregion

	#endregion

	//================//
	//UPDATE REVISION//
	//================//
	global.ct_logbook_revision++;
}