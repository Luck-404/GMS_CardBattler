//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_EMERALD_TALISMAN
// FUNCTION: Handles Emerald Talisman held item behavior.
//           At turn start, summons a random Viridian Minion on the holder.
//           Trigger feedback is handled by the battle turn-start item queue.
//
// ARGUMENTS: _str_state is the held-item behavior state.
//            _stct_item is the item struct and _ref_target is the holder.
// RETURNS: True when the requested behavior succeeds, otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_emerald_talisman(_str_state,_stct_item,_ref_target){

	//================//
	//VALIDATE ITEM//
	//================//
	if (_stct_item == undefined){
		return false;
	}

	//================//
	//HANDLE STATE//
	//================//
	switch (_str_state){

		case "EQUIP":
			return true;

		case "TRIGGER":

			//----------------//
			//VALIDATE HOLDER//
			//----------------//
			if (!instance_exists(_ref_target)){
				return false;
			}

			if (
				_ref_target._str_list != "ALIVE" ||
				_ref_target._val_cur_hp <= 0
			){
				return false;
			}

			//----------------//
			//VALIDATE POOL//
			//----------------//
			if (
				!variable_global_exists("arr_pool_viridian_minions") ||
				!is_array(global.arr_pool_viridian_minions) ||
				array_length(global.arr_pool_viridian_minions) <= 0
			){
				return false;
			}

			//----------------//
			//SELECT MINION//
			//----------------//
			var _it_minion =
				irandom(
					array_length(
						global.arr_pool_viridian_minions
					) - 1
				);

			var _str_minion_id =
				global.arr_pool_viridian_minions[
					_it_minion
				];

			//================//
			//SUMMON MINION//
			//================//
			scr_minion_init(
				_str_minion_id,
				undefined,
				_ref_target,
				_ref_target
			);

			return true;

		case "UNEQUIP":
			return true;
	}

	return false;
}