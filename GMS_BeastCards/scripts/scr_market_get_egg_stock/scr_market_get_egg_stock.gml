//===============================================================================//
//
// SCRIPT: SCR_MARKET_GET_EGG_STOCK
// FUNCTION: Returns persistent stock for one egg market UID.
//           Rolls new stock when the market has no tracked stock.
//           Stores stock in global.map_market_stock.
//
//===============================================================================//
function scr_market_get_egg_stock(_str_market_uid){

	if (!ds_map_exists(global.map_market_stock,_str_market_uid)){
		global.map_market_stock[? _str_market_uid] = scr_market_roll_egg_stock();
	}

	return global.map_market_stock[? _str_market_uid];
}