//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_VERDANT_SEED
// FUNCTION: Handles Verdant Seed held item behavior.
//           Triggers SEEDFALL when activated in battle.
//           Returns whether the requested behavior successfully resolved.
//
// ARGUMENTS: _str_state is the held-item behavior state.
//            _stct_item is the item struct and _ref_target is the holder.
// RETURNS: True when the requested behavior succeeds, otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_verdant_seed(_str_state,_stct_item,_ref_target){

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
			//TRIGGER WEATHER//
			//----------------//
			scr_status_apply_weather("SEEDFALL");

			scr_gui_spawn_popup_trigger_banner(_stct_item._str_item_name);

			return true;

		case "UNEQUIP":
			return true;
	}

	return false;
}