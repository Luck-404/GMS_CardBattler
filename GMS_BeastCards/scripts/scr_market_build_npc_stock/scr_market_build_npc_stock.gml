//===============================================================================//
//
// SCRIPT: SCR_MARKET_BUILD_NPC_STOCK
// FUNCTION: Converts an NPC's trade definitions into Market offer structs.
//           Skips invalid trade definitions and logs incomplete stock.
//
// ARGUMENTS: _arr_trade_stock is the NPC trade-definition array.
// RETURNS: Array containing all valid NPC Market offers.
//
//===============================================================================//

function scr_market_build_npc_stock(_arr_trade_stock){

	//================//
	//INITIALIZE STOCK//
	//================//
	var _arr_stock = [];

	//================//
	//VALIDATE STOCK//
	//================//
	if (!is_array(_arr_trade_stock)){

		scr_debug_log(
			"MARKET",
			"NPC_STOCK",
			undefined,
			"NPC MARKET STOCK BUILD FAILED" +
			" | REASON: TRADE STOCK IS NOT AN ARRAY",
			"ERROR",
			"SCR_MARKET_BUILD_NPC_STOCK"
		);

		return _arr_stock;
	}

	//================//
	//BUILD OFFERS//
	//================//
	for (var _it_stock = 0;_it_stock < array_length(_arr_trade_stock);_it_stock++){

		var _stct_offer = scr_market_make_npc_offer(
			_arr_trade_stock[_it_stock]
		);

		if (_stct_offer == undefined){
			continue;
		}

		array_push(
			_arr_stock,
			_stct_offer
		);
	}

	//================//
	//CHECK STOCK//
	//================//
	if (array_length(_arr_stock) < array_length(_arr_trade_stock)){

		scr_debug_log(
			"MARKET",
			"NPC_STOCK",
			undefined,
			"NPC MARKET STOCK INCOMPLETE" +
			" | OFFERS: " +
			string(array_length(_arr_stock)) +
			"/" +
			string(array_length(_arr_trade_stock)),
			"WARNING",
			"SCR_MARKET_BUILD_NPC_STOCK"
		);
	}

	return _arr_stock;
}