//===============================================================================//
//
// SCRIPT: SCR_GET_CHEST_CUSTOM_LOOT
// FUNCTION: Returns an array of reward structs for the specified chest.
//           Each reward contains a type, reward id, and amount.
//           Used by treasure chests with predefined loot tables.
//
//===============================================================================//
function scr_get_chest_custom_loot(_str_chest_id){

	var _arr_return = [];

	switch(_str_chest_id){
		case "TESTER_CHEST":
			//ARRAY OF STRUCTS
			_arr_return = [
				{_str_type:"CARD", _str_rew_id:"STRIKE", _val_amount:1},
				{_str_type:"CARD", _str_rew_id:"ECHO", _val_amount:1},
				{_str_type:"ITEM", _str_rew_id:"CONSUMABLE_HEALING_SALVE", _val_amount:3},
				{_str_type:"GOLD", _str_rew_id:"GOLD", _val_amount:250}
			];
		break;
	}

	return _arr_return;
}