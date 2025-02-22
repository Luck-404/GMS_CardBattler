//////////////////////////////////////////////////////////////////////
//					SCR_PASSER_CHECK								//
//																	//
// > CHECK THE INFORMATION OF THE PASSER OBJECT TO MAKE SURE IT		//
//	 PROPERLY PASSED ALL THE VALUES									//
//////////////////////////////////////////////////////////////////////
function scr_passer_check(_type){
	if (instance_exists(obj_passer)){

		//check patron
		if(obj_passer._pass_patron != undefined){
			show_debug_message("Checker found: " + string(obj_passer._pass_patron));
		} else {
		return "PATRON NOT DEFINED";	
		}

		//check BLESSING
		if(obj_passer._pass_blessing != undefined){
			show_debug_message("Checker found: " + string(obj_passer._pass_blessing));	
		} else {
		return "BLESSING NOT DEFINED";	
		}
	
		return true;

	} else {
	return "OBJ PASSER DOESNT EXIST";	
	}

	return false;
}