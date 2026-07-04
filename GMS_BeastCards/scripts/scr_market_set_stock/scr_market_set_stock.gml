//===============================================================================//
//
// SCRIPT: SCR_MARKET_SET_STOCK
// FUNCTION: Saves a market stock array back into the global market stock map.
//           Used after purchase state changes.
//
//===============================================================================//
function scr_market_set_stock(_str_market_uid,_arr_stock){

	global.map_market_stock[? _str_market_uid] = _arr_stock;
}