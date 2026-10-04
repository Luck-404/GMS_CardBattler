//===============================================================================//
//
// SCRIPT: SCR_MINION_INIT_POOLS
// FUNCTION: Initializes the global random Minion pools as arrays.
//           Called once during game initialization.
//
//===============================================================================//

function scr_minion_init_pools(){

	//==========//
	//VIRIDIAN//
	//==========//
	#region VIRIDIAN

	global.arr_pool_viridian_minions = [
		"THORNLING",
		"LIFE_SPIRIT",
		"BLOOMING_SPRITE",
		"SERPENT",
		"WASP_DRONE",
		"FUNGI"
	];

	#endregion

	//==========//
	//CERULEAN//
	//==========//
	#region CERULEAN

	global.arr_pool_cerulean_minions = [
		"TENTACLE",
		"ICE_WALL",
		"RIMEFROST_ELEMENTAL",
		"STORM_WISP",
		"CORAL_GUARDIAN",
		"ANCHOR_STONE",
		"ABYSSAL_HARPOON"
	];

	#endregion

	//===========//
	//VERMILION//
	//===========//
	#region VERMILION

	global.arr_pool_vermilion_minions = [
		"FLAMEGUARD",
		"LIVING_FLAME",
		"CINDERLING",
		"MAGMA_CANNON",
		"EMBER_TURRET",
		"ASH_PHOENIX"
	];

	#endregion
}