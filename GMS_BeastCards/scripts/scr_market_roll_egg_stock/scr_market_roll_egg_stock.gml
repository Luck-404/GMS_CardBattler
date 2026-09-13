//===============================================================================//
//
// SCRIPT: SCR_MARKET_ROLL_EGG_STOCK
// FUNCTION: Rolls the full stock array for one Beast Egg Market.
//           Attempts to create three valid Egg offers.
//           Prevents infinite reroll loops and logs incomplete stock.
//
// ARGUMENTS: None.
// RETURNS: Array containing up to three valid Egg Market offers.
//
//===============================================================================//

function scr_market_roll_egg_stock(){

	//================//
	//INITIALIZE STOCK//
	//================//
	var _arr_stock = [];

	var _ct_target_offers = 3;
	var _ct_attempts = 0;
	var _ct_attempts_max = 12;

	//================//
	//ROLL OFFERS//
	//================//
	while (
		array_length(_arr_stock) < _ct_target_offers &&
		_ct_attempts < _ct_attempts_max
	){

		_ct_attempts++;

		var _stct_offer = scr_market_roll_egg_offer();

		if (_stct_offer == undefined){
			continue;
		}

		array_push(
			_arr_stock,
			_stct_offer
		);
	}

	//================//
	//CHECK SHORT STOCK//
	//================//
	if (array_length(_arr_stock) < _ct_target_offers){

		scr_debug_log(
			"MARKET",
			"EGG_STOCK",
			undefined,
			"EGG MARKET STOCK INCOMPLETE" +
			" | OFFERS: " +
			string(array_length(_arr_stock)) +
			"/" +
			string(_ct_target_offers) +
			" | ATTEMPTS: " +
			string(_ct_attempts) +
			"/" +
			string(_ct_attempts_max),
			"WARNING",
			"SCR_MARKET_ROLL_EGG_STOCK"
		);
	}

	return _arr_stock;
}