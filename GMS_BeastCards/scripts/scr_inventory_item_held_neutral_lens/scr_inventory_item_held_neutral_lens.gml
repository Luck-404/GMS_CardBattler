//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_NEUTRAL_LENS
// FUNCTION: Handles Neutral Lens Held Item behavior.
//
//           EQUIP / UNEQUIP require no persistent stat changes.
//
//           TRIGGER returns a +2 base Card-magnitude modifier for qualifying
//           Uncolored Attack Cards.
//
//           SCR_BATTLE_GET_HELD_CARD_MAGNITUDE_BONUS applies the modifier only
//           to qualifying Attack-card base magnitude during Card resolution.
//
//           Neutral Lens is NOT Unique.
//
// ARGUMENTS: _str_state - EQUIP, TRIGGER, or UNEQUIP.
//            _stct_item - Neutral Lens Item struct.
//            _stct_target_unit - Persistent Beast holder.
// RETURNS: True for EQUIP/UNEQUIP, modifier struct for TRIGGER, otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_neutral_lens(_str_state,_stct_item,_stct_target_unit){

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
				_str_card_color : "UNCOLORED",
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
