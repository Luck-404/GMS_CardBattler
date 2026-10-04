//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_CERULEAN_INCENSE
// FUNCTION: Handles Cerulean Incense held item behavior.
//
//           EQUIP / UNEQUIP require no persistent stat changes.
//
//           TRIGGER returns encounter-weight configuration used by
//           SCR_OVERWORLD_APPLY_ENCOUNTER_HELD_ITEMS.
//
//           One extra pool entry is added for each valid Cerulean Beast,
//           effectively doubling its existing encounter weight.
//
// ARGUMENTS: _str_state is the held-item behavior state.
//            _stct_item is the item struct.
//            _stct_target_unit is the persistent Beast holding the item.
//
// RETURNS: True for successful EQUIP/UNEQUIP.
//          Encounter modifier struct for TRIGGER.
//          False for invalid states.
//
//===============================================================================//

function scr_inventory_item_held_cerulean_incense(_str_state,_stct_item,_stct_target_unit){

	#region VALIDATION

	if (!is_struct(_stct_item)){
		return false;
	}

	#endregion

	#region HANDLE STATE

	switch (_str_state){

		//=====//
		//EQUIP//
		//=====//
		case "EQUIP":

			if (!is_struct(_stct_target_unit)){
				return false;
			}

			return true;

		//=======//
		//TRIGGER//
		//=======//
		case "TRIGGER":

			return {
				_str_encounter_color : "CERULEAN",
				_ct_extra_pool_entries : 1
			};

		//=======//
		//UNEQUIP//
		//=======//
		case "UNEQUIP":

			if (!is_struct(_stct_target_unit)){
				return false;
			}

			return true;
	}

	#endregion

	return false;
}