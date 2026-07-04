//===============================================================================//
//
// SCRIPT: SCR_MARKET_ROLL_EGG_STOCK
// FUNCTION: Rolls the full stock array for one beast egg market.
//           Creates three cached egg offers.
//           Returns the stock array.
//
//===============================================================================//
function scr_market_roll_egg_stock(){

	var _arr_stock = [];

	for (var _it_offer = 0; _it_offer < 3; _it_offer++){
		array_push(_arr_stock,scr_market_roll_egg_offer());
	}

	return _arr_stock;
}