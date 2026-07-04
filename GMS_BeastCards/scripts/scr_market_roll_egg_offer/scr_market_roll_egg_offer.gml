//===============================================================================//
//
// SCRIPT: SCR_MARKET_ROLL_EGG_OFFER
// FUNCTION: Rolls one beast egg market offer.
//           Creates cached display item data and beast preview data.
//           Returns an offer struct used by the market stock array.
//
//===============================================================================//
function scr_market_roll_egg_offer(){

	var _arr_pool = global.arr_market_egg_beast_pool;

	var _stct_beast = scr_get_random_beast(_arr_pool);
	var _str_beast_name = _stct_beast._str_beast_name;
	var _str_item_id = "EGG_" + _str_beast_name;

	var _stct_item = scr_get_item_info(_str_item_id);

	var _stct_offer = {
		_str_offer_type : "EGG",
		_str_beast_name : _str_beast_name,
		_str_item_id : _str_item_id,
		_stct_item : _stct_item,
		_stct_beast_preview : _stct_beast,
		_val_gold_cost : scr_get_beast_egg_market_value(_stct_beast),
		_flag_sold : false
	};

	return _stct_offer;
}