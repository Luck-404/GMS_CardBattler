//===============================================================================//
//
// SCRIPT: SCR_MARKET_MAKE_NPC_OFFER
// FUNCTION: Converts one NPC stock definition into a market offer.
//           Loads the item's full data struct.
//           Supports finite and infinite vendor quantities.
//
//===============================================================================//

function scr_market_make_npc_offer(_stct_stock_definition){

	if (_stct_stock_definition == undefined){
		return undefined;
	}

	if (
		!variable_struct_exists(
			_stct_stock_definition,
			"_str_item_id"
		)
	){
		return undefined;
	}

	var _str_item_id =
		_stct_stock_definition._str_item_id;

	var _stct_item =
		scr_get_item_info(_str_item_id);

	if (_stct_item == undefined){

		show_debug_message(
			"NPC MARKET ERROR: ITEM NOT FOUND | ID: " +
			string(_str_item_id)
		);

		return undefined;
	}

	var _val_gold_cost = 0;
	var _ct_stock = -1;

	if (
		variable_struct_exists(
			_stct_stock_definition,
			"_val_gold_cost"
		)
	){
		_val_gold_cost =
			_stct_stock_definition._val_gold_cost;
	}

	if (
		variable_struct_exists(
			_stct_stock_definition,
			"_ct_stock"
		)
	){
		_ct_stock =
			_stct_stock_definition._ct_stock;
	}

	return {
		_str_offer_type : "NPC",
		_str_item_id : _str_item_id,
		_stct_item : _stct_item,

		_val_gold_cost : _val_gold_cost,

		_ct_stock : _ct_stock,
		_flag_sold : (_ct_stock == 0)
	};
}