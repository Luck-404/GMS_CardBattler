//===============================================================================//
//
// SCRIPT: SCR_MARKET_ROLL_EGG_OFFER
// FUNCTION: Rolls one Beast Egg Market offer.
//           Creates cached Egg item data and Beast preview data.
//
// ARGUMENTS: None.
// RETURNS: Egg Market offer struct, or undefined when creation fails.
//
//===============================================================================//

function scr_market_roll_egg_offer(){

	//================//
	//GET BEAST POOL//
	//================//
	var _arr_pool = global.arr_market_egg_beast_pool;

	if (!is_array(_arr_pool) || array_length(_arr_pool) <= 0){

		scr_debug_log(
			"MARKET",
			"EGG_STOCK",
			undefined,
			"EGG OFFER ROLL FAILED" +
			" | REASON: EGG BEAST POOL EMPTY OR INVALID",
			"ERROR",
			"SCR_MARKET_ROLL_EGG_OFFER"
		);

		return undefined;
	}

	//================//
	//ROLL BEAST//
	//================//
	var _stct_beast = scr_beast_get_random(_arr_pool);

	if (!is_struct(_stct_beast)){

		scr_debug_log(
			"MARKET",
			"EGG_STOCK",
			undefined,
			"EGG OFFER ROLL FAILED" +
			" | REASON: BEAST ROLL FAILED",
			"ERROR",
			"SCR_MARKET_ROLL_EGG_OFFER"
		);

		return undefined;
	}

	var _str_beast_name = _stct_beast._str_beast_name;
	var _str_item_id = "EGG_" + _str_beast_name;

	//================//
	//GET ITEM DATA//
	//================//
	var _stct_item = scr_inventory_get_item_info(_str_item_id);

	if (_stct_item == undefined){

		scr_debug_log(
			"MARKET",
			"EGG_STOCK",
			undefined,
			"EGG OFFER ROLL FAILED" +
			" | BEAST: " +
			string_upper(_str_beast_name) +
			" | ITEM ID: " +
			string_upper(_str_item_id) +
			" | REASON: INVENTORY ITEM DATA MISSING",
			"ERROR",
			"SCR_MARKET_ROLL_EGG_OFFER"
		);

		return undefined;
	}

	//================//
	//CREATE OFFER//
	//================//
	var _stct_offer = {
		_str_offer_type : "EGG",
		_str_beast_name : _str_beast_name,
		_str_item_id : _str_item_id,
		_stct_item : _stct_item,
		_stct_beast_preview : _stct_beast,
		_val_gold_cost : scr_market_get_beast_egg_value(_stct_beast),
		_flag_sold : false
	};

	return _stct_offer;
}