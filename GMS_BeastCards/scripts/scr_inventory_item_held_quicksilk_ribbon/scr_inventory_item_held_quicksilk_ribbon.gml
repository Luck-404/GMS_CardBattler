//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_QUICKSILK_RIBBON
// FUNCTION: Applies or removes Quicksilk Ribbon held item effects.
//           EQUIP adds 5 Dodge Chance.
//           UNEQUIP removes the Dodge Chance bonus.
//
//===============================================================================//

function scr_inventory_item_held_quicksilk_ribbon(_str_state,_stct_item,_stct_target_unit){

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
			"_val_beast_dod_stat"
		)
	){
		return false;
	}

	#endregion

	#region HANDLE STATE

	switch (_str_state){

		case "EQUIP":

			_stct_target_unit._val_beast_dod_stat +=
				5;

			return true;

		case "UNEQUIP":

			_stct_target_unit._val_beast_dod_stat =
				max(
					0,
					_stct_target_unit._val_beast_dod_stat -
					5
				);

			return true;
	}

	#endregion

	return false;
}