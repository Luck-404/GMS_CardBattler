//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_POCKET_HIVE
// FUNCTION: Handles Pocket Hive Held Item behavior.
//
//           On battle ENTRY, attempts to summon up to 3 Wasp Drones on the
//           holder.
//
//           Summoning stops immediately when the holder has no open Minion slot.
//           Pocket Hive never replaces an existing Minion.
//
//           The item remains equipped after triggering.
//
// ARGUMENTS: _str_state - EQUIP, TRIGGER, or UNEQUIP.
//            _stct_item - Pocket Hive Held Item struct.
//            _ref_target - Persistent Beast struct for EQUIP/UNEQUIP, or the
//                          live battle Beast holder for TRIGGER.
// RETURNS: True when at least one Wasp Drone is summoned, or for successful
//          EQUIP/UNEQUIP; otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_pocket_hive(_str_state,_stct_item,_ref_target){

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

			//==================//
			//SUMMON UP TO THREE//
			//==================//
			var _ct_spawned = 0;

			for (
				var _it_spawn = 0;
				_it_spawn < 3;
				_it_spawn++
			){

				//----------------//
				//STOP WHEN FULL//
				//----------------//
				if (
					!scr_minion_has_open_slot(
						_ref_target
					)
				){
					break;
				}

				//----------------//
				//SUMMON DRONE//
				//----------------//
				var _ref_minion =
					scr_minion_init(
						"WASP_DRONE",
						undefined,
						_ref_target,
						_ref_target
					);

				if (!instance_exists(_ref_minion)){
					break;
				}

				_ct_spawned++;
			}

			return _ct_spawned > 0;

		case "UNEQUIP":

			return is_struct(_ref_target);
	}

	#endregion

	return false;
}