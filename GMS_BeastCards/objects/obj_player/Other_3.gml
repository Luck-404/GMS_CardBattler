//===============================================================================//
//
// GAME END: OBJ_PLAYER
// FUNCTION: Cleans up persistent global data structures.
//           Destroys ds_lists and ds_maps created during startup.
//           Prevents memory leaks when the game closes.
//
//===============================================================================//

//-------//
//CLEANUP//
//-------//
#region CLEANUP

	#region BEAST GLOBALS
	if (ds_exists(global.player_party, ds_type_list)){
		ds_list_destroy(global.player_party);
	}

	if (ds_exists(global.player_ranch, ds_type_list)){
		ds_list_destroy(global.player_ranch);
	}
	#endregion

	#region CARD GLOBALS
	if (ds_exists(global.player_deck, ds_type_list)){
		ds_list_destroy(global.player_deck);
	}

	if (ds_exists(global.player_library, ds_type_list)){
		ds_list_destroy(global.player_library);
	}

	if (ds_exists(global.rarity_I_cards, ds_type_list)){
		ds_list_destroy(global.rarity_I_cards);
	}

	if (ds_exists(global.rarity_II_cards, ds_type_list)){
		ds_list_destroy(global.rarity_II_cards);
	}

	if (ds_exists(global.rarity_III_cards, ds_type_list)){
		ds_list_destroy(global.rarity_III_cards);
	}

	if (ds_exists(global.rarity_IV_cards, ds_type_list)){
		ds_list_destroy(global.rarity_IV_cards);
	}
	#endregion

	#region MINION GLOBALS
	if (ds_exists(global.viridian_minions, ds_type_list)){
		ds_list_destroy(global.viridian_minions);
	}
	#endregion

	#region ITEM GLOBALS
	if (ds_exists(global.player_inventory, ds_type_list)){
		ds_list_destroy(global.player_inventory);
	}

	if (ds_exists(global.item_pool, ds_type_list)){
		ds_list_destroy(global.item_pool);
	}
	#endregion

	#region PLAYER TRACKING
	if (ds_exists(global.player_chests_opened, ds_type_map)){
		ds_map_destroy(global.player_chests_opened);
	}
	#endregion

	#region CAMERA
	if (global.camera != undefined){
		camera_destroy(global.camera);
		global.camera = undefined;
	}
	#endregion

#endregion