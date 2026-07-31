//===============================================================================//
//
// SCRIPT: SCR_MARKET_BUILD_NPC_STOCK
// FUNCTION: Converts an NPC's trade definitions into market offers.
//
//===============================================================================//

function scr_market_build_npc_stock(_arr_trade_stock){

	var _arr_stock = [];

	if (!is_array(_arr_trade_stock)){
		return _arr_stock;
	}

	for (
		var _it_stock = 0;
		_it_stock < array_length(_arr_trade_stock);
		_it_stock++
	){

		var _stct_offer = scr_market_make_npc_offer(
			_arr_trade_stock[_it_stock]
		);

		if (_stct_offer != undefined){
			array_push(_arr_stock,_stct_offer);
		}
	}

	return _arr_stock;
}