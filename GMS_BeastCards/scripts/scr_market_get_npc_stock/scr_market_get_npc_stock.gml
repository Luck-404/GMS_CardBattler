//===============================================================================//
//
// SCRIPT: SCR_MARKET_GET_NPC_STOCK
// FUNCTION: Returns persistent vendor stock for one NPC UID.
//           Builds initial stock from the NPC definition when needed.
//
//===============================================================================//

function scr_market_get_npc_stock(
	_str_market_uid,
	_arr_trade_stock
){

	if (!ds_map_exists(
		global.map_market_stock,
		_str_market_uid
	)){

		global.map_market_stock[? _str_market_uid] =
			scr_market_build_npc_stock(
				_arr_trade_stock
			);
	}

	return global.map_market_stock[? _str_market_uid];
}