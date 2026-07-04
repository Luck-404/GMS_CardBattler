//===============================================================================//
//
// SCRIPT: SCR_MARKET_RESTOCK_ALL
// FUNCTION: Clears all persistent market stock.
//           Markets reroll the next time they are opened.
//
//===============================================================================//
function scr_market_restock_all(){

	if (ds_exists(global.map_market_stock,ds_type_map)){
		ds_map_clear(global.map_market_stock);
	}
}