//===============================================================================//
//
// SCRIPT: SCR_ADD_ITEM_TO_INVENTORY
// FUNCTION: Adds item structs to the player inventory.
//           Handles stackable items by filling existing stacks first.
//           Creates new item stacks when needed.
//
//===============================================================================//

function scr_add_item_to_inventory(_str_item_id,_ct_count){
	var _list_inventory = global.list_player_inventory;

	var _stct_base_item = scr_get_item_info(_str_item_id);

	if (!_stct_base_item._flag_stackable){
		for (var _it_item = 0; _it_item < _ct_count; _it_item++){
			var _stct_new_item = scr_get_item_info(_str_item_id);
			ds_list_add(_list_inventory,_stct_new_item);
		}
		
		global.ct_inventory_revision++;
		return;
	}

	var _ct_remaining = _ct_count;

	for (var _it_item = 0; _it_item < ds_list_size(_list_inventory); _it_item++){
		if (_ct_remaining <= 0){
			break;
		}

		var _stct_item = ds_list_find_value(_list_inventory,_it_item);

		if (_stct_item == undefined){
			continue;
		}

		if (_stct_item._str_item_id == _str_item_id){
			var _ct_cur = _stct_item._ct_item_amount;
			var _ct_max = _stct_item._ct_item_max_amount;

			if (_ct_cur < _ct_max){
				var _ct_space = _ct_max - _ct_cur;
				var _ct_add = min(_ct_space,_ct_remaining);

				_stct_item._ct_item_amount = _ct_cur + _ct_add;
				_ct_remaining -= _ct_add;

				ds_list_replace(_list_inventory,_it_item,_stct_item);
			}
		}
	}

	while (_ct_remaining > 0){
		var _stct_new_stack = scr_get_item_info(_str_item_id);
		var _ct_max = _stct_new_stack._ct_item_max_amount;
		var _ct_add = min(_ct_max,_ct_remaining);

		_stct_new_stack._ct_item_amount = _ct_add;
		_ct_remaining -= _ct_add;

		ds_list_add(_list_inventory,_stct_new_stack);
	}
	global.ct_inventory_revision++;
}