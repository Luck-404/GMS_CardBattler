//===============================================================================//
//
// SCRIPT: SCR_ITEM_HELD_POWERFUL_STONE
// FUNCTION: Applies or removes Powerful Stone held item effects.
//           EQUIP adds physical power.
//           UNEQUIP removes the physical power bonus.
//
//===============================================================================//
function scr_item_held_powerful_stone(_str_state,_stct_item,_stct_target_unit){

	if (_stct_target_unit == undefined){
		return false;
	}

	switch(_str_state){

		case "EQUIP":
			_stct_target_unit._val_beast_ppow_stat += 20;
			return true;
		break;

		case "UNEQUIP":
			_stct_target_unit._val_beast_ppow_stat -= 20;

			if (_stct_target_unit._val_beast_ppow_stat < 0){
				_stct_target_unit._val_beast_ppow_stat = 0;
			}

			return true;
		break;
	}

	return false;
}