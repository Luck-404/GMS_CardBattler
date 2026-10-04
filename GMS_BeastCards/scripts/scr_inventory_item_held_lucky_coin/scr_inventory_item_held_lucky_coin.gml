//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_LUCKY_COIN
// FUNCTION: Handles Lucky Coin Held Item behavior.
//
//           EQUIP / UNEQUIP require no persistent stat changes.
//
//           TRIGGER adds +5 percentage points to every normal optional battle
//           reward chance: second Material, Egg, Beast Card, Zone Card, and
//           normal Beast/Zone Item.
//
//           Secret Zone Item and Global Bonus Card chances are not modified.
//           Multiple Lucky Coins stack additively through the RESOURCE Held
//           Item reward pipeline. Final chances are capped at 100%.
//
// ARGUMENTS: _str_state is the Held Item behavior state.
//            _stct_item is the Held Item struct.
// RETURNS: True for EQUIP/UNEQUIP.
//          Resource modifier struct for TRIGGER.
//          False for invalid states.
//
//===============================================================================//

function scr_inventory_item_held_lucky_coin(_str_state,_stct_item){

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
				_val_all_optional_chance_bonus : 5
			};

		case "UNEQUIP":
			return true;
	}

	#endregion

	return false;
}
