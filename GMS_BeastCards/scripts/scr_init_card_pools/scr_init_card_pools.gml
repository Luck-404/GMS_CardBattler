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
		ds_list_add(global.rarity_I_cards,"STRIKE");
		ds_list_add(global.rarity_I_cards,"BLOCK");
		ds_list_add(global.rarity_I_cards,"RESPOSITION");
		ds_list_add(global.rarity_I_cards,"CLEARCAST");		
		ds_list_add(global.rarity_I_cards,"LIFE_SPIRIT");	
		ds_list_add(global.rarity_I_cards,"EMERALD_SLAM");	
		ds_list_add(global.rarity_I_cards,"HIDDEN_CARD");			
	#endregion
	
	#region II
		ds_list_add(global.rarity_II_cards,"POWER_STRIKE");		
		ds_list_add(global.rarity_II_cards,"BULWARK");		
		ds_list_add(global.rarity_II_cards,"INSPIRATION");		
		ds_list_add(global.rarity_II_cards,"DEFT_STRIKE");		
		ds_list_add(global.rarity_II_cards,"RAPID_STRIKES");
		ds_list_add(global.rarity_II_cards,"INSPIRATION");
		ds_list_add(global.rarity_II_cards,"MIRACLE_MUSA");	
		ds_list_add(global.rarity_II_cards,"DISEASE");	
	#endregion
	
	#region III
		ds_list_add(global.rarity_III_cards,"ECHO");	
		ds_list_add(global.rarity_III_cards,"GROWTH_SIGIL");			
	#endregion
	
	#region IV
	
	#endregion	
}