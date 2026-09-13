//===============================================================================//
//
// SCRIPT: SCR_MARKET_GET_EGG_STOCK
// FUNCTION: Returns persistent stock for one Egg Market UID.
//           Rolls and stores stock when the market has no persistent entry.
//           Logs newly generated Egg Market stock.
//
// ARGUMENTS: _str_market_uid is the persistent Egg Market stock key.
// RETURNS: Persistent Egg Market stock array.
//
//===============================================================================//

function scr_market_get_egg_stock(_str_market_uid){

	//================//
	//VALIDATE STOCK MAP//
	//================//
	if (!ds_exists(global.map_market_stock,ds_type_map)){
		return [];
	}

	//================//
	//ROLL NEW STOCK//
	//================//
	if (!ds_map_exists(global.map_market_stock,_str_market_uid)){

		var _arr_new_stock = scr_market_roll_egg_stock();

		global.map_market_stock[? _str_market_uid] = _arr_new_stock;

		scr_debug_log(
			"MARKET",
			"STOCK",
			undefined,
			"EGG MARKET STOCK GENERATED" +
			" | UID: " +
			string_upper(_str_market_uid) +
			" | OFFERS: " +
			string(array_length(_arr_new_stock)),
			"INFO",
			"SCR_MARKET_GET_EGG_STOCK"
		);
	}

	//================//
	//RETURN STOCK//
	//================//
	return global.map_market_stock[? _str_market_uid];
}