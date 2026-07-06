//===============================================================================//
//
// SCRIPT: SCR_MARKET_ROLL_PRISM_STOCK
// FUNCTION: Creates fixed infinite stock for the prism vendor.
//           Includes every prism tier.
//           Returns a stock array.
//
//===============================================================================//

function scr_market_roll_prism_stock(){

	var _arr_stock = [];

	array_push(_arr_stock,scr_market_make_prism_offer("PRISM_COMMON"));
	array_push(_arr_stock,scr_market_make_prism_offer("PRISM_UNCOMMON"));
	array_push(_arr_stock,scr_market_make_prism_offer("PRISM_RARE"));
	array_push(_arr_stock,scr_market_make_prism_offer("PRISM_EPIC"));
	array_push(_arr_stock,scr_market_make_prism_offer("PRISM_LEGENDARY"));
	array_push(_arr_stock,scr_market_make_prism_offer("PRISM_ARCWORK"));

	return _arr_stock;
}
