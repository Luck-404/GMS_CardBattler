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
		ds_list_add(global.list_pool_cards_rarity_I,"BLOCK");
		ds_list_add(global.list_pool_cards_rarity_I,"REPOSITION");
		ds_list_add(global.list_pool_cards_rarity_I,"CLEARCAST");		
		ds_list_add(global.list_pool_cards_rarity_I,"LIFE_SPIRIT");	
		ds_list_add(global.list_pool_cards_rarity_I,"EMERALD_SLAM");	
		ds_list_add(global.list_pool_cards_rarity_I,"HIDDEN_CARD");			
	#endregion
	
	#region II
		ds_list_add(global.list_pool_cards_rarity_II,"POWER_STRIKE");		
		ds_list_add(global.list_pool_cards_rarity_II,"BULWARK");		
		ds_list_add(global.list_pool_cards_rarity_II,"INSPIRATION");		
		ds_list_add(global.list_pool_cards_rarity_II,"DEFT_STRIKE");		
		ds_list_add(global.list_pool_cards_rarity_II,"RAPID_STRIKES");
		ds_list_add(global.list_pool_cards_rarity_II,"INSPIRATION");
		ds_list_add(global.list_pool_cards_rarity_II,"MIRACLE_MUSA");	
		ds_list_add(global.list_pool_cards_rarity_II,"DISEASE");	
	#endregion
	
	#region III
		ds_list_add(global.list_pool_cards_rarity_III,"ECHO");	
		ds_list_add(global.list_pool_cards_rarity_III,"GROWTH_SIGIL");			
	#endregion
	
	#region IV
	
	#endregion	
}