//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_SALVAGERS_MAGNET
// FUNCTION: Handles Salvager's Magnet Held Item behavior.
//
//           EQUIP / UNEQUIP require no persistent stat changes.
//
//           TRIGGER adds +1 guaranteed Material reward to the victorious battle
//           reward floor. Every equipped Salvager's Magnet contributes its own
//           +1 bonus, so multiple holders stack additively.
//
// ARGUMENTS: _str_state is the Held Item behavior state.
//            _stct_item is the Held Item struct.
// RETURNS: True for EQUIP/UNEQUIP.
//          Resource modifier struct for TRIGGER.
//          False for invalid states.
//
//===============================================================================//

function scr_inventory_item_held_salvagers_magnet(_str_state,_stct_item){

	#region VALIDATION

	if (!is_struct(_stct_item)){
		return false;
	}

	#endregion

	#region HANDLE STATE

	switch (_str_state){

		case "EQUIP":
			return true;

		case "TRIGGER":

			return {
				_ct_guaranteed_material_bonus : 1
			};

		case "UNEQUIP":
			return true;
	}

	#endregion

	return false;
}