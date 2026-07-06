//===============================================================================//
//
// SCRIPT: SCR_MARKET_MAKE_PRISM_OFFER
// FUNCTION: Creates one infinite prism vendor offer.
//           Stores prism item data, base cost, and purchase count.
//           Used by the prism vendor market pane.
//
//===============================================================================//

function scr_market_make_prism_offer(_str_item_id){

	var _stct_prism_info = scr_get_prism_info(_str_item_id);
	var _stct_item = scr_get_item_info(_str_item_id);

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