//===============================================================================//
//
// SCRIPT: SCR_MARKET_RESTOCK_ALL
// FUNCTION: Clears all persistent market stock.
//           Markets reroll or rebuild stock the next time they are opened.
//
// ARGUMENTS: None.
// RETURNS: Number of persistent market entries cleared.
//
//===============================================================================//

function scr_market_restock_all(){

	//================//
	//VALIDATE STOCK MAP//
	//================//
	if (!ds_exists(global.map_market_stock,ds_type_map)){

		scr_debug_log(
			"MARKET",
			"RESTOCK",
			undefined,
			"MARKET RESTOCK FAILED" +
			" | REASON: MARKET STOCK MAP INVALID",
			"ERROR",
			"SCR_MARKET_RESTOCK_ALL"
		);

		return 0;
	}

	//================//
	//COUNT MARKETS//
	//================//
	var _ct_markets = ds_map_size(global.map_market_stock);

	//================//
	//CLEAR STOCK//
	//================//
	ds_map_clear(global.map_market_stock);

	return _ct_markets;
}