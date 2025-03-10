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
        case "Green": 
            if (_target_color == "Blue") _multiplier = 2; // Green is strong against Blue
            else if (_target_color == "Red") _multiplier = 0.5; // Green is weak against Red
            break;
        
        case "Blue": 
            if (_target_color == "Red") _multiplier = 2; // Blue is strong against Red
            else if (_target_color == "Green") _multiplier = 0.5; // Blue is weak against Green
            break;
        
        case "Red": 
            if (_target_color == "Green") _multiplier = 2; // Red is strong against Green
            else if (_target_color == "Blue") _multiplier = 0.5; // Red is weak against Blue
            break;
        
        // Add more cases if you have additional colors/elements
    }
		return _multiplier; 
}