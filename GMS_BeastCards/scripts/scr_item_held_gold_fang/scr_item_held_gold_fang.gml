//===============================================================================//
//
// SCRIPT: SCR_ITEM_HELD_GOLD_FANG
// FUNCTION: Handles Gold Fang held item behavior.
//           Returns a 10% battle gold bonus when triggered at battle exit.
//           Remains active and is not consumed after triggering.
//
//===============================================================================//

function scr_item_held_gold_fang(_str_state,_stct_item){

	if (_stct_item == undefined){
		return 0;
	}

	switch(_str_state){

		case "EQUIP":
			return 0;
		break;

		case "TRIGGER":
			return 0.10;
		break;

		case "UNEQUIP":
			return 0;
		break;
	}

	return 0;
}