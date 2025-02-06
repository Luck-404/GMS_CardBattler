function scr_passer_check(_type){
	if (instance_exists(obj_passer)){

		//check patron
		if(obj_passer._pass_patron != undefined){
			show_debug_message("Checker found: " + string(obj_passer._pass_patron));
		} else {
		return "PATRON NOT DEFINED";	
		}

		//check STARTER
		if(obj_passer._pass_starter != undefined){
			show_debug_message("Checker found: " + string(obj_passer._pass_starter));	
		} else {
		return "STARTER NOT DEFINED";	
		}

		//check ARDS
		if(obj_passer._pass_cards != undefined){
			show_debug_message("Checker found: " + string(obj_passer._pass_cards));	
		} else {
		return "CARDS NOT DEFINED";	
		}

		//check GEAR
		if(obj_passer._pass_gear != undefined){
			show_debug_message("Checker found: " + string(obj_passer._pass_gear));	
		} else {
		return "GEAR NOT DEFINED";	
		}


		//check GOLD
		if(obj_passer._pass_gold != 0){
			show_debug_message("Checker found: " + string(obj_passer._pass_gold));	
		} else {
		return "GOLD NOT DEFINED";	
		}


		//check BLESSING
		if(obj_passer._pass_blessing != undefined){
			show_debug_message("Checker found: " + string(obj_passer._pass_blessing));	
		} else {
		return "BLESSING NOT DEFINED";	
		}

		if (_type == "Load Game"){
			//check savefile
			if(obj_passer._pass_savefile != undefined){
			show_debug_message("Checker found: " + string(obj_passer._pass_savefile));	
			} else {
			return "SAVEFILE NOT DEFINED";	
			}
		}
	
		return true;

	} else {
	return "OBJ PASSER DOESNT EXIST";	
	}

	return false;
}