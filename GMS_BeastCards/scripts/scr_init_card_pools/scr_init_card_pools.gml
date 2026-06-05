//
//
// SCRIPT: SCR_INIT_CARD_POOLS | ADDS CARDS TO POOLS | RETURN VOID
//
//
function scr_init_card_pools(){
	#region I
		ds_list_add(global.rarity_I_cards,"STRIKE");
		ds_list_add(global.rarity_I_cards,"BLOCK");
		ds_list_add(global.rarity_I_cards,"RESPOSITION");
		ds_list_add(global.rarity_I_cards,"CLEARCAST");		
	#endregion
	
	#region II
		ds_list_add(global.rarity_II_cards,"POWER_STRIKE");		
		ds_list_add(global.rarity_II_cards,"BULWARK");		
		ds_list_add(global.rarity_II_cards,"INSPIRATION");		
		ds_list_add(global.rarity_II_cards,"DEFT_STRIKE");		
		ds_list_add(global.rarity_II_cards,"RAPID_STRIKES");				
	#endregion
	
	#region III
		ds_list_add(global.rarity_III_cards,"ECHO");		
	#endregion
	
	#region IV
	
	#endregion	
}