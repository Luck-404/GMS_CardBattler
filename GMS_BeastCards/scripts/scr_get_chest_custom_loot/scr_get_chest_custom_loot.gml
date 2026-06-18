//
//
// SCRIPT: SCR_GET_CHEST_LOOT | BASED ON THE PASSED CHEST NAME, RETRIEVE AN ARRAY WITH LOOT | RETURNS ARRAY OF LOOT
//
//
function scr_get_chest_custom_loot(_chest_id){
	var _return_list = ds_list_create();
	switch(_chest_id){
		case "TESTER_CHEST":
			ds_list_add(_return_list,["CARD","STRIKE",1]);
			ds_list_add(_return_list,["CARD","ECHO",1]);
			ds_list_add(_return_list,["ITEM","CONSUMABLE_HEALING_SALVE",3]);
			ds_list_add(_return_list,["GOLD","GOLD",250]);
			return _return_list;
		break;
	}
	
	return _return_list;
}