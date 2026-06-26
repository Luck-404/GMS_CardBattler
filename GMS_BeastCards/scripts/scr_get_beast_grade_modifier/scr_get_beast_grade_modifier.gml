//===============================================================================//
//
// SCRIPT: SCR_GET_BEAST_GRADE_MODIFIER
// FUNCTION: Returns the numeric grade modifier corresponding to a beast stat.
// Accepts a raw stat value and returns a modifier from 0.1 through 2.1.
//
//===============================================================================//

function scr_get_beast_grade_modifier(_val_stat){

	// F
	#region F
	if (_val_stat <= 10){
		return 0.1;
	}
	else if (_val_stat <= 20){
		return 0.2;
	}
	else if (_val_stat <= 30){
		return 0.3;
	}
	#endregion

	// E
	#region E
	else if (_val_stat <= 40){
		return 0.4;
	}
	else if (_val_stat <= 50){
		return 0.5;
	}
	else if (_val_stat <= 60){
		return 0.6;
	}
	#endregion

	// D
	#region D
	else if (_val_stat <= 70){
		return 0.7;
	}
	else if (_val_stat <= 80){
		return 0.8;
	}
	else if (_val_stat <= 90){
		return 0.9;
	}
	#endregion

	// C
	#region C
	else if (_val_stat <= 100){
		return 1.0;
	}
	else if (_val_stat <= 110){
		return 1.1;
	}
	else if (_val_stat <= 120){
		return 1.2;
	}
	#endregion

	// B
	#region B
	else if (_val_stat <= 130){
		return 1.3;
	}
	else if (_val_stat <= 140){
		return 1.4;
	}
	else if (_val_stat <= 150){
		return 1.5;
	}
	#endregion

	// A
	#region A
	else if (_val_stat <= 160){
		return 1.6;
	}
	else if (_val_stat <= 170){
		return 1.7;
	}
	else if (_val_stat <= 180){
		return 1.8;
	}
	#endregion

	// S
	#region S
	else if (_val_stat <= 190){
		return 1.9;
	}
	else if (_val_stat <= 200){
		return 2.0;
	}
	else if (_val_stat <= 210){
		return 2.1;
	}
	#endregion

	// EX
	return 2.1;
}