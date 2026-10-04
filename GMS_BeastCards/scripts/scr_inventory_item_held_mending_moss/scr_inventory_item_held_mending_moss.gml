//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_MENDING_MOSS
// FUNCTION: Handles Mending Moss Held Item behavior.
//
//           At Turn End, heals the living holder for 5 HP through the
//           authoritative FIXED healing resolver.
//
// ARGUMENTS: _str_state - EQUIP, TRIGGER, or UNEQUIP.
//            _stct_item - Mending Moss Held Item struct.
//            _ref_target - Persistent Beast struct for EQUIP/UNEQUIP, or the
//                          live battle Beast holder for TRIGGER.
// RETURNS: True when the requested state resolves successfully.
//
//===============================================================================//

function scr_inventory_item_held_mending_moss(_str_state,_stct_item,_ref_target){

	if (!is_struct(_stct_item)){
		return false;
	}

	switch (_str_state){

		case "EQUIP":
		case "UNEQUIP":
			return is_struct(_ref_target);

		case "TRIGGER":

			if (
				!instance_exists(_ref_target) ||
				_ref_target._str_list != "ALIVE" ||
				_ref_target._val_cur_hp <= 0 ||
				_ref_target._val_cur_hp >= _ref_target._val_max_hp
			){
				return false;
			}

			return scr_battle_heal_target(
				"FIXED",
				5,
				_ref_target
			);
	}

	return false;
}