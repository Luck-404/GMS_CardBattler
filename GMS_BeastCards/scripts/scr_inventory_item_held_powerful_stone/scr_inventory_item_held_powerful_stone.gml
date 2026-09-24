//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_POWERFUL_STONE
// FUNCTION: Applies or removes Powerful Stone held item effects.
//           EQUIP adds 20 Physical Power.
//           UNEQUIP removes the Physical Power bonus.
//
// ARGUMENTS: _str_state is the held-item behavior state.
//            _stct_item is the item struct and _stct_target_unit is the holder.
// RETURNS: True when the requested behavior succeeds, otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_powerful_stone(_str_state,_stct_item,_stct_target_unit){

	//================//
	//VALIDATE ITEM//
	//================//
	if (_stct_item == undefined){
		return false;
	}

	if (_stct_target_unit == undefined){
		return false;
	}

	//================//
	//HANDLE STATE//
	//================//
	switch (_str_state){

		case "EQUIP":

			_stct_target_unit._val_beast_ppow_stat += 20;

			return true;

		case "UNEQUIP":

			_stct_target_unit._val_beast_ppow_stat -= 20;

			if (_stct_target_unit._val_beast_ppow_stat < 0){
				_stct_target_unit._val_beast_ppow_stat = 0;
			}

			return true;
	}

	return false;
}