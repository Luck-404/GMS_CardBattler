//===============================================================================//
//
// SCRIPT: SCR_MARKET_GET_PRISM_STOCK
// FUNCTION: Returns persistent Prism Vendor stock for one market UID.
//           Creates fixed Prism stock when no persistent entry exists.
//           Purchase counts persist so Prism costs continue increasing.
//
// ARGUMENTS: _str_market_uid is the persistent Prism Market stock key.
// RETURNS: Persistent Prism Market stock array.
//
//===============================================================================//

function scr_market_get_prism_stock(_str_market_uid){

	//================//
	//VALIDATE STOCK MAP//
	//================//
	if (!ds_exists(global.map_market_stock,ds_type_map)){
		return [];
	}

	//================//
	//ROLL INITIAL STOCK//
	//================//
	if (!ds_map_exists(global.map_market_stock,_str_market_uid)){

		var _arr_new_stock = scr_market_roll_prism_stock();

		global.map_market_stock[? _str_market_uid] = _arr_new_stock;

		scr_debug_log(
			"MARKET",
			"STOCK",
			undefined,
			"PRISM MARKET STOCK GENERATED" +
			" | UID: " +
			string_upper(_str_market_uid) +
			" | OFFERS: " +
			string(array_length(_arr_new_stock)),
			"INFO",
			"SCR_MARKET_GET_PRISM_STOCK"
		);
	}

	//================//
	//RETURN STOCK//
	//================//
	return global.map_market_stock[? _str_market_uid];
}