//===============================================================================//
//
// SCR_INIT_MINION_POOLS
// FUNCTION: Populates all global minion pools.
//           Called once during game initialization.
//
//===============================================================================//
function scr_init_minion_pools(){

	//
	// VIRIDIAN
	//
	#region VIRIDIAN
	ds_list_add(global.list_pool_viridian_minions,"LIFE_SPIRIT");
	ds_list_add(global.list_pool_viridian_minions,"BLOOMING_SPRITE");
	#endregion
}