//===============================================================================//
//
// SCRIPT: SCR_MARKET_GET_NPC_STOCK
// FUNCTION: Returns persistent vendor stock for one NPC Market UID.
//           Builds initial stock from the NPC trade definitions when required.
//           Logs newly generated NPC vendor stock.
//
// ARGUMENTS: _str_market_uid is the persistent Market stock key.
//            _arr_trade_stock is the NPC's initial trade definition array.
// RETURNS: Persistent NPC Market stock array.
//
//===============================================================================//

function scr_market_get_npc_stock(_str_market_uid,_arr_trade_stock){

	//================//
	//VALIDATE STOCK MAP//
	//================//
	if (!ds_exists(global.map_market_stock,ds_type_map)){
		return [];
	}

	//================//
	//BUILD INITIAL STOCK//
	//================//
	if (!ds_map_exists(global.map_market_stock,_str_market_uid)){

		var _arr_new_stock = scr_market_build_npc_stock(
			_arr_trade_stock
		);

		global.map_market_stock[? _str_market_uid] = _arr_new_stock;

		scr_debug_log(
			"MARKET",
			"STOCK",
			undefined,
			"NPC MARKET STOCK GENERATED" +
			" | UID: " +
			string_upper(_str_market_uid) +
			" | OFFERS: " +
			string(array_length(_arr_new_stock)),
			"INFO",
			"SCR_MARKET_GET_NPC_STOCK"
		);
	}

	//================//
	//RETURN STOCK//
	//================//
	return global.map_market_stock[? _str_market_uid];
}