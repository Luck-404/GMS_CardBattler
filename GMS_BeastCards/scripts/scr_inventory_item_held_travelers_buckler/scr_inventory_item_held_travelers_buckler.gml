//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_TRAVELERS_BUCKLER
// FUNCTION: Handles Traveler's Buckler Held Item behavior.
//
//           On battle ENTRY, grants 20 Armor to the holder through the
//           authoritative FIXED Armor-gain resolver.
//
//           Using SCR_BATTLE_ARMOR_TARGET preserves normal Armorbreak handling,
//           Armor presentation, debug logging, and hosted-Minion Armor-gain
//           reactions.
//
//           The item remains equipped after triggering.
//
// ARGUMENTS: _str_state - EQUIP, TRIGGER, or UNEQUIP.
//            _stct_item - Traveler's Buckler Held Item struct.
//            _ref_target - Persistent Beast struct for EQUIP/UNEQUIP, or the
//                          live battle Beast holder for TRIGGER.
// RETURNS: True when the requested state resolves successfully.
//
//===============================================================================//

function scr_inventory_item_held_travelers_buckler(_str_state,_stct_item,_ref_target){

	#region VALIDATION

	if (!is_struct(_stct_item)){
		return false;
	}

	#endregion

	#region HANDLE STATE

	switch (_str_state){

		case "EQUIP":

			return is_struct(_ref_target);

		case "TRIGGER":

			//================//
			//VALIDATE HOLDER//
			//================//
			if (!instance_exists(_ref_target)){
				return false;
			}

			if (
				_ref_target._str_list != "ALIVE" ||
				_ref_target._val_cur_hp <= 0
			){
				return false;
			}

			//================//
			//GAIN 20 ARMOR//
			//================//
			return scr_battle_armor_target(
				"FIXED",
				20,
				_ref_target
			);

		case "UNEQUIP":

			return is_struct(_ref_target);
	}

	#endregion

	return false;
}