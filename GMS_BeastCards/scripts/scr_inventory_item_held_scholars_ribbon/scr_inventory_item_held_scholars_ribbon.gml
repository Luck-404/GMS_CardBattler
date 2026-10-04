//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_SCHOLARS_RIBBON
// FUNCTION: Handles Scholar's Ribbon Held Item behavior.
//
//           EQUIP / UNEQUIP require no persistent stat changes.
//
//           TRIGGER returns a flat +2 EXP bonus. The battle reward resolver
//           applies that bonus only to the surviving Beast holding this item.
//
// ARGUMENTS: _str_state is the Held Item behavior state.
//            _stct_item is the Held Item struct.
// RETURNS: True for EQUIP/UNEQUIP.
//          Holder-specific EXP modifier struct for TRIGGER.
//          False for invalid states.
//
//===============================================================================//

function scr_inventory_item_held_scholars_ribbon(_str_state,_stct_item){

	#region VALIDATION

	if (!is_struct(_stct_item)){
		return false;
	}

	#endregion

	#region HANDLE STATE

	switch (_str_state){

		case "EQUIP":
			return true;

		case "TRIGGER":

			return {
				_ct_exp_holder_bonus : 2
			};

		case "UNEQUIP":
			return true;
	}

	#endregion

	return false;
}