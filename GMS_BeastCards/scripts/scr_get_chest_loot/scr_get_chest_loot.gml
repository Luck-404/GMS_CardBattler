//
//
// SCRIPT: SCR_GET_CHEST_LOOT | BASED ON THE PASSED CHEST NAME, RETRIEVE AN ARRAY WITH LOOT | RETURNS ARRAY OF LOOT
//
//
function scr_get_chest_loot(_chest_id){
	var _return_arr = [];
	
	switch(_chest_id){
		case "TESTER_CHEST":
			_return_arr = ["STRIKE","STRIKE","ECHO",500];
		break;
	}
	
	return _return_arr;
}