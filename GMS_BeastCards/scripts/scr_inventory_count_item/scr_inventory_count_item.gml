//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_COUNT_ITEM
// FUNCTION: Counts the player's owned quantity of a specific Item ID across
//           multiple Inventory stacks and non-stackable Item entries.
//
// ARGUMENTS: _str_item_id is the Item ID to count.
// RETURNS: Total owned Item quantity, or 0 when invalid/unavailable.
//
//===============================================================================//

function scr_inventory_count_item(_str_item_id){

	if (!is_string(_str_item_id) || _str_item_id == ""){
		return 0;
	}

	if (!variable_global_exists("list_player_inventory")){
		return 0;
	}

	if (!ds_exists(global.list_player_inventory,ds_type_list)){
		return 0;
	}

	var _ct_owned = 0;
	var _list_inventory = global.list_player_inventory;

	for (var _it_item = 0;_it_item < ds_list_size(_list_inventory);_it_item++){

		var _stct_item = ds_list_find_value(_list_inventory,_it_item);

		if (!is_struct(_stct_item)){
			continue;
		}

		if (_stct_item._str_item_id != _str_item_id){
			continue;
		}

		if (_stct_item._flag_stackable){
			_ct_owned += max(0,_stct_item._ct_item_amount);
		}
		else{
			_ct_owned++;
		}
	}

	return _ct_owned;
}
