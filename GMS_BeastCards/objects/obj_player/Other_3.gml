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
	if (ds_exists(global.list_player_party, ds_type_list)){
		ds_list_destroy(global.list_player_party);
	}

	if (ds_exists(global.list_player_ranch, ds_type_list)){
		ds_list_destroy(global.list_player_ranch);
	}
	#endregion

	#region CARD GLOBALS
	if (ds_exists(global.list_player_deck, ds_type_list)){
		ds_list_destroy(global.list_player_deck);
	}

	if (ds_exists(global.list_player_library, ds_type_list)){
		ds_list_destroy(global.list_player_library);
	}

	if (ds_exists(global.list_pool_cards_rarity_I, ds_type_list)){
		ds_list_destroy(global.list_pool_cards_rarity_I);
	}

	if (ds_exists(global.list_pool_cards_rarity_II, ds_type_list)){
		ds_list_destroy(global.list_pool_cards_rarity_II);
	}

	if (ds_exists(global.list_pool_cards_rarity_III, ds_type_list)){
		ds_list_destroy(global.list_pool_cards_rarity_III);
	}

	if (ds_exists(global.list_pool_cards_rarity_IV, ds_type_list)){
		ds_list_destroy(global.list_pool_cards_rarity_IV);
	}
	#endregion

	#region MINION GLOBALS
	if (ds_exists(global.list_pool_viridian_minions, ds_type_list)){
		ds_list_destroy(global.list_pool_viridian_minions);
	}
	#endregion

	#region ITEM GLOBALS
	if (ds_exists(global.list_player_inventory, ds_type_list)){
		ds_list_destroy(global.list_player_inventory);
	}

	if (ds_exists(global.list_pool_items, ds_type_list)){
		ds_list_destroy(global.list_pool_items);
	}
	#endregion

	#region PLAYER TRACKING
	if (ds_exists(global.map_player_chests_opened, ds_type_map)){
		ds_map_destroy(global.map_player_chests_opened);
	}
	
	#endregion
	
	#region LOGBOOK GLOBALS
	if (ds_exists(global.list_logbook_beasts, ds_type_list)){
		ds_list_destroy(global.list_logbook_beasts);
	}

	if (ds_exists(global.map_logbook_beasts, ds_type_map)){
		ds_map_destroy(global.map_logbook_beasts);
	}

	if (ds_exists(global.list_logbook_cards, ds_type_list)){
		ds_list_destroy(global.list_logbook_cards);
	}

	if (ds_exists(global.map_logbook_cards, ds_type_map)){
		ds_map_destroy(global.map_logbook_cards);
	}
	#endregion	

	#region CAMERA
	if (global.ref_camera != undefined){
		camera_destroy(global.ref_camera);
		global.ref_camera = undefined;
	}
	#endregion

	#region MARKET GLOBALS
	if (ds_exists(global.map_market_stock,ds_type_map)){
		ds_map_destroy(global.map_market_stock);
	}
	#endregion
#endregion