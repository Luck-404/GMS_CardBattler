//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_VERDANT_LENS
// FUNCTION: Handles Verdant Lens Held Item behavior.
//
//           EQUIP / UNEQUIP require no persistent stat changes.
//
//           TRIGGER returns a +2 base Card-magnitude modifier for qualifying
//           Viridian Attack Cards.
//           SCR_BATTLE_GET_HELD_CARD_MAGNITUDE_BONUS applies the modifier only to
//           LINEAR/PERCENT Attack-card magnitude during the Card callback.
//
// ARGUMENTS: _str_state is the Held Item behavior state.
//            _stct_item is the Held Item struct.
//            _stct_target_unit is the persistent Beast holding the item.
// RETURNS: True for successful EQUIP/UNEQUIP.
//          Card-magnitude modifier struct for TRIGGER.
//          False for invalid states.
//
//===============================================================================//

function scr_inventory_item_held_verdant_lens(_str_state,_stct_item,_stct_target_unit){

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
				_str_card_color : "VIRIDIAN",
				_val_card_magnitude_bonus : 2
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
