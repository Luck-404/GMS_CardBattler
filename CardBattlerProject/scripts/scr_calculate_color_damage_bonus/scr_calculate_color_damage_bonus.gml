//////////////////////////////////////////////////////////////////////
//				SCR_CALCULATE_COLOR_DAMAGE_BONUS					//
//																	//
// > CHECK THE DAMAGE BONUS FROM THE COLOR OF THE CARD VERSUS THE	//
//	 TARGET															//
//////////////////////////////////////////////////////////////////////
function scr_calculate_color_damage_bonus(_card_color, _target) {
    var _target_color = _target._creature_color1;  // Assuming unit has a "color" variable
    var _multiplier = 1;  // Default multiplier (neutral interaction)

    // Color-based damage multipliers
    switch (_card_color) {
        case "Red": 
            if (_target_color == "Green") _multiplier = 2;			// Red is strong against Yellow
            else if (_target_color == "Blue") _multiplier = 0.5;	// Red is weak against Blue
        break;
		
        //case "Orange": 
        //    if (_target_color == "Purple") _multiplier = 2;			// Orange is strong against Purple
        //    else if (_target_color == "Black") _multiplier = 0.5;	// Orange is weak against Black
		//break;		
		
        //case "Yellow": 
        //    if (_target_color == "Green") _multiplier = 2;			// Yellow is strong against Green
        //    else if (_target_color == "Red") _multiplier = 0.5;	// Yellow is weak against Red
        //break;
		
        case "Green": 
            if (_target_color == "Blue") _multiplier = 2;			// Green is strong against Blue
            else if (_target_color == "Red") _multiplier = 0.5;		// Green is weak against Yellow
        break;
		
        case "Blue": 
            if (_target_color == "Red") _multiplier = 2;			// Blue is strong against Red
            else if (_target_color == "Green") _multiplier = 0.5;	// Blue is weak against Green
        break;
		
        //case "Purple": 
        //    if (_target_color == "White") _multiplier = 2;			// Purple is strong against White
        //    else if (_target_color == "Orange") _multiplier = 0.5;	// Purple is weak against Orange
        //break;
		
        //case "Black": 
        //    if (_target_color == "Orange") _multiplier = 2;			// Black is strong against Orange
        //    else if (_target_color == "White") _multiplier = 0.5;	// Black is weak against White
        //break;
		
        //case "White": 
        //    if (_target_color == "Black") _multiplier = 2;			// White is strong against Black
        //    else if (_target_color == "Purple") _multiplier = 0.5;	// White is weak against Purple
        //break;			
    }
		return _multiplier; 
}