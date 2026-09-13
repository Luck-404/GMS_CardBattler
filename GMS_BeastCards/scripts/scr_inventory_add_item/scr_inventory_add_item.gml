//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ADD_ITEM
// FUNCTION: Adds items to the player Inventory.
//           Fills existing stacks before creating new stacks.
//           Adds individual entries for non-stackable items.
//           Logs the final Inventory quantity change.
//
// ARGUMENTS: _str_item_id is the item id to add.
//            _ct_count is the number of items to add.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_inventory_add_item(_str_item_id,_ct_count){

	//================//
	//VALIDATE REQUEST//
	//================//
	if (_ct_count <= 0){
		return;
	}

	if (
		!variable_global_exists("list_player_inventory") ||
		!ds_exists(global.list_player_inventory,ds_type_list)
	){

		scr_debug_log(
			"INVENTORY",
			"ADD",
			undefined,
			"ITEM ADD FAILED" +
			" | ITEM ID: " + string_upper(_str_item_id) +
			" | AMOUNT: " + string(_ct_count) +
			" | REASON: INVENTORY LIST INVALID",
			"ERROR",
			"SCR_INVENTORY_ADD_ITEM"
		);

		return;
	}

	//================//
	//GET ITEM DATA//
	//================//
	var _list_inventory = global.list_player_inventory;
	var _stct_base_item = scr_inventory_get_item_info(_str_item_id);

	if (_stct_base_item == undefined){

		scr_debug_log(
			"INVENTORY",
			"ADD",
			undefined,
			"ITEM ADD FAILED" +
			" | ITEM ID: " + string_upper(_str_item_id) +
			" | AMOUNT: " + string(_ct_count) +
			" | REASON: INVALID ITEM DATA",
			"ERROR",
			"SCR_INVENTORY_ADD_ITEM"
		);

		return;
	}

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

		if (_stct_check_item._str_item_id != _str_item_id){
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
	//NON-STACKABLE ITEMS//
	//=====================//
	if (!_stct_base_item._flag_stackable){

		for (var _it_item = 0;_it_item < _ct_count;_it_item++){

			var _stct_new_item = scr_inventory_get_item_info(
				_str_item_id
			);

			ds_list_add(
				_list_inventory,
				_stct_new_item
			);
		}

		global.ct_inventory_revision++;

		//================//
		//DEBUG ADDITION//
		//================//
		scr_debug_log(
			"INVENTORY",
			"ADD",
			undefined,
			"ITEM ADDED" +
			" | ITEM: " +
			string_upper(_stct_base_item._str_item_name) +
			" | ID: " +
			string_upper(_str_item_id) +
			" | TYPE: " +
			string_upper(_stct_base_item._str_item_type) +
			" | AMOUNT: +" +
			string(_ct_count) +
			" | OWNED: " +
			string(_ct_owned_before) +
			" -> " +
			string(_ct_owned_before + _ct_count) +
			" | INVENTORY ENTRIES: " +
			string(ds_list_size(_list_inventory)) +
			" | REVISION: " +
			string(global.ct_inventory_revision),
			"INFO",
			"SCR_INVENTORY_ADD_ITEM"
		);

		return;
	}

	//================//
	//STACKABLE ITEMS//
	//================//
	var _ct_remaining = _ct_count;

	//---------------------//
	//FILL EXISTING STACKS//
	//---------------------//
	for (var _it_item = 0;_it_item < ds_list_size(_list_inventory);_it_item++){

		if (_ct_remaining <= 0){
			break;
		}

		var _stct_item = ds_list_find_value(
			_list_inventory,
			_it_item
		);

		if (_stct_item == undefined){
			continue;
		}

		if (_stct_item._str_item_id != _str_item_id){
			continue;
		}

		var _ct_current = _stct_item._ct_item_amount;
		var _ct_maximum = _stct_item._ct_item_max_amount;

		if (_ct_current >= _ct_maximum){
			continue;
		}

		var _ct_space = _ct_maximum - _ct_current;
		var _ct_added = min(_ct_space,_ct_remaining);

		_stct_item._ct_item_amount = _ct_current + _ct_added;
		_ct_remaining -= _ct_added;

		ds_list_replace(
			_list_inventory,
			_it_item,
			_stct_item
		);
	}

	//------------------//
	//CREATE NEW STACKS//
	//------------------//
	while (_ct_remaining > 0){

		var _stct_new_stack = scr_inventory_get_item_info(
			_str_item_id
		);

		var _ct_maximum = _stct_new_stack._ct_item_max_amount;
		var _ct_added = min(_ct_maximum,_ct_remaining);

		_stct_new_stack._ct_item_amount = _ct_added;
		_ct_remaining -= _ct_added;

		ds_list_add(
			_list_inventory,
			_stct_new_stack
		);
	}

	//================//
	//UPDATE REVISION//
	//================//
	global.ct_inventory_revision++;

	//================//
	//DEBUG ADDITION//
	//================//
	scr_debug_log(
		"INVENTORY",
		"ADD",
		undefined,
		"ITEM ADDED" +
		" | ITEM: " +
		string_upper(_stct_base_item._str_item_name) +
		" | ID: " +
		string_upper(_str_item_id) +
		" | TYPE: " +
		string_upper(_stct_base_item._str_item_type) +
		" | AMOUNT: +" +
		string(_ct_count) +
		" | OWNED: " +
		string(_ct_owned_before) +
		" -> " +
		string(_ct_owned_before + _ct_count) +
		" | INVENTORY ENTRIES: " +
		string(ds_list_size(_list_inventory)) +
		" | REVISION: " +
		string(global.ct_inventory_revision),
		"INFO",
		"SCR_INVENTORY_ADD_ITEM"
	);
}