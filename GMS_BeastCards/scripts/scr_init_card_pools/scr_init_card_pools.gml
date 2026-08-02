//===============================================================================//
//
// SCRIPT: SCR_INIT_CARD_POOLS
// FUNCTION: Initializes the global card rarity pools.
//           Clears existing pool data before registration.
//           Adds every implemented card ID according to scr_get_card_info rarity.
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

		//--------//
		//VIRIDIAN//
		//--------//
		ds_list_add(global.list_pool_cards_rarity_I,"BARKSKIN");
		ds_list_add(global.list_pool_cards_rarity_I,"BIOBOLT");
		ds_list_add(global.list_pool_cards_rarity_I,"BLOOMING_SHIELD");
		ds_list_add(global.list_pool_cards_rarity_I,"CLAW");
		ds_list_add(global.list_pool_cards_rarity_I,"EMERALD_SLAM");
		ds_list_add(global.list_pool_cards_rarity_I,"FERAL_FRENZY");
		ds_list_add(global.list_pool_cards_rarity_I,"INTERLOCKING_SCALES");
		ds_list_add(global.list_pool_cards_rarity_I,"RAKE");
		ds_list_add(global.list_pool_cards_rarity_I,"SINEWY_VINES");
		ds_list_add(global.list_pool_cards_rarity_I,"SNARLING_BITE");
		ds_list_add(global.list_pool_cards_rarity_I,"SPINESLING");
		ds_list_add(global.list_pool_cards_rarity_I,"SPIKE_PIERCE");
		ds_list_add(global.list_pool_cards_rarity_I,"SPIRIT_PIERCE");
		ds_list_add(global.list_pool_cards_rarity_I,"STALKING_SWIPE");
		ds_list_add(global.list_pool_cards_rarity_I,"UNSEEN_ROOT");
		ds_list_add(global.list_pool_cards_rarity_I,"VERDANT_BOLT");
		ds_list_add(global.list_pool_cards_rarity_I,"VERDANT_SWIPES");
		ds_list_add(global.list_pool_cards_rarity_I,"WILDSTRIKE");

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
		ds_list_add(global.list_pool_cards_rarity_II,"BEASTIAL_WRATH");
		ds_list_add(global.list_pool_cards_rarity_II,"BLOWDART");
		ds_list_add(global.list_pool_cards_rarity_II,"BRAMBLE_ERUPTION");
		ds_list_add(global.list_pool_cards_rarity_II,"DISEASE");
		ds_list_add(global.list_pool_cards_rarity_II,"FELL");
		ds_list_add(global.list_pool_cards_rarity_II,"GREENFLOW");
		ds_list_add(global.list_pool_cards_rarity_II,"HUNTERS_INSTINCT");
		ds_list_add(global.list_pool_cards_rarity_II,"HUNTERS_JAVELIN");
		ds_list_add(global.list_pool_cards_rarity_II,"LIFE_SPIRIT");
		ds_list_add(global.list_pool_cards_rarity_II,"MIRACLE_MUSA");
		ds_list_add(global.list_pool_cards_rarity_II,"NATURAL_RECOVERY");
		ds_list_add(global.list_pool_cards_rarity_II,"NATURES_FURY");
		ds_list_add(global.list_pool_cards_rarity_II,"NATURES_WRATH");
		ds_list_add(global.list_pool_cards_rarity_II,"OLD_GROWTH_PUMMEL");
		ds_list_add(global.list_pool_cards_rarity_II,"OVERGROWTH");
		ds_list_add(global.list_pool_cards_rarity_II,"POTENT_SPORE");
		ds_list_add(global.list_pool_cards_rarity_II,"PRIMAL_BLAST");
		ds_list_add(global.list_pool_cards_rarity_II,"ROT_BLOOM");
		ds_list_add(global.list_pool_cards_rarity_II,"SAVAGE_MAUL");
		ds_list_add(global.list_pool_cards_rarity_II,"SEED_BARRAGE");
		ds_list_add(global.list_pool_cards_rarity_II,"SPIRIT_FANG");
		ds_list_add(global.list_pool_cards_rarity_II,"SPIT_VENOM");
		ds_list_add(global.list_pool_cards_rarity_II,"SPORE_CLOUD");
		ds_list_add(global.list_pool_cards_rarity_II,"SYMBIOSIS");
		ds_list_add(global.list_pool_cards_rarity_II,"THICK_HIDE");
		ds_list_add(global.list_pool_cards_rarity_II,"THORNMAIL");
		ds_list_add(global.list_pool_cards_rarity_II,"VIRIDIAN_BURST");

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
		ds_list_add(global.list_pool_cards_rarity_III,"EMERALD_WISDOM");
		ds_list_add(global.list_pool_cards_rarity_III,"GROWTH_SIGIL");
		ds_list_add(global.list_pool_cards_rarity_III,"NATURES_GRACE");
		ds_list_add(global.list_pool_cards_rarity_III,"REGENERATE");
		ds_list_add(global.list_pool_cards_rarity_III,"ROOTED_DEFENSE");
		ds_list_add(global.list_pool_cards_rarity_III,"SECOND_BLOOM");
		ds_list_add(global.list_pool_cards_rarity_III,"STAMPEDE");
		ds_list_add(global.list_pool_cards_rarity_III,"STEELFUR");
		ds_list_add(global.list_pool_cards_rarity_III,"THORN_STORM");
		ds_list_add(global.list_pool_cards_rarity_III,"TOXIC_ERUPTION");
		ds_list_add(global.list_pool_cards_rarity_III,"VIRAL_SURGE");
		ds_list_add(global.list_pool_cards_rarity_III,"WILDWARD");

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
		ds_list_add(global.list_pool_cards_rarity_III,"ARTIFACT_HOURGLASS");
		ds_list_add(global.list_pool_cards_rarity_III,"ECHO");
		ds_list_add(global.list_pool_cards_rarity_II,"THOUGHTSTEAL");
		
	#endregion
}