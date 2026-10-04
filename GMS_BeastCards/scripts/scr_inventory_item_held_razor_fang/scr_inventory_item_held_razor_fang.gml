//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_RAZOR_FANG
// FUNCTION: Applies or removes Razor Fang held item effects.
//           EQUIP adds 10 Critical Hit Damage.
//           UNEQUIP removes the Critical Hit Damage bonus.
//
//===============================================================================//

function scr_inventory_item_held_razor_fang(_str_state,_stct_item,_stct_target_unit){

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
			"_val_beast_crit_dmg_stat"
		)
	){
		return false;
	}

	#endregion

	#region HANDLE STATE

	switch (_str_state){

		case "EQUIP":

			_stct_target_unit._val_beast_crit_dmg_stat +=
				10;

			return true;

		case "UNEQUIP":

			_stct_target_unit._val_beast_crit_dmg_stat =
				max(
					0,
					_stct_target_unit._val_beast_crit_dmg_stat -
					10
				);

			return true;
	}

	#endregion

	return false;
}