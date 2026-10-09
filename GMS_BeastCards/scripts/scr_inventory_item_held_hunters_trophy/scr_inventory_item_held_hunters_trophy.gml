//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_HUNTERS_TROPHY
// FUNCTION: Handles Hunter's Trophy Held Item behavior.
//
//           TRIGGER contributes +16 percentage points to the normal 4% Elite
//           encounter chance, producing 20% total.
//
//           Successful Elites are Risk Tier 1.
//
//           RISK TIER 1:
//           - Universal Elite seven-primary-stat bonus: +20% instead of +10%.
//           - Universal final Maximum HP bonus: +50% instead of +25%.
//           - Attack damage instances gain +5 Linear damage before mitigation.
//           - Reward quality multiplier: 1.25x for rare Card rarity weights and
//             rarer Item channels.
//
//           Team uniqueness / mutual exclusivity with Challenger's Bell is enforced
//           centrally by SCR_INVENTORY_CAN_EQUIP_UNIQUE_HELD_ITEM.
//
//===============================================================================//
function scr_inventory_item_held_hunters_trophy(_str_state,_stct_item,_stct_target_unit){

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
				_val_elite_chance_bonus : 16,
				_val_elite_risk_tier : 1
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