//===============================================================================//
//
// SCRIPT: SCR_GET_BEAST_GRADE_LETTER
// FUNCTION: Returns the letter grade corresponding to a beast stat.
// Accepts a raw stat value and returns a grade from F- through EX.
//
//===============================================================================//

function scr_get_beast_grade_letter(_val_stat){

	// F
	#region F
	if (_val_stat <= 10){
		return "F-";
	}
	else if (_val_stat <= 20){
		return "F";
	}
	else if (_val_stat <= 30){
		return "F+";
	}
	#endregion

	// E
	#region E
	else if (_val_stat <= 40){
		return "E-";
	}
	else if (_val_stat <= 50){
		return "E";
	}
	else if (_val_stat <= 60){
		return "E+";
	}
	#endregion

	// D
	#region D
	else if (_val_stat <= 70){
		return "D-";
	}
	else if (_val_stat <= 80){
		return "D";
	}
	else if (_val_stat <= 90){
		return "D+";
	}
	#endregion

	// C
	#region C
	else if (_val_stat <= 100){
		return "C-";
	}
	else if (_val_stat <= 110){
		return "C";
	}
	else if (_val_stat <= 120){
		return "C+";
	}
	#endregion

	// B
	#region B
	else if (_val_stat <= 130){
		return "B-";
	}
	else if (_val_stat <= 140){
		return "B";
	}
	else if (_val_stat <= 150){
		return "B+";
	}
	#endregion

	// A
	#region A
	else if (_val_stat <= 160){
		return "A-";
	}
	else if (_val_stat <= 170){
		return "A";
	}
	else if (_val_stat <= 180){
		return "A+";
	}
	#endregion

	// S
	#region S
	else if (_val_stat <= 190){
		return "S-";
	}
	else if (_val_stat <= 200){
		return "S";
	}
	else if (_val_stat <= 210){
		return "S+";
	}
	#endregion

	// EX
	return "EX";
}