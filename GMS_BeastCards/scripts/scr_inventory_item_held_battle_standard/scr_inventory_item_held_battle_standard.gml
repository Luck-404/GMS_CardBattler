//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_BATTLE_STANDARD
// FUNCTION: Handles Battle Standard Held Item behavior.
//
//           On battle ENTRY, applies 1 stack of BOOST to the holder.
//
//           BOOST uses its current standard magnitude:
//               +10% outgoing damage per stack.
//
//           Battle Standard applies the Buff with a lifetime of 3 turns.
//           The item remains equipped after triggering.
//
// ARGUMENTS: _str_state - EQUIP, TRIGGER, or UNEQUIP.
//            _stct_item - Battle Standard Held Item struct.
//            _ref_target - Persistent Beast struct for EQUIP/UNEQUIP, or the
//                          live battle Beast instance for TRIGGER.
// RETURNS: True when the requested state resolves successfully.
//
//===============================================================================//

function scr_inventory_item_held_battle_standard(_str_state,_stct_item,_ref_target){

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
			//APPLY BOOST//
			//================//
			var _ref_boost =
				scr_status_apply_buff(
					"BOOST",
					_ref_target,
					10,
					3
				);

			return instance_exists(_ref_boost);

		case "UNEQUIP":

			return is_struct(_ref_target);
	}

	#endregion

	return false;
}