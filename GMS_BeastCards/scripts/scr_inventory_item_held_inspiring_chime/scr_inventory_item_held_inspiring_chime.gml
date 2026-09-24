//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_INSPIRING_CHIME
// FUNCTION: Handles Inspiring Chime held item behavior.
//           EQUIP increases overworld movement speed by 15%.
//           UNEQUIP removes the 15% movement speed bonus.
//
// ARGUMENTS: _str_state is the held-item behavior state.
//            _stct_item is the item struct and _stct_target_unit is the holder.
// RETURNS: True when the requested behavior succeeds, otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_inspiring_chime(_str_state,_stct_item,_stct_target_unit){

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

			global.val_bonus_speed_scalar += 0.15;

			scr_gui_spawn_popup_trigger_banner(
				"EQUIPPED: INSPIRING CHIME +15% MOVE SPEED"
			);

			return true;

		case "UNEQUIP":

			global.val_bonus_speed_scalar -= 0.15;

			scr_gui_spawn_popup_trigger_banner(
				"UNEQUIPPED: INSPIRING CHIME -15% MOVE SPEED"
			);

			return true;
	}

	return false;
}