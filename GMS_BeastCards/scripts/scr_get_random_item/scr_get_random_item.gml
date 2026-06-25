//===============================================================================//
//
// SCRIPT: SCR_GET_RANDOM_ITEM
// FUNCTION: Rolls a weighted random item id from the supplied item pool.
//           Uses local item weights to bias common and rare item results.
//           Returns the selected item id string.
//
//===============================================================================//

function scr_get_random_item(_list_pool){
	var _stct_weights = {
		QUEST_IMPORTANT_NOTEBOOK : 5,
		HELD_POWERFUL_STONE : 10,
		CONSUMABLE_HEALING_SALVE : 50,
		PRISM_BASIC_PRISM : 50,
		EGG_ARBRAWN : 20
	};

	var _val_total_weight = 0;

	for (var _it_item = 0; _it_item < ds_list_size(_list_pool); _it_item++){
		var _str_item_id = ds_list_find_value(_list_pool,_it_item);

		if (variable_struct_exists(_stct_weights,_str_item_id)){
			_val_total_weight += variable_struct_get(_stct_weights,_str_item_id);
		}
	}

	var _val_roll = irandom_range(1,_val_total_weight);
	var _val_running_weight = 0;
	var _str_return_item_id = "";

	for (var _it_item = 0; _it_item < ds_list_size(_list_pool); _it_item++){
		var _str_item_id = ds_list_find_value(_list_pool,_it_item);

		if (variable_struct_exists(_stct_weights,_str_item_id)){
			_val_running_weight += variable_struct_get(_stct_weights,_str_item_id);

			if (_val_roll <= _val_running_weight){
				_str_return_item_id = _str_item_id;
				break;
			}
		}
	}

	return _str_return_item_id;
}