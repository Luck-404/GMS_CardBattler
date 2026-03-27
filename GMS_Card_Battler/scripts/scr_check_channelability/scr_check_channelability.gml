//////////////////////////////////////////////////////////////////////
//					SCR_CHECK_CHANNELABILITY						//
//																	//
// > Checks if a unit can be channeled through based on selected	//
//   card.															//
//////////////////////////////////////////////////////////////////////
function scr_check_channelability(_unit,_card){
	////////////////
	// CHECK TEAM //
	////////////////
	if (_unit._creature_team == "Enemy"){
		return [false,"CREATURE MUST BE IN PLAYER PARTY"];
	} 
	
	////////////////
	// CHECK DEAD //
	////////////////
	if (_unit._creature_hp_current <= 0){
		return [false,"CREATURE MUST BE ALIVE"];
	} 	

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
	
			return [false,"CREATURE DOES NOT MATCH CARD COLOR REQUIREMENTS"];
		}
	}
	
	/////////////////////////////////////
	// CHECK CREATURE SPEC VS CARD REQ //
	/////////////////////////////////////
	//check unit spec
	if (_card._card_spec_req == "Any"){

	} else {	
		if (_unit._creature_spec != _card._card_spec_req){

			return [false,"CREATURE DOES NOT MATCH CARD SPEC REQUIREMENTS"];
		}
	}

	//////////////////////////////////////
	// CHECK CREATURE CLASS VS CARD REQ //
	//////////////////////////////////////
	//check unit class
	if (_card._card_class_req == "Any"){

	} else {		
		if (_unit._creature_class != _card._card_class_req){

			return [false,"CREATURE DOES NOT MATCH CARD CLASS REQUIREMENTS"];
		}	
	}
	
	///////////////////////////////
	// CHECK IF CREATURE IS CC'd //
	///////////////////////////////
	//check if unit is stunned/cc'd	
		if (_unit._status_stunned = true){

			return [false,"CREATURE IS STUNNED"];
		}
	return [true,"GOOD TO GO"];
}