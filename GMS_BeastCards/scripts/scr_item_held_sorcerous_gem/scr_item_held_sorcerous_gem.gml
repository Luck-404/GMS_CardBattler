//===============================================================================//
//
// SCRIPT: SCR_ITEM_HELD_SORCEROUS_GEM
// FUNCTION: Applies or removes Sorcerous Gem held item effects.
//           EQUIP adds magical power.
//           UNEQUIP removes the magical power bonus.
//
//===============================================================================//
function scr_item_held_sorcerous_gem(_str_state,_stct_item,_stct_target_unit){

	if (_stct_target_unit == undefined){
		return false;
	}

	switch(_str_state){

		case "EQUIP":
			_stct_target_unit._val_beast_mpow_stat += 20;
			return true;
		break;

		case "UNEQUIP":
			_stct_target_unit._val_beast_mpow_stat -= 20;

			if (_stct_target_unit._val_beast_mpow_stat < 0){
				_stct_target_unit._val_beast_mpow_stat = 0;
			}

			return true;
		break;
	}

	return false;
}