//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_BLIGHT_VIAL
// FUNCTION: Handles Blight Vial Held Item behavior.
//
//           Unique (1 per team).
//           The one-per-team equip rule is enforced centrally by
//           SCR_INVENTORY_EQUIP_HELD_ITEM using _flag_unique_team.
//
//           TRIGGER returns +1 DoT stack application. SCR_STATUS_APPLY_DOT
//           resolves the extra stack through the shared Blight Vial pipeline.
//
// ARGUMENTS: _str_state - EQUIP, TRIGGER, or UNEQUIP.
//            _stct_item - Blight Vial Item struct.
//            _stct_target_unit - Persistent Beast holder for EQUIP/UNEQUIP.
// RETURNS: True for EQUIP/UNEQUIP, modifier struct for TRIGGER, otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_blight_vial(_str_state,_stct_item,_stct_target_unit=undefined){

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
				_ct_dot_stack_bonus : 1
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
