//===============================================================================//
//
// SCRIPT: scr_init_item_pool
// FUNCTION: Initializes the global item pool.
// Adds every obtainable item ID to the master item pool.
// Used for random item generation and loot selection.
//
//===============================================================================//
function scr_init_item_pool(){
	ds_list_add(global.list_pool_items,"QUEST_IMPORTANT_NOTEBOOK");
	ds_list_add(global.list_pool_items,"HELD_POWERFUL_STONE");
	ds_list_add(global.list_pool_items,"CONSUMABLE_HEALING_SALVE");
	ds_list_add(global.list_pool_items,"PRISM_BASIC_PRISM");
	ds_list_add(global.list_pool_items,"EGG_ARBRAWN");	
}