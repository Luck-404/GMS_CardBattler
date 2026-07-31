//===============================================================================//
//
// SCRIPT: scr_init_card_pools
// FUNCTION: Initializes the global card rarity pools.
// Adds each card ID to its appropriate rarity pool.
// Used for random card generation and loot rewards.
//
//===============================================================================//
function scr_init_card_pools(){
	#region I
		ds_list_add(global.list_pool_cards_rarity_I,"STRIKE");
		ds_list_add(global.list_pool_cards_rarity_I,"CLAW");
		ds_list_add(global.list_pool_cards_rarity_I,"BLOCK");
		ds_list_add(global.list_pool_cards_rarity_I,"REPOSITION");
		ds_list_add(global.list_pool_cards_rarity_I,"CLEARCAST");		
		ds_list_add(global.list_pool_cards_rarity_I,"LIFE_SPIRIT");	
		ds_list_add(global.list_pool_cards_rarity_I,"EMERALD_SLAM");	
		ds_list_add(global.list_pool_cards_rarity_I,"HIDDEN_CARD");			
		ds_list_add(global.list_pool_cards_rarity_I,"WILDSTRIKE");	
		ds_list_add(global.list_pool_cards_rarity_I,"VERDANT_BOLT");	
		ds_list_add(global.list_pool_cards_rarity_I,"SPINESLING");	
		ds_list_add(global.list_pool_cards_rarity_I,"BIOBOLT");	
		ds_list_add(global.list_pool_cards_rarity_I,"STALKING_SWIPE");
		ds_list_add(global.list_pool_cards_rarity_I,"UNSEEN_ROOT");
		ds_list_add(global.list_pool_cards_rarity_I,"FERAL_FRENZY");
		ds_list_add(global.list_pool_cards_rarity_I,"VERDANT_SWIPES");
	#endregion
	
	#region II
		ds_list_add(global.list_pool_cards_rarity_II,"POWER_STRIKE");		
		ds_list_add(global.list_pool_cards_rarity_II,"BULWARK");		
		ds_list_add(global.list_pool_cards_rarity_II,"INSPIRATION");		
		ds_list_add(global.list_pool_cards_rarity_II,"DEFT_STRIKE");		
		ds_list_add(global.list_pool_cards_rarity_II,"RAPID_STRIKES");
		ds_list_add(global.list_pool_cards_rarity_II,"INSPIRATION");
		ds_list_add(global.list_pool_cards_rarity_II,"MIRACLE_MUSA");	
		ds_list_add(global.list_pool_cards_rarity_II,"DISEASE")
		ds_list_add(global.list_pool_cards_rarity_II,"SHIV");	
		ds_list_add(global.list_pool_cards_rarity_II,"FELL");
		ds_list_add(global.list_pool_cards_rarity_II,"SPORE_CLOUD");
		ds_list_add(global.list_pool_cards_rarity_II,"BRAMBLE_ERUPTION");
	#endregion
	
	#region III
		ds_list_add(global.list_pool_cards_rarity_III,"SPELLBOOK_WILDCARD")
		ds_list_add(global.list_pool_cards_rarity_III,"GROWTH_SIGIL");			
		ds_list_add(global.list_pool_cards_rarity_III,"MALLEABILITY");	
		ds_list_add(global.list_pool_cards_rarity_III,"STAMPEDE");	
	#endregion
	
	#region IV
		ds_list_add(global.list_pool_cards_rarity_IV,"THOUGHSTEAL");	
		ds_list_add(global.list_pool_cards_rarity_IV,"ARTIFACT_HOURGLASS");	
		ds_list_add(global.list_pool_cards_rarity_IV,"ECHO");	
	#endregion	
}