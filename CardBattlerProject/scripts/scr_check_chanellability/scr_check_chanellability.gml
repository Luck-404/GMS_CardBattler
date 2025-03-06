//////////////////////////////////////////////////////////////////////
//					SCR_CHECK_CHANNELABILITY						//
//																	//
// > Checks if a unit can be channeled through based on selected	//
//   card.															//
//////////////////////////////////////////////////////////////////////
function scr_check_chanellability(_unit,_card){
	//check unit color against selected car
	if (_unit.creature_color1 == "Uncolored"){
		
	} else {
		if ((_unit.creature_color1 != _card._card_color) && (_unit.creature_color2 != _card._card_color)){
			return false;
		}
	}
	//check unit spec
	if (_card._card_spec_req == "Any"){
		
	} else {	
		if (_unit.creature_spec != _card._card_spec_req){
			return false;
		}
	}
	
	//check unit class
	if (_card._card_class_req == "Any"){
		
	} else {		
		if (_unit.creature_class != _card._card_class_req){
			return false;
		}	
	}
	//check if unit is stunned/cc'd	
		//TODO
	return true;
}