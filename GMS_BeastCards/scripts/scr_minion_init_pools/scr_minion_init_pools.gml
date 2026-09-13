//===============================================================================//
//
// SCRIPT: SCR_MINION_INIT_POOLS
// FUNCTION: Populates the global random Minion pools.
//           Called once during game initialization.
//           Vermilion entries remain disabled until their Minions are
//           implemented in the shared Minion system.
//
//===============================================================================//

function scr_minion_init_pools(){

	//==========//
	//VIRIDIAN//
	//==========//
	#region VIRIDIAN

	ds_list_add(global.list_pool_viridian_minions,"THORNLING");
	ds_list_add(global.list_pool_viridian_minions,"LIFE_SPIRIT");
	ds_list_add(global.list_pool_viridian_minions,"BLOOMING_SPRITE");
	ds_list_add(global.list_pool_viridian_minions,"SERPENT");
	ds_list_add(global.list_pool_viridian_minions,"WASP_DRONE");
	ds_list_add(global.list_pool_viridian_minions,"FUNGI");

	#endregion

	//==========//
	//CERULEAN//
	//==========//
	#region CERULEAN

	ds_list_add(global.list_pool_cerulean_minions,"TENTACLE");
	ds_list_add(global.list_pool_cerulean_minions,"ICE_WALL");
	ds_list_add(global.list_pool_cerulean_minions,"RIMEFROST_ELEMENTAL");
	ds_list_add(global.list_pool_cerulean_minions,"STORM_WISP");
	ds_list_add(global.list_pool_cerulean_minions,"CORAL_GUARDIAN");
	ds_list_add(global.list_pool_cerulean_minions,"ANCHOR_STONE");
	ds_list_add(global.list_pool_cerulean_minions,"ABYSSAL_HARPOON");

	#endregion

	//===========//
	//VERMILION//
	//===========//
	#region VERMILION

	// PLANNED — ENABLE AS EACH MINION IS IMPLEMENTED.
	//ds_list_add(global.list_pool_vermilion_minions,"FLAMEGUARD");
	//ds_list_add(global.list_pool_vermilion_minions,"LIVING_FLAME");
	//ds_list_add(global.list_pool_vermilion_minions,"CINDERLING");
	//ds_list_add(global.list_pool_vermilion_minions,"MAGMA_CANNON");
	//ds_list_add(global.list_pool_vermilion_minions,"EMBER_TURRET");
	//ds_list_add(global.list_pool_vermilion_minions,"ASH_PHOENIX");

	#endregion
}