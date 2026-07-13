//===============================================================================//
//
// SCRIPT: SCR_ITEM_HELD_BOLSTERING_SHELL
// FUNCTION: Handles Bolstering Shell held item behavior.
//           Grants 3 Armor to the holder at the end of its team's turn.
//           Remains active for the entire battle and is not consumed.
//
//===============================================================================//

function scr_item_held_bolstering_shell(_str_state,_stct_item,_ref_target){

	if (_stct_item == undefined){
		return false;
	}

	switch(_str_state){

		case "EQUIP":
			return true;
		break;

		case "TRIGGER":

			if (!instance_exists(_ref_target)){
				return false;
			}

			if (_ref_target._val_cur_hp <= 0){
				return false;
			}

			scr_armor_target(3,_ref_target);

			scr_spawn_popup_trigger_banner(_stct_item._str_item_name);

			return true;

		break;

		case "UNEQUIP":
			return true;
		break;
	}

	return false;
}