//////////////////////////////////////////////////////////////////////
//					SCR_CHECK_CHANNELABILITY						//
//																	//
// > Checks if a unit can be channeled through based on selected	//
//   card.															//
//////////////////////////////////////////////////////////////////////
function scr_check_targetability(_caster_unit,_tar_unit,_card){
	////////////////
	// TARGETLESS //
	////////////////
	if (_card._flag_targetless == true){
		return [false,"CARD IS TARGETLESS"];
	}
	
	_card_range = _card._card_range; //Self, Ranged, Melee, Targetless
	//////////
	// SELF //
	//////////
	if (_card_range == "Self"){ //only return true if its casting on itself
		if (string(_caster_unit) == string(_tar_unit)){
			return [true,"GOOD TO GO - SELF"];
		} 
		else{
			return [false,"THIS CARD MUST BE CAST ON SELF"];
		}
	}
	
	////////////
	// RANGED //
	////////////
	else if (_card_range == "Ranged"){ //always return true (any target)
		return [true,"GOOD TO GO - RANGED"];
	}
	
	///////////
	// MELEE //
	////////////
	else if (_card_range == "Melee"){ //only return true with units in the 1st slot on enemy team, any slot on ally team
		////////////
		// PLAYER //
		////////////
		if (_tar_unit._creature_team == "Player"){
			return [true,"GOOD TO GO - PLAYER MELEE"];
		} 
		
		///////////
		// ENEMY //
		///////////	
		else {
			if (_tar_unit._creature_position == 0){ //only activate the enemy unit in 1st spot
				return [true,"GOOD TO GO - ENEMY MELEE SPOT 0"];
			}
		}
		return [false,"MELEE ATTACKS CAN ONLY ATTACK THE FRONT ENEMY UNIT"];
	} 
}