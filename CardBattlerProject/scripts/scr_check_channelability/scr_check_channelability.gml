//////////////////////////////////////////////////////////////////////
//					SCR_CHECK_CHANNELABILITY						//
//																	//
// > Checks if a unit can be channeled through based on selected	//
//   card.															//
//////////////////////////////////////////////////////////////////////
function scr_check_channelability(_unit,_card){

	//////////////////////////////////
	// CHECK CREATURE COLOR VS CARD //
	//////////////////////////////////
	//check unit color against selected car
	if (_unit._creature_color1 == "Uncolored"){

	} 
	else if (_card._card_color == "Uncolored"){

	}	
	else {
		if ((_unit._creature_color1 != _card._card_color) && (_unit._creature_color2 != _card._card_color)){
	
			return false;
		}
	}
	
	/////////////////////////////////////
	// CHECK CREATURE SPEC VS CARD REQ //
	/////////////////////////////////////
	//check unit spec
	if (_card._card_spec_req == "Any"){

	} else {	
		if (_unit._creature_spec != _card._card_spec_req){

			return false;
		}
	}

	//////////////////////////////////////
	// CHECK CREATURE CLASS VS CARD REQ //
	//////////////////////////////////////
	//check unit class
	if (_card._card_class_req == "Any"){

	} else {		
		if (_unit._creature_class != _card._card_class_req){

			return false;
		}	
	}
	
	///////////////////////////////
	// CHECK IF CREATURE IS CC'd //
	///////////////////////////////
	//check if unit is stunned/cc'd	
		if (_unit._stunned = true){

			return false;	
		}
	return true;
}