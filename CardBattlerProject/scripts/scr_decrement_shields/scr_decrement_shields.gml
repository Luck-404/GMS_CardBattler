//////////////////////////////////////////////////////////////////////
//						SCR_DECREMENT_SHIELDS						//
//																	//
// > BASED ON THE UNIT'S TYPE (MARTIAL, MAGICAL, TECHNICAL) SHIELDS //
//   ARE REDUCED AFTER A ROUND END									//
//////////////////////////////////////////////////////////////////////
function scr_decrement_shields(_unit){
	var _type = _unit._creature_spec;
	switch (_type){
		case "Martial": //take half of the shields, rounded down
			_unit._creature_def = floor((_unit._creature_def)*0.5);
		break;
		
		case "Technical": //take 75% of the shields, rounded down
			_unit._creature_def = floor((_unit._creature_def)*0.25);
		break;
				
		case "Magical": //take 90% of the shields, rounded down
			_unit._creature_def = floor((_unit._creature_def)*0.1);
		break;
				
		case "Any": //take 80% of the shields, rounded down
			_unit._creature_def = floor((_unit._creature_def)*0.2);
		break;
	}
}