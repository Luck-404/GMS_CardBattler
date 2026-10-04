//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_AMPLIFYING_BELL
// FUNCTION: Handles Amplifying Bell Held Item behavior.
//
//           Unique (1 per team).
//           The one-per-team equip rule is enforced centrally by
//           SCR_INVENTORY_EQUIP_HELD_ITEM using _flag_unique_team.
//
//           TRIGGER returns +1 Buff magnitude. SCR_STATUS_APPLY_BUFF applies
//           that modifier only to eligible stackable, magnitude-bearing Buffs.
//           Unstackable, binary, and charge-based Buffs remain unchanged.
//
// ARGUMENTS: _str_state - EQUIP, TRIGGER, or UNEQUIP.
//            _stct_item - Amplifying Bell Item struct.
//            _stct_target_unit - Persistent Beast holder for EQUIP/UNEQUIP.
// RETURNS: True for EQUIP/UNEQUIP, modifier struct for TRIGGER, otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_amplifying_bell(_str_state,_stct_item,_stct_target_unit=undefined){

	#region VALIDATION

	if (!is_struct(_stct_item)){
		return false;
	}

	#endregion

	#region HANDLE STATE

	switch (_str_state){

		case "EQUIP":

			if (!is_struct(_stct_target_unit)){
				return false;
			}

			return true;

		case "TRIGGER":

			return {
				_val_buff_magnitude_bonus : 1
			};

		case "UNEQUIP":

			if (!is_struct(_stct_target_unit)){
				return false;
			}

			return true;
	}

	#endregion

	return false;
}
