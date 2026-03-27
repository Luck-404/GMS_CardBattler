//////////////////////////////////////////////////////////////////////
//						SCR_DECREMENT_SHIELDS						//
//																	//
// > BASED ON THE UNIT'S TYPE (MARTIAL, MAGICAL, TECHNICAL) SHIELDS //
//   ARE REDUCED AFTER A ROUND END									//
//////////////////////////////////////////////////////////////////////
function scr_decrement_shields(_unit){
	var _type = _unit._creature_spec;
	switch (_type){
		case "Martial": //take 20% of the shields, rounded down
			_unit._creature_def = floor((_unit._creature_def)*0.8);
		break;
		
		case "Technical": //take 40% of the shields, rounded down
			_unit._creature_def = floor((_unit._creature_def)*0.6);
		break;
				
		case "Magical": //take 60% of the shields, rounded down
			_unit._creature_def = floor((_unit._creature_def)*0.4);
		break;
				
		case "Any": //take 60% of the shields, rounded down
			_unit._creature_def = floor((_unit._creature_def)*0.4);
		break;
	}
}