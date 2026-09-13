//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_EMERALD_TALISMAN
// FUNCTION: Handles Emerald Talisman held item behavior.
//           Triggers at turn start to summon a random Viridian minion.
//           Returns whether the requested behavior successfully resolved.
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

			//----------------//
			//VALIDATE POOL//
			//----------------//
			if (ds_list_size(global.list_pool_viridian_minions) <= 0){
				return false;
			}

			//----------------//
			//SELECT MINION//
			//----------------//
			var _it_minion = irandom(ds_list_size(global.list_pool_viridian_minions) - 1);
			var _str_minion_id = ds_list_find_value(global.list_pool_viridian_minions,_it_minion);

			//----------------//
			//SUMMON MINION//
			//----------------//
			scr_minion_init(
				_str_minion_id,
				undefined,
				_ref_target,
				_ref_target
			);

			scr_gui_spawn_popup_trigger_banner(_stct_item._str_item_name);

			return true;

		case "UNEQUIP":
			return true;
	}

	return false;
}