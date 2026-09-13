//===============================================================================//
//
// SCRIPT: SCR_MARKET_ROLL_PRISM_STOCK
// FUNCTION: Creates fixed infinite stock for the Prism Vendor.
//           Includes every Prism tier and skips invalid offers.
//
// ARGUMENTS: None.
// RETURNS: Array containing all valid Prism Market offers.
//
//===============================================================================//

function scr_market_roll_prism_stock(){

	//================//
	//PRISM TIERS//
	//================//
	var _arr_prism_ids = [
		"PRISM_COMMON",
		"PRISM_UNCOMMON",
		"PRISM_RARE",
		"PRISM_EPIC",
		"PRISM_LEGENDARY",
		"PRISM_ARCWORK"
	];

	var _arr_stock = [];

	//================//
	//BUILD STOCK//
	//================//
	for (var _it_prism = 0;_it_prism < array_length(_arr_prism_ids);_it_prism++){

		var _stct_offer = scr_market_make_prism_offer(
			_arr_prism_ids[_it_prism]
		);

		if (_stct_offer == undefined){
			continue;
		}

		array_push(
			_arr_stock,
			_stct_offer
		);
	}

	//================//
	//CHECK STOCK//
	//================//
	if (array_length(_arr_stock) < array_length(_arr_prism_ids)){

		scr_debug_log(
			"MARKET",
			"PRISM_STOCK",
			undefined,
			"PRISM MARKET STOCK INCOMPLETE" +
			" | OFFERS: " +
			string(array_length(_arr_stock)) +
			"/" +
			string(array_length(_arr_prism_ids)),
			"WARNING",
			"SCR_MARKET_ROLL_PRISM_STOCK"
		);
	}

	return _arr_stock;
}