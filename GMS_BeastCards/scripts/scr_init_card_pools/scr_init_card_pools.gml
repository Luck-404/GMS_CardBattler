//===============================================================================//
//
// SCRIPT: SCR_INIT_CARD_POOLS
// FUNCTION: Initializes the global card rarity pools.
//           Clears existing pool data before registration.
//           Adds every implemented card ID according to card rarity.
//
//===============================================================================//
function scr_init_card_pools(){

	//----------------//
	//CLEAR OLD POOLS//
	//----------------//
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

		//---------//
		//UNCOLORED//
		//---------//
		ds_list_add(global.list_pool_cards_rarity_I,"BLOCK");
		ds_list_add(global.list_pool_cards_rarity_I,"CLEARCAST");
		ds_list_add(global.list_pool_cards_rarity_I,"HIDDEN_CARD");
		ds_list_add(global.list_pool_cards_rarity_I,"REPOSITION");
		ds_list_add(global.list_pool_cards_rarity_I,"STRIKE");
		ds_list_add(global.list_pool_cards_rarity_I,"SOULCLEANSE");

		//--------//
		//VIRIDIAN//
		//--------//
		ds_list_add(global.list_pool_cards_rarity_I,"BIOBOLT");
		ds_list_add(global.list_pool_cards_rarity_I,"CLAW");
		ds_list_add(global.list_pool_cards_rarity_I,"FERAL_FRENZY");
		ds_list_add(global.list_pool_cards_rarity_I,"SPIKE_PIERCE");
		ds_list_add(global.list_pool_cards_rarity_I,"SPINESLING");
		ds_list_add(global.list_pool_cards_rarity_I,"SPIRIT_PIERCE");
		ds_list_add(global.list_pool_cards_rarity_I,"STALKING_SWIPE");
		ds_list_add(global.list_pool_cards_rarity_I,"UNSEEN_ROOT");
		ds_list_add(global.list_pool_cards_rarity_I,"VERDANT_SWIPES");
		ds_list_add(global.list_pool_cards_rarity_I,"WILDSTRIKE");
		ds_list_add(global.list_pool_cards_rarity_I,"SNARLING_BITE");

		ds_list_add(global.list_pool_cards_rarity_I,"RAKE");

		ds_list_add(global.list_pool_cards_rarity_I,"BARKSKIN");
		ds_list_add(global.list_pool_cards_rarity_I,"BLOOMING_SHIELD");
		ds_list_add(global.list_pool_cards_rarity_I,"INTERLOCKING_SCALES");
		ds_list_add(global.list_pool_cards_rarity_I,"STEELFUR");

		ds_list_add(global.list_pool_cards_rarity_I,"DISTRACTING_TRAP");
		ds_list_add(global.list_pool_cards_rarity_I,"GERMINATE");
		ds_list_add(global.list_pool_cards_rarity_I,"GREENSTEP");
		ds_list_add(global.list_pool_cards_rarity_I,"LIFE_SPIRIT");
		ds_list_add(global.list_pool_cards_rarity_I,"PHEROMONES");
		ds_list_add(global.list_pool_cards_rarity_I,"ROTTING_SPORES");
		ds_list_add(global.list_pool_cards_rarity_I,"THORN_NET");
		ds_list_add(global.list_pool_cards_rarity_I,"TOXIC_SNARE");
		ds_list_add(global.list_pool_cards_rarity_I,"VENOM_BLOOM");

		ds_list_add(global.list_pool_cards_rarity_I,"EMERALD_SLAM");
		ds_list_add(global.list_pool_cards_rarity_I,"ENTANGLE");
		ds_list_add(global.list_pool_cards_rarity_I,"LIFEBLOOM");
		ds_list_add(global.list_pool_cards_rarity_I,"MIRACLE_MUSA");
		ds_list_add(global.list_pool_cards_rarity_I,"NATURES_BOND");
		ds_list_add(global.list_pool_cards_rarity_I,"NATURES_MEND");
		ds_list_add(global.list_pool_cards_rarity_I,"PREDATORY_SCENT");
		ds_list_add(global.list_pool_cards_rarity_I,"SLEEP_DART");

	#endregion


	//===============================================================================//
	//
	// RARITY II
	//
	//===============================================================================//
	#region II

		//---------//
		//UNCOLORED//
		//---------//
		ds_list_add(global.list_pool_cards_rarity_II,"BULWARK");
		ds_list_add(global.list_pool_cards_rarity_II,"DEFT_STRIKE");
		ds_list_add(global.list_pool_cards_rarity_II,"INSPIRATION");
		ds_list_add(global.list_pool_cards_rarity_II,"POWER_STRIKE");
		ds_list_add(global.list_pool_cards_rarity_II,"RAPID_STRIKES");
		ds_list_add(global.list_pool_cards_rarity_II,"SHIV");

		//--------//
		//VIRIDIAN//
		//--------//
		ds_list_add(global.list_pool_cards_rarity_II,"BRAMBLE_ERUPTION");
		ds_list_add(global.list_pool_cards_rarity_II,"FELL");
		ds_list_add(global.list_pool_cards_rarity_II,"HUNTERS_JAVELIN");
		ds_list_add(global.list_pool_cards_rarity_II,"NATURES_FURY");
		ds_list_add(global.list_pool_cards_rarity_II,"PRIMAL_BLAST");
		ds_list_add(global.list_pool_cards_rarity_II,"SAVAGE_MAUL");
		ds_list_add(global.list_pool_cards_rarity_II,"SPORE_CLOUD");

		ds_list_add(global.list_pool_cards_rarity_II,"BEASTIAL_WRATH");
		ds_list_add(global.list_pool_cards_rarity_II,"GREENFLOW");
		ds_list_add(global.list_pool_cards_rarity_II,"HUNTERS_INSTINCT");
		ds_list_add(global.list_pool_cards_rarity_II,"NATURES_WRATH");
		ds_list_add(global.list_pool_cards_rarity_II,"OLD_GROWTH_PUMMEL");
		ds_list_add(global.list_pool_cards_rarity_II,"ROT_BLOOM");
		ds_list_add(global.list_pool_cards_rarity_II,"SEED_BARRAGE");
		ds_list_add(global.list_pool_cards_rarity_II,"VERDANT_BOLT");
		ds_list_add(global.list_pool_cards_rarity_II,"VIRIDIAN_BURST");

		ds_list_add(global.list_pool_cards_rarity_II,"BLOWDART");
		ds_list_add(global.list_pool_cards_rarity_II,"POTENT_SPORE");
		ds_list_add(global.list_pool_cards_rarity_II,"SPIRIT_FANG");
		ds_list_add(global.list_pool_cards_rarity_II,"SPIT_VENOM");

		ds_list_add(global.list_pool_cards_rarity_II,"NATURAL_RECOVERY");
		ds_list_add(global.list_pool_cards_rarity_II,"OVERGROWTH");
		ds_list_add(global.list_pool_cards_rarity_II,"SYMBIOSIS");
		ds_list_add(global.list_pool_cards_rarity_II,"THICK_HIDE");
		ds_list_add(global.list_pool_cards_rarity_II,"THORNMAIL");

		ds_list_add(global.list_pool_cards_rarity_II,"BLOOMING_SPRITE");
		ds_list_add(global.list_pool_cards_rarity_II,"BLOOMTIDE");
		ds_list_add(global.list_pool_cards_rarity_II,"DORMANT_SEED");
		ds_list_add(global.list_pool_cards_rarity_II,"NATURAL_CYCLE");
		ds_list_add(global.list_pool_cards_rarity_II,"RETURN_TO_NATURE");

		ds_list_add(global.list_pool_cards_rarity_II,"BRAMBLE_HIDE");
		ds_list_add(global.list_pool_cards_rarity_II,"BURGEONING_BLOOM");
		ds_list_add(global.list_pool_cards_rarity_II,"BURSTING_SEED");
		ds_list_add(global.list_pool_cards_rarity_II,"CRIPPLING_VINES");
		ds_list_add(global.list_pool_cards_rarity_II,"DECAYING_TOUCH");
		ds_list_add(global.list_pool_cards_rarity_II,"DISEASE");
		ds_list_add(global.list_pool_cards_rarity_II,"DRAINING_KISS");
		ds_list_add(global.list_pool_cards_rarity_II,"HONEYED_SCENT");
		ds_list_add(global.list_pool_cards_rarity_II,"POLLINATE");
		ds_list_add(global.list_pool_cards_rarity_II,"POTENT_FRUIT");
		ds_list_add(global.list_pool_cards_rarity_II,"PREDATORS_MARK");
		ds_list_add(global.list_pool_cards_rarity_II,"REJUVENATE");
		ds_list_add(global.list_pool_cards_rarity_II,"SHIMMERING_SPORES");
		ds_list_add(global.list_pool_cards_rarity_II,"TOXIC_HIDE");
		ds_list_add(global.list_pool_cards_rarity_II,"VERDANT_INSIGHT");
		ds_list_add(global.list_pool_cards_rarity_II,"WILD_VIGOR");
		ds_list_add(global.list_pool_cards_rarity_II,"WILT");

	#endregion


	//===============================================================================//
	//
	// RARITY III
	//
	//===============================================================================//
	#region III

		//---------//
		//UNCOLORED//
		//---------//
		ds_list_add(global.list_pool_cards_rarity_III,"MALLEABILITY");
		ds_list_add(global.list_pool_cards_rarity_III,"SPELLBOOK_WILDCARD");

		//--------//
		//VIRIDIAN//
		//--------//
		ds_list_add(global.list_pool_cards_rarity_III,"BIOSTORM");
		ds_list_add(global.list_pool_cards_rarity_III,"STAMPEDE");
		ds_list_add(global.list_pool_cards_rarity_III,"THORN_STORM");
		ds_list_add(global.list_pool_cards_rarity_III,"TOXIC_ERUPTION");

		ds_list_add(global.list_pool_cards_rarity_III,"VIRAL_SURGE");

		ds_list_add(global.list_pool_cards_rarity_III,"NATURES_GRACE");
		ds_list_add(global.list_pool_cards_rarity_III,"REGENERATE");
		ds_list_add(global.list_pool_cards_rarity_III,"ROOTED_DEFENSE");
		ds_list_add(global.list_pool_cards_rarity_III,"SECOND_BLOOM");
		ds_list_add(global.list_pool_cards_rarity_III,"SINEWY_VINES");
		ds_list_add(global.list_pool_cards_rarity_III,"WILDWARD");

		ds_list_add(global.list_pool_cards_rarity_III,"EMERALD_WISDOM");
		ds_list_add(global.list_pool_cards_rarity_III,"FUNGAL_RECYCLING");
		ds_list_add(global.list_pool_cards_rarity_III,"GROWTH_SIGIL");
		ds_list_add(global.list_pool_cards_rarity_III,"MANAVINE");
		ds_list_add(global.list_pool_cards_rarity_III,"SEED_THE_FIELD");
		ds_list_add(global.list_pool_cards_rarity_III,"SERPENT_SUMMON");

		ds_list_add(global.list_pool_cards_rarity_III,"CULTIVATE");
		ds_list_add(global.list_pool_cards_rarity_III,"CURE_ALL");
		ds_list_add(global.list_pool_cards_rarity_III,"PACK_INSTINCT");
		ds_list_add(global.list_pool_cards_rarity_III,"SAPSPRING");
		ds_list_add(global.list_pool_cards_rarity_III,"SLEEPING_POLLEN");
		ds_list_add(global.list_pool_cards_rarity_III,"VERDANT_EMBRACE");

	#endregion


	//===============================================================================//
	//
	// RARITY IV
	//
	//===============================================================================//
	#region IV

		//---------//
		//UNCOLORED//
		//---------//
		ds_list_add(global.list_pool_cards_rarity_IV,"ARTIFACT_HOURGLASS");
		ds_list_add(global.list_pool_cards_rarity_IV,"ECHO");
		ds_list_add(global.list_pool_cards_rarity_IV,"THOUGHTSTEAL");

		//--------//
		//VIRIDIAN//
		//--------//
		ds_list_add(global.list_pool_cards_rarity_IV,"TRANQUILITY");

		//----------//
		//ARCHETYPES//
		//----------//
		ds_list_add(global.list_pool_cards_rarity_IV,"ANCIENT_GROVE");
		ds_list_add(global.list_pool_cards_rarity_IV,"APEX_PREDATOR");
		ds_list_add(global.list_pool_cards_rarity_IV,"CHANNEL_THE_SPIRITS");
		ds_list_add(global.list_pool_cards_rarity_IV,"CIRCLE_OF_LIFE");
		ds_list_add(global.list_pool_cards_rarity_IV,"ENDLESS_BLOOM");
		ds_list_add(global.list_pool_cards_rarity_IV,"FOR_THE_THROAT");
		ds_list_add(global.list_pool_cards_rarity_IV,"HEART_OF_THE_FOREST");
		ds_list_add(global.list_pool_cards_rarity_IV,"PLAGUE_GARDEN");
		ds_list_add(global.list_pool_cards_rarity_IV,"PROLIFERATE");

	#endregion
}