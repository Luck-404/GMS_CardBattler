//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_FORGOTTEN_MANUSCRIPT
// FUNCTION: Handles Forgotten Manuscript Held Item behavior.
//           The item's battle effect is derived from active Party Held Items
//           when the player battle controller initializes.
//
// ARGUMENTS: _str_state is the Held Item behavior state.
//            _stct_item is the Held Item struct.
//            _stct_target_unit is the Beast holding the item.
// RETURNS: True for successful equip/unequip operations.
//
//===============================================================================//

function scr_inventory_item_held_forgotten_manuscript(_str_state,_stct_item,_stct_target_unit){

	//================//
	//VALIDATE//
	//================//
	if (!is_struct(_stct_item) || !is_struct(_stct_target_unit)){
		return false;
	}

	//================//
	//HANDLE STATE//
	//================//
	switch(_str_state){

		case "EQUIP":
		case "UNEQUIP":
			return true;
	}

	return false;
}