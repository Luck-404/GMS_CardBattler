//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_BROOD_TOTEM
// FUNCTION: Applies or removes Brood Totem held item effects.
//           EQUIP adds 1 Minion Slot.
//           UNEQUIP removes the Minion Slot bonus.
//
//===============================================================================//

function scr_inventory_item_held_brood_totem(_str_state,_stct_item,_stct_target_unit){

	#region VALIDATION

	if (_stct_item == undefined){
		return false;
	}

	if (!is_struct(_stct_target_unit)){
		return false;
	}

	if (
		!variable_struct_exists(
			_stct_target_unit,
			"_val_beast_min_stat"
		)
	){
		return false;
	}

	#endregion

	#region HANDLE STATE

	switch (_str_state){

		case "EQUIP":

			_stct_target_unit._val_beast_min_stat +=
				1;

			return true;

		case "UNEQUIP":

			_stct_target_unit._val_beast_min_stat =
				max(
					0,
					_stct_target_unit._val_beast_min_stat -
					1
				);

			return true;
	}

	#endregion

	return false;
}