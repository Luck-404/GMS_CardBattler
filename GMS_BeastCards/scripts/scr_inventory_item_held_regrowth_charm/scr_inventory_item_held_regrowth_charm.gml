//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_REGROWTH_CHARM
// FUNCTION: Handles Regrowth Charm Held Item behavior.
//
//           At Turn End, heals the living holder for 3% of its current Maximum
//           HP through the authoritative FIXED healing resolver.
//
//           The percentage is converted to a raw healing amount at trigger time.
//           Minimum healing is 1 HP.
//
// ARGUMENTS: _str_state - EQUIP, TRIGGER, or UNEQUIP.
//            _stct_item - Regrowth Charm Held Item struct.
//            _ref_target - Persistent Beast struct for EQUIP/UNEQUIP, or the
//                          live battle Beast holder for TRIGGER.
// RETURNS: True when the requested state resolves successfully.
//
//===============================================================================//

function scr_inventory_item_held_regrowth_charm(_str_state,_stct_item,_ref_target){

	if (!is_struct(_stct_item)){
		return false;
	}

	switch (_str_state){

		case "EQUIP":
		case "UNEQUIP":
			return is_struct(_ref_target);

		case "TRIGGER":

			if (
				!instance_exists(_ref_target) ||
				_ref_target._str_list != "ALIVE" ||
				_ref_target._val_cur_hp <= 0 ||
				_ref_target._val_cur_hp >= _ref_target._val_max_hp
			){
				return false;
			}

			var _val_healing =
				max(
					1,
					ceil(
						_ref_target._val_max_hp *
						0.03
					)
				);

			return scr_battle_heal_target(
				"FIXED",
				_val_healing,
				_ref_target
			);
	}

	return false;
}