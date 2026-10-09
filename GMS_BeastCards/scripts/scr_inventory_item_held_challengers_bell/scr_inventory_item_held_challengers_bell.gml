//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_CHALLENGERS_BELL
// FUNCTION: Handles Challenger's Bell Held Item behavior.
//
//           TRIGGER contributes +6 percentage points to the normal 4% Elite
//           encounter chance, producing 10% total.
//
//           Challenger's Bell produces Risk Tier 0 Elites.
//
//           Team uniqueness / mutual exclusivity with Hunter's Trophy is enforced
//           centrally by SCR_INVENTORY_CAN_EQUIP_UNIQUE_HELD_ITEM.
//
//===============================================================================//
function scr_inventory_item_held_challengers_bell(_str_state,_stct_item,_stct_target_unit){

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
				_val_elite_chance_bonus : 6,
				_val_elite_risk_tier : 0
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