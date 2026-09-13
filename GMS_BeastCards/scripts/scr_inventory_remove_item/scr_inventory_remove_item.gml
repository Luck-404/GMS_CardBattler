//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_REMOVE_ITEM
// FUNCTION: Removes an item or item amount from the player Inventory.
//           Stackable items remove from the specified item's stack.
//           Non-stackable items remove the specified unique item.
//           Increments Inventory revision and logs the actual quantity removed.
//
// ARGUMENTS: _stct_item is the Inventory item struct to remove from.
//            _ct_amount is the requested amount to remove.
// RETURNS: True if the Inventory changed, otherwise false.
//
//===============================================================================//

function scr_inventory_remove_item(_stct_item,_ct_amount){

	//================//
	//VALIDATE REQUEST//
	//================//
	if (_stct_item == undefined){
		return false;
	}

	if (_ct_amount <= 0){
		return false;
	}

	if (
		!variable_global_exists("list_player_inventory") ||
		!ds_exists(global.list_player_inventory,ds_type_list)
	){

		scr_debug_log(
			"INVENTORY",
			"REMOVE",
			undefined,
			"ITEM REMOVE FAILED" +
			" | ITEM: " +
			string_upper(_stct_item._str_item_name) +
			" | REASON: INVENTORY LIST INVALID",
			"ERROR",
			"SCR_INVENTORY_REMOVE_ITEM"
		);

		return false;
	}

	//================//
	//INIT REMOVE//
	//================//
	var _list_inventory = global.list_player_inventory;

	var _ct_remaining = _ct_amount;
	var _flag_changed = false;

	var _ct_removed_total = 0;

	//================//
	//COUNT OWNED BEFORE//
	//================//
	var _ct_owned_before = 0;

	for (var _it_item = 0;_it_item < ds_list_size(_list_inventory);_it_item++){

		var _stct_check_item = ds_list_find_value(
			_list_inventory,
			_it_item
		);

		if (_stct_check_item == undefined){
			continue;
		}

		if (_stct_check_item._str_item_id != _stct_item._str_item_id){
			continue;
		}

		if (_stct_check_item._flag_stackable){
			_ct_owned_before += _stct_check_item._ct_item_amount;
		}
		else{
			_ct_owned_before++;
		}
	}

	//=====================//
	//STACKABLE ITEM REMOVE//
	//=====================//
	if (_stct_item._flag_stackable){

		for (var _it_item = 0;_it_item < ds_list_size(_list_inventory);_it_item++){

			if (_ct_remaining <= 0){
				break;
			}

			var _stct_check_item = ds_list_find_value(
				_list_inventory,
				_it_item
			);

			if (_stct_check_item == undefined){
				continue;
			}

			if (_stct_check_item._uid_item != _stct_item._uid_item){
				continue;
			}

			var _ct_removed = min(
				_ct_remaining,
				_stct_check_item._ct_item_amount
			);

			_stct_check_item._ct_item_amount -= _ct_removed;

			_ct_remaining -= _ct_removed;
			_ct_removed_total += _ct_removed;

			_flag_changed = true;

			if (_stct_check_item._ct_item_amount <= 0){

				ds_list_delete(
					_list_inventory,
					_it_item
				);

				_it_item--;
			}
			else{

				ds_list_replace(
					_list_inventory,
					_it_item,
					_stct_check_item
				);
			}
		}
	}

	//========================//
	//NON-STACKABLE ITEM REMOVE//
	//========================//
	else{

		for (var _it_item = 0;_it_item < ds_list_size(_list_inventory);_it_item++){

			var _stct_check_item = ds_list_find_value(
				_list_inventory,
				_it_item
			);

			if (_stct_check_item == undefined){
				continue;
			}

			if (_stct_check_item._uid_item != _stct_item._uid_item){
				continue;
			}

			ds_list_delete(
				_list_inventory,
				_it_item
			);

			_ct_remaining--;
			_ct_removed_total++;

			_flag_changed = true;

			break;
		}
	}

	//================//
	//NO ITEM REMOVED//
	//================//
	if (!_flag_changed){

		scr_debug_log(
			"INVENTORY",
			"REMOVE",
			undefined,
			"ITEM REMOVE FAILED" +
			" | ITEM: " +
			string_upper(_stct_item._str_item_name) +
			" | ID: " +
			string_upper(_stct_item._str_item_id) +
			" | UID: " +
			string(_stct_item._uid_item) +
			" | REQUESTED: " +
			string(_ct_amount) +
			" | REASON: ITEM NOT FOUND",
			"WARNING",
			"SCR_INVENTORY_REMOVE_ITEM"
		);

		return false;
	}

	//================//
	//UPDATE REVISION//
	//================//
	global.ct_inventory_revision++;

	//================//
	//DEBUG REMOVAL//
	//================//
	scr_debug_log(
		"INVENTORY",
		"REMOVE",
		undefined,
		"ITEM REMOVED" +
		" | ITEM: " +
		string_upper(_stct_item._str_item_name) +
		" | ID: " +
		string_upper(_stct_item._str_item_id) +
		" | UID: " +
		string(_stct_item._uid_item) +
		" | REQUESTED: " +
		string(_ct_amount) +
		" | REMOVED: " +
		string(_ct_removed_total) +
		" | OWNED: " +
		string(_ct_owned_before) +
		" -> " +
		string(max(0,_ct_owned_before - _ct_removed_total)) +
		" | INVENTORY ENTRIES: " +
		string(ds_list_size(_list_inventory)) +
		" | REVISION: " +
		string(global.ct_inventory_revision),
		"INFO",
		"SCR_INVENTORY_REMOVE_ITEM"
	);

	return true;
}