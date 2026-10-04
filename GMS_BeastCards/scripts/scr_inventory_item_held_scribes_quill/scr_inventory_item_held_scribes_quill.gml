//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_SCRIBES_QUILL
// FUNCTION: Handles Scribe's Quill Held Item behavior.
//
//           EQUIP / UNEQUIP require no persistent stat changes.
//
//           TRIGGER returns +10 percentage points to both the Beast Card and
//           Zone Card reward rolls. Multiple Quills stack through the reward
//           resolver, with final reward chances capped at 100%.
//
// ARGUMENTS: _str_state is the Held Item behavior state.
//            _stct_item is the Held Item struct.
// RETURNS: True for EQUIP/UNEQUIP.
//          Resource modifier struct for TRIGGER.
//          False for invalid states.
//
//===============================================================================//

function scr_inventory_item_held_scribes_quill(_str_state,_stct_item){

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
				_val_beast_card_chance_bonus : 10,
				_val_zone_card_chance_bonus : 10
			};

		case "UNEQUIP":
			return true;
	}

	#endregion

	return false;
}