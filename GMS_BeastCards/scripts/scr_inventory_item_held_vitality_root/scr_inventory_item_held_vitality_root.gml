//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_VITALITY_ROOT
// FUNCTION: Applies or removes Vitality Root held item effects.
//
//           EQUIP adds 20 HP Stat.
//           UNEQUIP removes the 20 HP Stat bonus.
//
//           After the HP Stat changes, Maximum HP is recalculated through
//           SCR_BEAST_SET_LEVEL using the Beast's existing Level.
//
//           Current HP percentage is preserved when Maximum HP changes.
//
// ARGUMENTS: _str_state is the held-item behavior state.
//            _stct_item is the item struct.
//            _stct_target_unit is the holder.
//
// RETURNS: True when the requested behavior succeeds, otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_vitality_root(_str_state,_stct_item,_stct_target_unit){

	#region VALIDATION

	//================//
	//VALIDATE ITEM//
	//================//
	if (_stct_item == undefined){
		return false;
	}

	//================//
	//VALIDATE HOLDER//
	//================//
	if (!is_struct(_stct_target_unit)){
		return false;
	}

	if (
		!variable_struct_exists(
			_stct_target_unit,
			"_val_beast_hp_stat"
		) ||
		!variable_struct_exists(
			_stct_target_unit,
			"_val_beast_level"
		) ||
		!variable_struct_exists(
			_stct_target_unit,
			"_val_beast_hp_max"
		) ||
		!variable_struct_exists(
			_stct_target_unit,
			"_val_beast_hp_cur"
		)
	){
		return false;
	}

	#endregion

	#region HANDLE STATE

	switch (_str_state){

		//=====//
		//EQUIP//
		//=====//
		case "EQUIP":

			_stct_target_unit._val_beast_hp_stat +=
				20;

			scr_beast_set_level(
				_stct_target_unit,
				_stct_target_unit._val_beast_level,
				false
			);

			return true;

		//=======//
		//UNEQUIP//
		//=======//
		case "UNEQUIP":

			_stct_target_unit._val_beast_hp_stat =
				max(
					0,
					_stct_target_unit
						._val_beast_hp_stat -
					20
				);

			scr_beast_set_level(
				_stct_target_unit,
				_stct_target_unit._val_beast_level,
				false
			);

			return true;
	}

	#endregion

	return false;
}