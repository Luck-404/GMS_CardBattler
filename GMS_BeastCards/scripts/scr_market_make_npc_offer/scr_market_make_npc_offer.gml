//===============================================================================//
//
// SCRIPT: SCR_MARKET_MAKE_NPC_OFFER
// FUNCTION: Converts one NPC stock definition into a Market offer.
//           Loads the item's persistent item data.
//           Supports finite and infinite vendor quantities.
//
// ARGUMENTS: _stct_stock_definition is one NPC trade stock definition.
// RETURNS: NPC Market offer struct, or undefined when invalid.
//
//===============================================================================//

function scr_market_make_npc_offer(_stct_stock_definition){

	//================//
	//VALIDATE DEFINITION//
	//================//
	if (!is_struct(_stct_stock_definition)){

		scr_debug_log(
			"MARKET",
			"NPC_STOCK",
			undefined,
			"NPC OFFER CREATION FAILED" +
			" | REASON: INVALID STOCK DEFINITION",
			"ERROR",
			"SCR_MARKET_MAKE_NPC_OFFER"
		);

		return undefined;
	}

	if (!variable_struct_exists(_stct_stock_definition,"_str_item_id")){

		scr_debug_log(
			"MARKET",
			"NPC_STOCK",
			undefined,
			"NPC OFFER CREATION FAILED" +
			" | REASON: ITEM ID MISSING",
			"ERROR",
			"SCR_MARKET_MAKE_NPC_OFFER"
		);

		return undefined;
	}

	//================//
	//GET ITEM DATA//
	//================//
	var _str_item_id = _stct_stock_definition._str_item_id;
	var _stct_item = scr_inventory_get_item_info(_str_item_id);

	if (_stct_item == undefined){

		scr_debug_log(
			"MARKET",
			"NPC_STOCK",
			undefined,
			"NPC OFFER CREATION FAILED" +
			" | ITEM ID: " +
			string_upper(_str_item_id) +
			" | REASON: INVENTORY ITEM DATA MISSING",
			"ERROR",
			"SCR_MARKET_MAKE_NPC_OFFER"
		);

		return undefined;
	}

	//================//
	//GET OFFER VALUES//
	//================//
	var _val_gold_cost = 0;
	var _ct_stock = -1;

	if (variable_struct_exists(_stct_stock_definition,"_val_gold_cost")){
		_val_gold_cost = _stct_stock_definition._val_gold_cost;
	}

	if (variable_struct_exists(_stct_stock_definition,"_ct_stock")){
		_ct_stock = _stct_stock_definition._ct_stock;
	}

	//================//
	//CREATE OFFER//
	//================//
	return {
		_str_offer_type : "NPC",
		_str_item_id : _str_item_id,
		_stct_item : _stct_item,
		_val_gold_cost : _val_gold_cost,
		_ct_stock : _ct_stock,
		_flag_sold : (_ct_stock == 0)
	};
}