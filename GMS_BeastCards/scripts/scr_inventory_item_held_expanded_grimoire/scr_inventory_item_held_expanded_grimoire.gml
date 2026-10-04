//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_EXPANDED_GRIMOIRE
// FUNCTION: Held Item state handler for Expanded Grimoire.
//
//           The item's gameplay effect is read by the authoritative player
//           team-rule helper during battle/deck setup. No reactive trigger is
//           executed.
//
// ARGUMENTS: _str_state - EQUIP or UNEQUIP.
//            _stct_item - Held Item struct.
//            _stct_target - Persistent Beast holder.
// RETURNS: True for valid EQUIP/UNEQUIP requests.
//
//===============================================================================//

function scr_inventory_item_held_expanded_grimoire(_str_state,_stct_item,_stct_target){

	if (!is_struct(_stct_item)){
		return false;
	}

	switch (_str_state){

		case "EQUIP":
		case "UNEQUIP":
			return is_struct(_stct_target);
	}

	return false;
}