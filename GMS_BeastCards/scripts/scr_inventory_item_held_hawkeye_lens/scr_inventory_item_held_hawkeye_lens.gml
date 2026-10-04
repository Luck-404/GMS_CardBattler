//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_HAWKEYE_LENS
// FUNCTION: Applies or removes Hawkeye Lens held item effects.
//           EQUIP adds 5 Critical Hit Chance.
//           UNEQUIP removes the Critical Hit Chance bonus.
//
//===============================================================================//

function scr_inventory_item_held_hawkeye_lens(_str_state,_stct_item,_stct_target_unit){

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
			"_val_beast_crit_stat"
		)
	){
		return false;
	}

	#endregion

	#region HANDLE STATE

	switch (_str_state){

		case "EQUIP":

			_stct_target_unit._val_beast_crit_stat +=
				5;

			return true;

		case "UNEQUIP":

			_stct_target_unit._val_beast_crit_stat =
				max(
					0,
					_stct_target_unit._val_beast_crit_stat -
					5
				);

			return true;
	}

	#endregion

	return false;
}