//===============================================================================//
//
// SCRIPT: SCR_ITEM_HELD_INSPIRING_CHIME
// FUNCTION: Applies or removes Inspiring Chime held item effects.
//           EQUIP does nothing.
//           UNEQUIP does nothing.
//
//===============================================================================//
function scr_item_held_inspiring_chime(_str_state,_stct_item,_stct_target_unit){

	if (_stct_target_unit == undefined){
		return false;
	}

	switch(_str_state){

		case "EQUIP":
			global._val_bonus_speed_scalar += 0.15;
			scr_spawn_popup_trigger_banner("EQUIPPED: INSPIRING CHIME +15% MOVE SPEED");
			return true;
		break;

		case "UNEQUIP":
			global._val_bonus_speed_scalar -= 0.15;
			scr_spawn_popup_trigger_banner("UNEQUIPPED: INSPIRING CHIME -15% MOVE SPEED");
			return true;
		break;
	}

	return false;
}