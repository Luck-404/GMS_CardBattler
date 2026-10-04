//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_ARCHMAGES_FOCUS
// FUNCTION: Handles Archmage's Focus Held Item behavior.
//
//           Unique (1 per team).
//           The one-per-team equip rule is enforced centrally by
//           SCR_INVENTORY_EQUIP_HELD_ITEM using _flag_unique_team.
//
//           The battle effect is derived from active Party Held Items when
//           SCR_BATTLE_GET_PLAYER_CARD_FLOW_RULES initializes Card-flow rules.
//           Archmage's Focus increases beginning-of-turn draw by 1.
//
// ARGUMENTS: _str_state - EQUIP or UNEQUIP.
//            _stct_item - Archmage's Focus Item struct.
//            _stct_target_unit - Persistent Beast holder.
// RETURNS: True for valid EQUIP/UNEQUIP operations, otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_archmages_focus(_str_state,_stct_item,_stct_target_unit){

	#region VALIDATION

	if (!is_struct(_stct_item)){
		return false;
	}

	if (!is_struct(_stct_target_unit)){
		return false;
	}

	#endregion

	#region HANDLE STATE

	switch (_str_state){

		case "EQUIP":
		case "UNEQUIP":
			return true;
	}

	#endregion

	return false;
}
