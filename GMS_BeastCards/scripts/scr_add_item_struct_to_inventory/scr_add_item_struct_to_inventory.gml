//===============================================================================//
//
// SCRIPT: SCR_ADD_ITEM_STRUCT_TO_INVENTORY
// FUNCTION: Adds an existing item struct back into the player inventory.
//           Preserves item uid and any future item-specific data.
//           Increments inventory revision when successful.
//
//===============================================================================//
function scr_add_item_struct_to_inventory(_stct_item){

	if (_stct_item == undefined){
		return false;
	}

	ds_list_add(global.list_player_inventory,_stct_item);

	global.ct_inventory_revision++;

	return true;
}