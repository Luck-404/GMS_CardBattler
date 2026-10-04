//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_COLLECTORS_SEAL
// FUNCTION: Handles Collector's Seal Held Item behavior.
//
//           EQUIP / UNEQUIP require no persistent stat changes.
//
//           TRIGGER adds +10 percentage points to the normal Beast/Zone Item
//           reward chance after victorious battles.
//
//           Multiple Collector's Seals stack additively through the RESOURCE
//           Held Item reward pipeline. Final Item chance is capped at 100%.
//
// ARGUMENTS: _str_state is the Held Item behavior state.
//            _stct_item is the Held Item struct.
// RETURNS: True for EQUIP/UNEQUIP.
//          Resource modifier struct for TRIGGER.
//          False for invalid states.
//
//===============================================================================//

function scr_inventory_item_held_collectors_seal(_str_state,_stct_item){

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
				_val_bonus_item_chance_bonus : 10
			};

		case "UNEQUIP":
			return true;
	}

	#endregion

	return false;
}
