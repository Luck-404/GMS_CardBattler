//===============================================================================//
//
// SCRIPT: SCR_MARKET_SET_STOCK
// FUNCTION: Saves a market stock array into the global market stock map.
//           Used after purchases or other persistent stock changes.
//
// ARGUMENTS: _str_market_uid is the market key; _arr_stock is its stock array.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_market_set_stock(_str_market_uid,_arr_stock){

	//================//
	//SAVE STOCK//
	//================//
	global.map_market_stock[? _str_market_uid] = _arr_stock;
}