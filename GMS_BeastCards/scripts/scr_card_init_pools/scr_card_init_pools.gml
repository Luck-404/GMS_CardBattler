//===============================================================================//
//
// SCRIPT: SCR_CARD_INIT_POOLS
// FUNCTION: Initializes the global card rarity pools.
//           Clears existing pool data before registration.
//           Adds every known card ID according to spreadsheet rarity.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_init_pools(){

	//================//
	//CLEAR OLD POOLS//
	//================//
	ds_list_clear(global.list_pool_cards_rarity_I);
	ds_list_clear(global.list_pool_cards_rarity_II);
	ds_list_clear(global.list_pool_cards_rarity_III);
	ds_list_clear(global.list_pool_cards_rarity_IV);

	//===============================================================================//
	//
	// RARITY I
	//
	//===============================================================================//
	#region I

		//================//
		//UNCOLORED//
		//================//
		#region UNCOLORED

		ds_list_add(global.list_pool_cards_rarity_I,"BLOCK");
		ds_list_add(global.list_pool_cards_rarity_I,"CLEARCAST");
		ds_list_add(global.list_pool_cards_rarity_I,"HIDDEN_CARD");
		ds_list_add(global.list_pool_cards_rarity_I,"MARKING_RUNE");
		ds_list_add(global.list_pool_cards_rarity_I,"REPOSITION");
		ds_list_add(global.list_pool_cards_rarity_I,"SOULCLEANSE");
		ds_list_add(global.list_pool_cards_rarity_I,"STRIKE");

		#endregion

		//================//
		//VIRIDIAN//
		//================//
		#region VIRIDIAN

		ds_list_add(global.list_pool_cards_rarity_I,"BARKSKIN");
		ds_list_add(global.list_pool_cards_rarity_I,"BIOBOLT");
		ds_list_add(global.list_pool_cards_rarity_I,"BLOOMING_SHIELD");
		ds_list_add(global.list_pool_cards_rarity_I,"CLAW");
		ds_list_add(global.list_pool_cards_rarity_I,"DISTRACTING_TRAP");
		ds_list_add(global.list_pool_cards_rarity_I,"EMERALD_SLAM");
		ds_list_add(global.list_pool_cards_rarity_I,"ENTANGLE");
		ds_list_add(global.list_pool_cards_rarity_I,"FERAL_FRENZY");
		ds_list_add(global.list_pool_cards_rarity_I,"GERMINATE");
		ds_list_add(global.list_pool_cards_rarity_I,"GREENSTEP");
		ds_list_add(global.list_pool_cards_rarity_I,"INTERLOCKING_SCALES");
		ds_list_add(global.list_pool_cards_rarity_I,"LIFEBLOOM");
		ds_list_add(global.list_pool_cards_rarity_I,"LIFE_SPIRIT");
		ds_list_add(global.list_pool_cards_rarity_I,"MIRACLE_MUSA");
		ds_list_add(global.list_pool_cards_rarity_I,"NATURES_BOND");
		ds_list_add(global.list_pool_cards_rarity_I,"NATURES_MEND");
		ds_list_add(global.list_pool_cards_rarity_I,"PHEROMONES");
		ds_list_add(global.list_pool_cards_rarity_I,"PREDATORY_SCENT");
		ds_list_add(global.list_pool_cards_rarity_I,"RAKE");
		ds_list_add(global.list_pool_cards_rarity_I,"ROTTING_SPORES");
		ds_list_add(global.list_pool_cards_rarity_I,"SLEEP_DART");
		ds_list_add(global.list_pool_cards_rarity_I,"SNARLING_BITE");
		ds_list_add(global.list_pool_cards_rarity_I,"SPIKE_PIERCE");
		ds_list_add(global.list_pool_cards_rarity_I,"SPINESLING");
		ds_list_add(global.list_pool_cards_rarity_I,"SPIRIT_PIERCE");
		ds_list_add(global.list_pool_cards_rarity_I,"STALKING_SWIPE");
		ds_list_add(global.list_pool_cards_rarity_I,"STEELFUR");
		ds_list_add(global.list_pool_cards_rarity_I,"THORN_NET");
		ds_list_add(global.list_pool_cards_rarity_I,"TOXIC_SNARE");
		ds_list_add(global.list_pool_cards_rarity_I,"UNSEEN_ROOT");
		ds_list_add(global.list_pool_cards_rarity_I,"VENOM_BLOOM");
		ds_list_add(global.list_pool_cards_rarity_I,"VERDANT_SWIPES");
		ds_list_add(global.list_pool_cards_rarity_I,"WILDSTRIKE");

		#endregion

		//================//
		//CERULEAN//
		//================//
		#region CERULEAN

		ds_list_add(global.list_pool_cards_rarity_I,"ABYSSAL_HARPOON");
		ds_list_add(global.list_pool_cards_rarity_I,"ABYSSAL_TOUCH");
		ds_list_add(global.list_pool_cards_rarity_I,"AQUA_STEP");
		ds_list_add(global.list_pool_cards_rarity_I,"ARMOR_TRANSFER");
		ds_list_add(global.list_pool_cards_rarity_I,"BUBBLE");
		ds_list_add(global.list_pool_cards_rarity_I,"BURST");
		ds_list_add(global.list_pool_cards_rarity_I,"FROSTBOLT");
		ds_list_add(global.list_pool_cards_rarity_I,"FROST_WEAPON");
		ds_list_add(global.list_pool_cards_rarity_I,"FROZEN_ARMOR");
		ds_list_add(global.list_pool_cards_rarity_I,"FROZEN_BULWARK");
		ds_list_add(global.list_pool_cards_rarity_I,"FROZEN_FANG");
		ds_list_add(global.list_pool_cards_rarity_I,"FROZEN_PRECISION");
		ds_list_add(global.list_pool_cards_rarity_I,"FROZEN_SPEAR");
		ds_list_add(global.list_pool_cards_rarity_I,"ICEBOUND_SEAL");
		ds_list_add(global.list_pool_cards_rarity_I,"LURKING_VISIONS");
		ds_list_add(global.list_pool_cards_rarity_I,"ICE_LANCE");
		ds_list_add(global.list_pool_cards_rarity_I,"ICE_PLATING");
		ds_list_add(global.list_pool_cards_rarity_I,"MARINE_MEND");
		ds_list_add(global.list_pool_cards_rarity_I,"PURIFY_WATERS");
		ds_list_add(global.list_pool_cards_rarity_I,"RAIN");
		ds_list_add(global.list_pool_cards_rarity_I,"RIP_CURRENT");
		ds_list_add(global.list_pool_cards_rarity_I,"SAILORS_RESOLVE");
		ds_list_add(global.list_pool_cards_rarity_I,"SEA_LEGS");
		ds_list_add(global.list_pool_cards_rarity_I,"SHELL_SHIELD");
		ds_list_add(global.list_pool_cards_rarity_I,"SNOWFALL");
		ds_list_add(global.list_pool_cards_rarity_I,"SOOTHING_CURRENT");
		ds_list_add(global.list_pool_cards_rarity_I,"STATIC_BARRIER");
		ds_list_add(global.list_pool_cards_rarity_I,"STORM_BEACON");
		ds_list_add(global.list_pool_cards_rarity_I,"THIN_ICE");
		ds_list_add(global.list_pool_cards_rarity_I,"TIDAL_SLASH");
		ds_list_add(global.list_pool_cards_rarity_I,"TORRENT");
		ds_list_add(global.list_pool_cards_rarity_I,"UNDERTOW");

		#endregion

		//================//
		//VERMILION//
		//================//
		#region VERMILION

		ds_list_add(global.list_pool_cards_rarity_I,"ANEMIA");
		ds_list_add(global.list_pool_cards_rarity_I,"BARBED_BOLT");
		ds_list_add(global.list_pool_cards_rarity_I,"BATTLE_TRANCE");
		ds_list_add(global.list_pool_cards_rarity_I,"BERSERKER_CHARGE");
		ds_list_add(global.list_pool_cards_rarity_I,"BLOOD_FEUD");
		ds_list_add(global.list_pool_cards_rarity_I,"BLOODFLAME_BOLT");
		ds_list_add(global.list_pool_cards_rarity_I,"BLOODFLAME_NEEDLE");
		ds_list_add(global.list_pool_cards_rarity_I,"BLOODSTEP");
		ds_list_add(global.list_pool_cards_rarity_I,"BLOODY_SHIELD");
		ds_list_add(global.list_pool_cards_rarity_I,"BLOODY_SWIPE");
		ds_list_add(global.list_pool_cards_rarity_I,"CINDERGUARD");
		ds_list_add(global.list_pool_cards_rarity_I,"CINDER_KICK");
		ds_list_add(global.list_pool_cards_rarity_I,"CINDER_SPEAR");
		ds_list_add(global.list_pool_cards_rarity_I,"CRIMSON_FOCUS");
		ds_list_add(global.list_pool_cards_rarity_I,"EMBER_SHOT");
		ds_list_add(global.list_pool_cards_rarity_I,"EMBER_TURRET");
		ds_list_add(global.list_pool_cards_rarity_I,"FIERY_BLOW");
		ds_list_add(global.list_pool_cards_rarity_I,"FINISHING_BLOW");
		ds_list_add(global.list_pool_cards_rarity_I,"FLAME_LANCE");
		ds_list_add(global.list_pool_cards_rarity_I,"FLASHPOINT");
		ds_list_add(global.list_pool_cards_rarity_I,"FORWARD_MARCH");
		ds_list_add(global.list_pool_cards_rarity_I,"FRONTLINE_ORDER");
		ds_list_add(global.list_pool_cards_rarity_I,"FURIOUS_SLICE");
		ds_list_add(global.list_pool_cards_rarity_I,"HARDEN_BLOOD");
		ds_list_add(global.list_pool_cards_rarity_I,"HEAT_UP");
		ds_list_add(global.list_pool_cards_rarity_I,"HELLFIRE_STRIKE");
		ds_list_add(global.list_pool_cards_rarity_I,"MOLTEN_EDGE");
		ds_list_add(global.list_pool_cards_rarity_I,"OVERHEAT");
		ds_list_add(global.list_pool_cards_rarity_I,"PAIN_RESPONSE");
		ds_list_add(global.list_pool_cards_rarity_I,"PYRE_WEAPON");
		ds_list_add(global.list_pool_cards_rarity_I,"RAGEHOOK");
		ds_list_add(global.list_pool_cards_rarity_I,"RAGING_SPARK");
		ds_list_add(global.list_pool_cards_rarity_I,"RENDING_BLOW");
		ds_list_add(global.list_pool_cards_rarity_I,"SCORCHING_CLAW");
		ds_list_add(global.list_pool_cards_rarity_I,"SEARING_RAY");

		#endregion

	#endregion

	//===============================================================================//
	//
	// RARITY II
	//
	//===============================================================================//
	#region II

		//================//
		//UNCOLORED//
		//================//
		#region UNCOLORED

		ds_list_add(global.list_pool_cards_rarity_II,"BULWARK");
		ds_list_add(global.list_pool_cards_rarity_II,"DEFT_STRIKE");
		ds_list_add(global.list_pool_cards_rarity_II,"INSPIRATION");
		ds_list_add(global.list_pool_cards_rarity_II,"POWER_STRIKE");
		ds_list_add(global.list_pool_cards_rarity_II,"RAPID_STRIKES");
		ds_list_add(global.list_pool_cards_rarity_II,"SHIV");

		#endregion

		//================//
		//VIRIDIAN//
		//================//
		#region VIRIDIAN

		ds_list_add(global.list_pool_cards_rarity_II,"BEASTIAL_WRATH");
		ds_list_add(global.list_pool_cards_rarity_II,"BLOOMING_SPRITE");
		ds_list_add(global.list_pool_cards_rarity_II,"BLOOMTIDE");
		ds_list_add(global.list_pool_cards_rarity_II,"BLOWDART");
		ds_list_add(global.list_pool_cards_rarity_II,"BRAMBLE_ERUPTION");
		ds_list_add(global.list_pool_cards_rarity_II,"BRAMBLE_HIDE");
		ds_list_add(global.list_pool_cards_rarity_II,"BURGEONING_BLOOM");
		ds_list_add(global.list_pool_cards_rarity_II,"BURSTING_SEED");
		ds_list_add(global.list_pool_cards_rarity_II,"CRIPPLING_VINES");
		ds_list_add(global.list_pool_cards_rarity_II,"DECAYING_TOUCH");
		ds_list_add(global.list_pool_cards_rarity_II,"DISEASE");
		ds_list_add(global.list_pool_cards_rarity_II,"DORMANT_SEED");
		ds_list_add(global.list_pool_cards_rarity_II,"DRAINING_KISS");
		ds_list_add(global.list_pool_cards_rarity_II,"FELL");
		ds_list_add(global.list_pool_cards_rarity_II,"GREENFLOW");
		ds_list_add(global.list_pool_cards_rarity_II,"HONEYED_SCENT");
		ds_list_add(global.list_pool_cards_rarity_II,"HUNTERS_INSTINCT");
		ds_list_add(global.list_pool_cards_rarity_II,"HUNTERS_JAVELIN");
		ds_list_add(global.list_pool_cards_rarity_II,"NATURAL_CYCLE");
		ds_list_add(global.list_pool_cards_rarity_II,"NATURAL_RECOVERY");
		ds_list_add(global.list_pool_cards_rarity_II,"NATURES_FURY");
		ds_list_add(global.list_pool_cards_rarity_II,"NATURES_WRATH");
		ds_list_add(global.list_pool_cards_rarity_II,"OLD_GROWTH_PUMMEL");
		ds_list_add(global.list_pool_cards_rarity_II,"OVERGROWTH");
		ds_list_add(global.list_pool_cards_rarity_II,"POLLINATE");
		ds_list_add(global.list_pool_cards_rarity_II,"POTENT_FRUIT");
		ds_list_add(global.list_pool_cards_rarity_II,"POTENT_SPORE");
		ds_list_add(global.list_pool_cards_rarity_II,"PREDATORS_MARK");
		ds_list_add(global.list_pool_cards_rarity_II,"PRIMAL_BLAST");
		ds_list_add(global.list_pool_cards_rarity_II,"REJUVENATE");
		ds_list_add(global.list_pool_cards_rarity_II,"RETURN_TO_NATURE");
		ds_list_add(global.list_pool_cards_rarity_II,"ROT_BLOOM");
		ds_list_add(global.list_pool_cards_rarity_II,"SAVAGE_MAUL");
		ds_list_add(global.list_pool_cards_rarity_II,"SEED_BARRAGE");
		ds_list_add(global.list_pool_cards_rarity_II,"SHIMMERING_SPORES");
		ds_list_add(global.list_pool_cards_rarity_II,"SPIRIT_FANG");
		ds_list_add(global.list_pool_cards_rarity_II,"SPIT_VENOM");
		ds_list_add(global.list_pool_cards_rarity_II,"SPORE_CLOUD");
		ds_list_add(global.list_pool_cards_rarity_II,"SYMBIOSIS");
		ds_list_add(global.list_pool_cards_rarity_II,"THICK_HIDE");
		ds_list_add(global.list_pool_cards_rarity_II,"THORNMAIL");
		ds_list_add(global.list_pool_cards_rarity_II,"TOXIC_HIDE");
		ds_list_add(global.list_pool_cards_rarity_II,"TOXIC_RECLAIMATION");
		ds_list_add(global.list_pool_cards_rarity_II,"VERDANT_BOLT");
		ds_list_add(global.list_pool_cards_rarity_II,"VERDANT_INSIGHT");
		ds_list_add(global.list_pool_cards_rarity_II,"VIRIDIAN_BURST");
		ds_list_add(global.list_pool_cards_rarity_II,"WILD_VIGOR");
		ds_list_add(global.list_pool_cards_rarity_II,"WILT");

		#endregion

		//================//
		//CERULEAN//
		//================//
		#region CERULEAN

		ds_list_add(global.list_pool_cards_rarity_II,"ANCHOR_STONE");
		ds_list_add(global.list_pool_cards_rarity_II,"ARCTIC_FOCUS");
		ds_list_add(global.list_pool_cards_rarity_II,"ARCTIC_VOLLEY");
		ds_list_add(global.list_pool_cards_rarity_II,"BITTER_CHILL");
		ds_list_add(global.list_pool_cards_rarity_II,"BRITTLE_CONSTITUTION");
		ds_list_add(global.list_pool_cards_rarity_II,"CHILLING_WEAKNESS");
		ds_list_add(global.list_pool_cards_rarity_II,"COLD_RESERVE");
		ds_list_add(global.list_pool_cards_rarity_II,"COLD_SNAP");
		ds_list_add(global.list_pool_cards_rarity_II,"COOLING_MIST");
		ds_list_add(global.list_pool_cards_rarity_II,"CORAL_GUARDIAN");
		ds_list_add(global.list_pool_cards_rarity_II,"CRASHING_WAVE");
		ds_list_add(global.list_pool_cards_rarity_II,"CRYOGENIC_RECOVERY");
		ds_list_add(global.list_pool_cards_rarity_II,"DEEP_CURRENT");
		ds_list_add(global.list_pool_cards_rarity_II,"DEEP_REFLECTION");
		ds_list_add(global.list_pool_cards_rarity_II,"DEPTH_CHARGE");
		ds_list_add(global.list_pool_cards_rarity_II,"FORCED_OVERLOAD");
		ds_list_add(global.list_pool_cards_rarity_II,"GLACIAL_CRUSH");
		ds_list_add(global.list_pool_cards_rarity_II,"HAILSTONES");
		ds_list_add(global.list_pool_cards_rarity_II,"HYPOTHERMIA");
		ds_list_add(global.list_pool_cards_rarity_II,"ICE_MIRROR");
		ds_list_add(global.list_pool_cards_rarity_II,"ICE_PRISON");
		ds_list_add(global.list_pool_cards_rarity_II,"ICE_WALL");
		ds_list_add(global.list_pool_cards_rarity_II,"MANA_SPRING");
		ds_list_add(global.list_pool_cards_rarity_II,"PERMAFROST");
		ds_list_add(global.list_pool_cards_rarity_II,"PRESSURE_CRUSH");
		ds_list_add(global.list_pool_cards_rarity_II,"PRESSURE_SPIKE");
		ds_list_add(global.list_pool_cards_rarity_II,"RAZOR_FIN");
		ds_list_add(global.list_pool_cards_rarity_II,"RAZOR_SHELL");
		ds_list_add(global.list_pool_cards_rarity_II,"RIPPLING_POOL");
		ds_list_add(global.list_pool_cards_rarity_II,"SHARED_BULWARK");
		ds_list_add(global.list_pool_cards_rarity_II,"SHATTER_STRIKE");
		ds_list_add(global.list_pool_cards_rarity_II,"SNOWDRIFT");
		ds_list_add(global.list_pool_cards_rarity_II,"SNOWFORT");
		ds_list_add(global.list_pool_cards_rarity_II,"STATIC_RESONANCE");
		ds_list_add(global.list_pool_cards_rarity_II,"STORM_WISP");
		ds_list_add(global.list_pool_cards_rarity_II,"THUNDERCLAP");
		ds_list_add(global.list_pool_cards_rarity_II,"THUNDERSTORM");
		ds_list_add(global.list_pool_cards_rarity_II,"TIDAL_FLOW");
		ds_list_add(global.list_pool_cards_rarity_II,"TIDAL_RECOVERY");
		ds_list_add(global.list_pool_cards_rarity_II,"WHITEOUT");
		ds_list_add(global.list_pool_cards_rarity_II,"WHITEWATER");
		ds_list_add(global.list_pool_cards_rarity_II,"WHIRLPOOL");

		#endregion

		//================//
		//VERMILION//
		//================//
		#region VERMILION

		ds_list_add(global.list_pool_cards_rarity_II,"ARTERIAL_BURST");
		ds_list_add(global.list_pool_cards_rarity_II,"BACKDRAFT");
		ds_list_add(global.list_pool_cards_rarity_II,"BATTLE_FRENZY");
		ds_list_add(global.list_pool_cards_rarity_II,"BERSERKER_FLURRY");
		ds_list_add(global.list_pool_cards_rarity_II,"BLOODCOATED");
		ds_list_add(global.list_pool_cards_rarity_II,"BLOOD_FURNACE");
		ds_list_add(global.list_pool_cards_rarity_II,"BLOOD_OATH");
		ds_list_add(global.list_pool_cards_rarity_II,"BLOOD_OFFERING");
		ds_list_add(global.list_pool_cards_rarity_II,"BLOOD_PRICE");
		ds_list_add(global.list_pool_cards_rarity_II,"BLOOD_RUSH");
		ds_list_add(global.list_pool_cards_rarity_II,"BLOODHUNGER");
		ds_list_add(global.list_pool_cards_rarity_II,"BLOODLETTING");
		ds_list_add(global.list_pool_cards_rarity_II,"BLOODLINE");
		ds_list_add(global.list_pool_cards_rarity_II,"BLOODMIST");
		ds_list_add(global.list_pool_cards_rarity_II,"BLOODLUST_LUNGE");
		ds_list_add(global.list_pool_cards_rarity_II,"BREAKJAW");
		ds_list_add(global.list_pool_cards_rarity_II,"BURNING_CLEAVE");
		ds_list_add(global.list_pool_cards_rarity_II,"BURNING_MISSILES");
		ds_list_add(global.list_pool_cards_rarity_II,"BURNING_PARRY");
		ds_list_add(global.list_pool_cards_rarity_II,"CAUTERIZED_WOUND");
		ds_list_add(global.list_pool_cards_rarity_II,"CINDER_CHASE");
		ds_list_add(global.list_pool_cards_rarity_II,"COMBUSTION");
		ds_list_add(global.list_pool_cards_rarity_II,"CREMATE");
		ds_list_add(global.list_pool_cards_rarity_II,"DANCING_FLAME");
		ds_list_add(global.list_pool_cards_rarity_II,"DRAGON_MINE");
		ds_list_add(global.list_pool_cards_rarity_II,"EMBER_BARRAGE");
		ds_list_add(global.list_pool_cards_rarity_II,"ERUPTING_SLAM");
		ds_list_add(global.list_pool_cards_rarity_II,"FEED_THE_FURNACE");
		ds_list_add(global.list_pool_cards_rarity_II,"FLAME_SPOUT");
		ds_list_add(global.list_pool_cards_rarity_II,"FLAMEFORGED");
		ds_list_add(global.list_pool_cards_rarity_II,"FLAMING_LASHES");
		ds_list_add(global.list_pool_cards_rarity_II,"FUEL_THE_FIRE");
		ds_list_add(global.list_pool_cards_rarity_II,"HEADSMANS_DUE");
		ds_list_add(global.list_pool_cards_rarity_II,"HEATWAVE");
		ds_list_add(global.list_pool_cards_rarity_II,"HEMOPHILIA");
		ds_list_add(global.list_pool_cards_rarity_II,"LIVING_FLAME");
		ds_list_add(global.list_pool_cards_rarity_II,"MELTING_ARMAMENTS");
		ds_list_add(global.list_pool_cards_rarity_II,"MOLTEN_AEGIS");
		ds_list_add(global.list_pool_cards_rarity_II,"MOLTEN_BRAND");
		ds_list_add(global.list_pool_cards_rarity_II,"POWDER_KEG");
		ds_list_add(global.list_pool_cards_rarity_II,"PYROCLAST");
		ds_list_add(global.list_pool_cards_rarity_II,"RAGEPLATE");
		ds_list_add(global.list_pool_cards_rarity_II,"RAGING_BLOW");
		ds_list_add(global.list_pool_cards_rarity_II,"RECKLESS_ASSAULT");

		#endregion

	#endregion

	//===============================================================================//
	//
	// RARITY III
	//
	//===============================================================================//
	#region III

		//================//
		//UNCOLORED//
		//================//
		#region UNCOLORED

		ds_list_add(global.list_pool_cards_rarity_III,"MALLEABILITY");
		ds_list_add(global.list_pool_cards_rarity_III,"SPELLBOOK_WILDCARD");

		#endregion

		//================//
		//VIRIDIAN//
		//================//
		#region VIRIDIAN

		ds_list_add(global.list_pool_cards_rarity_III,"BIOSTORM");
		ds_list_add(global.list_pool_cards_rarity_III,"CULTIVATE");
		ds_list_add(global.list_pool_cards_rarity_III,"CURE_ALL");
		ds_list_add(global.list_pool_cards_rarity_III,"EMERALD_WISDOM");
		ds_list_add(global.list_pool_cards_rarity_III,"FUNGAL_RECYCLING");
		ds_list_add(global.list_pool_cards_rarity_III,"GROWTH_SIGIL");
		ds_list_add(global.list_pool_cards_rarity_III,"MANAVINE");
		ds_list_add(global.list_pool_cards_rarity_III,"NATURES_GRACE");
		ds_list_add(global.list_pool_cards_rarity_III,"PACK_INSTINCT");
		ds_list_add(global.list_pool_cards_rarity_III,"REGENERATE");
		ds_list_add(global.list_pool_cards_rarity_III,"ROOTED_DEFENSE");
		ds_list_add(global.list_pool_cards_rarity_III,"SAPSPRING");
		ds_list_add(global.list_pool_cards_rarity_III,"SECOND_BLOOM");
		ds_list_add(global.list_pool_cards_rarity_III,"SEED_THE_FIELD");
		ds_list_add(global.list_pool_cards_rarity_III,"SERPENT_SUMMON");
		ds_list_add(global.list_pool_cards_rarity_III,"SINEWY_VINES");
		ds_list_add(global.list_pool_cards_rarity_III,"SLEEPING_POLLEN");
		ds_list_add(global.list_pool_cards_rarity_III,"STAMPEDE");
		ds_list_add(global.list_pool_cards_rarity_III,"THORN_STORM");
		ds_list_add(global.list_pool_cards_rarity_III,"TOXIC_ERUPTION");
		ds_list_add(global.list_pool_cards_rarity_III,"VERDANT_EMBRACE");
		ds_list_add(global.list_pool_cards_rarity_III,"VIRAL_SURGE");
		ds_list_add(global.list_pool_cards_rarity_III,"WILDWARD");

		#endregion

		//================//
		//CERULEAN//
		//================//
		#region CERULEAN

		ds_list_add(global.list_pool_cards_rarity_III,"ABSOLUTE_ZERO");
		ds_list_add(global.list_pool_cards_rarity_III,"ANCIENT_CHARTS");
		ds_list_add(global.list_pool_cards_rarity_III,"AVALANCHE_STRIKE");
		ds_list_add(global.list_pool_cards_rarity_III,"CALM_SEAS");
		ds_list_add(global.list_pool_cards_rarity_III,"CHILLING_WORD");
		ds_list_add(global.list_pool_cards_rarity_III,"CRYSTAL_SHELL");
		ds_list_add(global.list_pool_cards_rarity_III,"DEEP_MOMENTUM");
		ds_list_add(global.list_pool_cards_rarity_III,"DEEPFLOW_WHISPERSONG");
		ds_list_add(global.list_pool_cards_rarity_III,"DENSE_FOG");
		ds_list_add(global.list_pool_cards_rarity_III,"DROP_ANCHOR");
		ds_list_add(global.list_pool_cards_rarity_III,"FRACTURE");
		ds_list_add(global.list_pool_cards_rarity_III,"FROSTBURN_NOVA");
		ds_list_add(global.list_pool_cards_rarity_III,"FROSTFORM");
		ds_list_add(global.list_pool_cards_rarity_III,"FROZEN_BASTION");
		ds_list_add(global.list_pool_cards_rarity_III,"FROZEN_CURSE");
		ds_list_add(global.list_pool_cards_rarity_III,"GATHERING_STORM");
		ds_list_add(global.list_pool_cards_rarity_III,"GLACIAL_ERUPTION");
		ds_list_add(global.list_pool_cards_rarity_III,"ICE_ACCRETION");
		ds_list_add(global.list_pool_cards_rarity_III,"ICEBOUND_INSTINCT");
		ds_list_add(global.list_pool_cards_rarity_III,"KRAKENSLAM");
		ds_list_add(global.list_pool_cards_rarity_III,"KRAKENS_CHOSEN");
		ds_list_add(global.list_pool_cards_rarity_III,"OCEANS_BLESSING");
		ds_list_add(global.list_pool_cards_rarity_III,"PULLED_UNDER");
		ds_list_add(global.list_pool_cards_rarity_III,"RIMEFROST_ELEMENTAL");
		ds_list_add(global.list_pool_cards_rarity_III,"ROUGH_SEAS");
		ds_list_add(global.list_pool_cards_rarity_III,"TIDAL_BREAK");
		ds_list_add(global.list_pool_cards_rarity_III,"UNSTABLE_COIL");
		ds_list_add(global.list_pool_cards_rarity_III,"WINTER_RESONANCE");
		ds_list_add(global.list_pool_cards_rarity_III,"WINTERS_BITE");

		#endregion

		//================//
		//VERMILION//
		//================//
		#region VERMILION

		ds_list_add(global.list_pool_cards_rarity_III,"3RD_DEGREE");
		ds_list_add(global.list_pool_cards_rarity_III,"ASHEN_FORMATION");
		ds_list_add(global.list_pool_cards_rarity_III,"BURSTING_METEOR");
		ds_list_add(global.list_pool_cards_rarity_III,"CHAIN_COMBUSTION");
		ds_list_add(global.list_pool_cards_rarity_III,"EXSANGUINATE");
		ds_list_add(global.list_pool_cards_rarity_III,"FEED_THE_FLAME");
		ds_list_add(global.list_pool_cards_rarity_III,"FIREBALL");
		ds_list_add(global.list_pool_cards_rarity_III,"FLAMESPAWN");
		ds_list_add(global.list_pool_cards_rarity_III,"FURNACE_HEART");
		ds_list_add(global.list_pool_cards_rarity_III,"HUNGERING_FLAMES");
		ds_list_add(global.list_pool_cards_rarity_III,"INNER_FLAME");
		ds_list_add(global.list_pool_cards_rarity_III,"LAST_STAND");
		ds_list_add(global.list_pool_cards_rarity_III,"MAGMA_CANNON");
		ds_list_add(global.list_pool_cards_rarity_III,"MENACING_ROAR");
		ds_list_add(global.list_pool_cards_rarity_III,"RAGEFIRE");
		ds_list_add(global.list_pool_cards_rarity_III,"RAGING_HOWL");
		ds_list_add(global.list_pool_cards_rarity_III,"REKINDLE");
		ds_list_add(global.list_pool_cards_rarity_III,"RELENTLESS");
		ds_list_add(global.list_pool_cards_rarity_III,"SECOND_WIND");
		ds_list_add(global.list_pool_cards_rarity_III,"VOLATILE_BRAND");
		ds_list_add(global.list_pool_cards_rarity_III,"WAR_CRY");

		#endregion

	#endregion

	//===============================================================================//
	//
	// RARITY IV
	//
	//===============================================================================//
	#region IV

		//================//
		//UNCOLORED//
		//================//
		#region UNCOLORED

		ds_list_add(global.list_pool_cards_rarity_IV,"ARTIFACT_HOURGLASS");
		ds_list_add(global.list_pool_cards_rarity_IV,"ECHO");
		ds_list_add(global.list_pool_cards_rarity_IV,"THOUGHTSTEAL");

		#endregion

		//================//
		//VIRIDIAN//
		//================//
		#region VIRIDIAN

		ds_list_add(global.list_pool_cards_rarity_IV,"ANCIENT_GROVE");
		ds_list_add(global.list_pool_cards_rarity_IV,"APEX_PREDATOR");
		ds_list_add(global.list_pool_cards_rarity_IV,"CHANNEL_THE_SPIRITS");
		ds_list_add(global.list_pool_cards_rarity_IV,"CIRCLE_OF_LIFE");
		ds_list_add(global.list_pool_cards_rarity_IV,"ENDLESS_BLOOM");
		ds_list_add(global.list_pool_cards_rarity_IV,"FOR_THE_THROAT");
		ds_list_add(global.list_pool_cards_rarity_IV,"HEART_OF_THE_FOREST");
		ds_list_add(global.list_pool_cards_rarity_IV,"PLAGUE_GARDEN");
		ds_list_add(global.list_pool_cards_rarity_IV,"PROLIFERATE");
		ds_list_add(global.list_pool_cards_rarity_IV,"TRANQUILITY");

		#endregion

		//================//
		//CERULEAN//
		//================//
		#region CERULEAN

		ds_list_add(global.list_pool_cards_rarity_IV,"CALL_THE_DEEP");
		ds_list_add(global.list_pool_cards_rarity_IV,"CERULEAN_GODS_WRATH");
		ds_list_add(global.list_pool_cards_rarity_IV,"ICE_AGE");
		ds_list_add(global.list_pool_cards_rarity_IV,"KRAKEN_AWAKENS");
		ds_list_add(global.list_pool_cards_rarity_IV,"LEVIATHANS_BLESSING");
		ds_list_add(global.list_pool_cards_rarity_IV,"OCEANS_EMBRACE");
		ds_list_add(global.list_pool_cards_rarity_IV,"SHATTERSTORM");
		ds_list_add(global.list_pool_cards_rarity_IV,"THE_ABYSS_STARES_BACK");
		ds_list_add(global.list_pool_cards_rarity_IV,"TIDEHEART");
		ds_list_add(global.list_pool_cards_rarity_IV,"WINTERS_HOUR");

		#endregion

		//================//
		//VERMILION//
		//================//
		#region VERMILION

		ds_list_add(global.list_pool_cards_rarity_IV,"BLOOD_MOON");
		ds_list_add(global.list_pool_cards_rarity_IV,"CATACLYSM");
		ds_list_add(global.list_pool_cards_rarity_IV,"DRAGONSTORM");
		ds_list_add(global.list_pool_cards_rarity_IV,"ENDLESS_RAGE");
		ds_list_add(global.list_pool_cards_rarity_IV,"INFERNO_ETERNAL");
		ds_list_add(global.list_pool_cards_rarity_IV,"MOLTEN_RUIN");
		ds_list_add(global.list_pool_cards_rarity_IV,"PHOENIX_REBIRTH");
		ds_list_add(global.list_pool_cards_rarity_IV,"SACRIFICIAL_PYRE");
		ds_list_add(global.list_pool_cards_rarity_IV,"SANGUINE_SONG");
		ds_list_add(global.list_pool_cards_rarity_IV,"THE_RED_FEAST");

		#endregion

	#endregion
}