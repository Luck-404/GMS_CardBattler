//===============================================================================//
//
// SCRIPT: SCR_MARKET_MAKE_PRISM_OFFER
// FUNCTION: Creates one infinite Prism Vendor offer.
//           Stores Prism item data, base cost, and purchase count.
//
// ARGUMENTS: _str_item_id is the Prism item id used to create the offer.
// RETURNS: Prism Market offer struct, or undefined when data is invalid.
//
//===============================================================================//

function scr_market_make_prism_offer(_str_item_id){

	//================//
	//GET PRISM DATA//
	//================//
	var _stct_prism_info = scr_inventory_get_prism_info(_str_item_id);
	var _stct_item = scr_inventory_get_item_info(_str_item_id);

	//================//
	//VALIDATE PRISM//
	//================//
	if (_stct_prism_info == undefined){

		scr_debug_log(
			"MARKET",
			"PRISM_STOCK",
			undefined,
			"PRISM OFFER CREATION FAILED" +
			" | ITEM ID: " +
			string_upper(_str_item_id) +
			" | REASON: PRISM DATA MISSING",
			"ERROR",
			"SCR_MARKET_MAKE_PRISM_OFFER"
		);

		return undefined;
	}

	//================//
	//VALIDATE ITEM//
	//================//
	if (_stct_item == undefined){

		scr_debug_log(
			"MARKET",
			"PRISM_STOCK",
			undefined,
			"PRISM OFFER CREATION FAILED" +
			" | ITEM ID: " +
			string_upper(_str_item_id) +
			" | REASON: INVENTORY ITEM DATA MISSING",
			"ERROR",
			"SCR_MARKET_MAKE_PRISM_OFFER"
		);

		return undefined;
	}

	//================//
	//CREATE OFFER//
	//================//
	var _stct_offer = {
		_str_offer_type : "PRISM",
		_str_item_id : _stct_prism_info._str_item_id,
		_stct_item : _stct_item,
		_val_tame_bonus : _stct_prism_info._val_tame_bonus,
		_val_base_cost : _stct_prism_info._val_base_cost,
		_val_gold_cost : _stct_prism_info._val_base_cost,
		_ct_bought : 0,
		_flag_sold : false,
		_flag_infinite : true
	};

	return _stct_offer;
}