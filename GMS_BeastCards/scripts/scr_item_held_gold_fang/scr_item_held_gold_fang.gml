//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_GOLD_FANG
// FUNCTION: Handles Gold Fang Held Item behavior.
//           Equips normally and returns a 10% battle Gold bonus when triggered
//           at battle exit.
//           Remains active and is not consumed after triggering.
//
// ARGUMENTS: _str_state is the Held Item behavior state.
//            _stct_item is the Held Item struct.
// RETURNS: True for EQUIP/UNEQUIP, 0.10 on TRIGGER, otherwise 0.
//
//===============================================================================//

function scr_inventory_item_held_gold_fang(_str_state,_stct_item){

	//================//
	//VALIDATE ITEM//
	//================//
	if (_stct_item == undefined){
		return 0;
	}

	//================//
	//HANDLE STATE//
	//================//
	switch (_str_state){

		case "EQUIP":
			return true;

		case "TRIGGER":
			return 0.10;

		case "UNEQUIP":
			return true;
	}

	return 0;
}