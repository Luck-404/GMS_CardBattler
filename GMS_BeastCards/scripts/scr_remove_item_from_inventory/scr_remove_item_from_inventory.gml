//===============================================================================//
//
// SCRIPT: SCR_REMOVE_ITEM_FROM_INVENTORY
// FUNCTION: Removes item amount from the player inventory.
//           Supports stackable and non-stackable item structs.
//           Increments inventory revision when inventory changes.
//
//===============================================================================//
function scr_remove_item_from_inventory(_stct_item,_ct_amount){

	if (_stct_item == undefined){
		return false;
	}

	if (_ct_amount <= 0){
		return false;
	}

	var _list_inventory = global.list_player_inventory;
	var _ct_remaining = _ct_amount;
	var _flag_changed = false;

	//--------------------//
	//STACKABLE ITEM REMOVE//
	//--------------------//
	if (_stct_item._flag_stackable){

		for (var _it_item = 0; _it_item < ds_list_size(_list_inventory); _it_item++){

			if (_ct_remaining <= 0){
				break;
			}

			var _stct_check_item = ds_list_find_value(_list_inventory,_it_item);

			if (_stct_check_item == undefined){
				continue;
			}

			if (_stct_check_item._uid_item != _stct_item._uid_item){
				continue;
			}

			var _ct_remove = min(_ct_remaining,_stct_check_item._ct_item_amount);

			_stct_check_item._ct_item_amount -= _ct_remove;
			_ct_remaining -= _ct_remove;
			_flag_changed = true;

			if (_stct_check_item._ct_item_amount <= 0){
				ds_list_delete(_list_inventory,_it_item);
				_it_item--;
			}
			else{
				ds_list_replace(_list_inventory,_it_item,_stct_check_item);
			}
		}
	}
	
	//-----------------------//
	//NONSTACKABLE ITEM REMOVE//
	//-----------------------//
	else{

		for (var _it_item = 0; _it_item < ds_list_size(_list_inventory); _it_item++){

			var _stct_check_item = ds_list_find_value(_list_inventory,_it_item);

			if (_stct_check_item == undefined){
				continue;
			}

			if (_stct_check_item._uid_item == _stct_item._uid_item){
				ds_list_delete(_list_inventory,_it_item);
				_ct_remaining--;
				_flag_changed = true;
				break;
			}
		}
	}

	if (_flag_changed){
		global.ct_inventory_revision++;
	}

	return _flag_changed;
}