//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_BOLSTERING_SHELL
// FUNCTION: Handles Bolstering Shell held item behavior.
//           Grants 3 Armor to the holder at the end of its team's turn.
//           Remains active for the entire battle and is not consumed.
//
// ARGUMENTS: _str_state is the held-item behavior state.
//            _stct_item is the item struct and _ref_target is the holder.
// RETURNS: True when the requested behavior succeeds, otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_bolstering_shell(_str_state,_stct_item,_ref_target){

	//================//
	//VALIDATE ITEM//
	//================//
	if (_stct_item == undefined){
		return false;
	}

	//================//
	//HANDLE STATE//
	//================//
	switch (_str_state){

		case "EQUIP":
			return true;

		case "TRIGGER":

			//----------------//
			//VALIDATE HOLDER//
			//----------------//
			if (!instance_exists(_ref_target)){
				return false;
			}

			if (_ref_target._val_cur_hp <= 0){
				return false;
			}

			//----------------//
			//GRANT ARMOR//
			//----------------//
			scr_battle_armor_target(
				"FIXED",
				3,
				_ref_target
			);


			scr_gui_spawn_popup_trigger_banner(_stct_item._str_item_name);

			return true;

		case "UNEQUIP":
			return true;
	}

	return false;
}