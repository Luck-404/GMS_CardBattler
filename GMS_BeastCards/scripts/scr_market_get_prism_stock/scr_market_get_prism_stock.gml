//===============================================================================//
//
// SCRIPT: SCR_MARKET_GET_PRISM_STOCK
// FUNCTION: Returns persistent prism vendor stock for one market UID.
//           Stores purchase counts so infinite stock costs keep increasing.
//           Creates stock if the market has not been opened before.
//
//===============================================================================//

function scr_market_get_prism_stock(_str_market_uid){

	if (!ds_map_exists(global.map_market_stock,_str_market_uid)){
		global.map_market_stock[? _str_market_uid] = scr_market_roll_prism_stock();
	}

	return global.map_market_stock[? _str_market_uid];
}