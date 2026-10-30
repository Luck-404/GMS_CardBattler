//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_REWARD_GET_EGG_POOL
// FUNCTION: Returns all valid Egg Item IDs currently exposed by the master Item
//           pool. Quest Items and non-Egg inventory entries are excluded.
//
//===============================================================================//

function scr_world_event_reward_get_egg_pool(){

	var _arr_eggs = [];

	if (
		!variable_global_exists("arr_pool_items") ||
		!is_array(global.arr_pool_items)
	){
		return _arr_eggs;
	}

	for (
		var _it_item = 0;
		_it_item < array_length(global.arr_pool_items);
		_it_item++
	){

		var _str_item_id =
			string_upper(
				string(
					global.arr_pool_items[_it_item]
				)
			);

		if (string_pos("EGG_",_str_item_id) != 1){
			continue;
		}

		var _stct_item =
			scr_inventory_get_item_info(
				_str_item_id
			);

		if (
			is_struct(_stct_item) &&
			string_upper(string(_stct_item._str_item_type)) == "EGG"
		){
			array_push(_arr_eggs,_str_item_id);
		}
	}

	return _arr_eggs;
}
