//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ADD_ITEM_STRUCT
// FUNCTION: Adds an existing item struct back into the player Inventory.
//           Preserves item UID and item-specific data.
//           Increments Inventory revision and logs the restored item.
//
// ARGUMENTS: _stct_item is the existing item struct to restore.
// RETURNS: True if the item was added, otherwise false.
//
//===============================================================================//

function scr_inventory_add_item_struct(_stct_item){

	//================//
	//VALIDATE ITEM//
	//================//
	if (_stct_item == undefined){
		return false;
	}

	if (
		!variable_global_exists("list_player_inventory") ||
		!ds_exists(global.list_player_inventory,ds_type_list)
	){

		scr_debug_log(
			"INVENTORY",
			"ADD",
			undefined,
			"ITEM STRUCT ADD FAILED" +
			" | ITEM: " +
			string_upper(_stct_item._str_item_name) +
			" | REASON: INVENTORY LIST INVALID",
			"ERROR",
			"SCR_INVENTORY_ADD_ITEM_STRUCT"
		);

		return false;
	}

	//================//
	//ADD ITEM STRUCT//
	//================//
	ds_list_add(
		global.list_player_inventory,
		_stct_item
	);

	//================//
	//UPDATE REVISION//
	//================//
	global.ct_inventory_revision++;

	//================//
	//DEBUG RESTORE//
	//================//
	scr_debug_log(
		"INVENTORY",
		"ADD",
		undefined,
		"ITEM RETURNED TO INVENTORY" +
		" | ITEM: " +
		string_upper(_stct_item._str_item_name) +
		" | ID: " +
		string_upper(_stct_item._str_item_id) +
		" | UID: " +
		string(_stct_item._uid_item) +
		" | AMOUNT: " +
		string(_stct_item._ct_item_amount) +
		" | INVENTORY ENTRIES: " +
		string(ds_list_size(global.list_player_inventory)) +
		" | REVISION: " +
		string(global.ct_inventory_revision),
		"INFO",
		"SCR_INVENTORY_ADD_ITEM_STRUCT"
	);

	return true;
}