//===============================================================================//
//
// SCRIPT: SCR_BEAST_GET_GRADE_LETTER
// FUNCTION: Returns the letter grade corresponding to a Beast stat.
//           Converts a raw stat value into a grade from F- through EX.
//
// ARGUMENTS: _val_stat is the raw Beast stat value to convert.
// RETURNS: The corresponding grade string from F- through EX.
//
//===============================================================================//

function scr_beast_get_grade_letter(_val_stat){

	//================//
	//F GRADE//
	//================//
	if (_val_stat <= 10){
		return "F-";
	}
	else if (_val_stat <= 20){
		return "F";
	}
	else if (_val_stat <= 30){
		return "F+";
	}

	//================//
	//E GRADE//
	//================//
	else if (_val_stat <= 40){
		return "E-";
	}
	else if (_val_stat <= 50){
		return "E";
	}
	else if (_val_stat <= 60){
		return "E+";
	}

	//================//
	//D GRADE//
	//================//
	else if (_val_stat <= 70){
		return "D-";
	}
	else if (_val_stat <= 80){
		return "D";
	}
	else if (_val_stat <= 90){
		return "D+";
	}

	//================//
	//C GRADE//
	//================//
	else if (_val_stat <= 100){
		return "C-";
	}
	else if (_val_stat <= 110){
		return "C";
	}
	else if (_val_stat <= 120){
		return "C+";
	}

	//================//
	//B GRADE//
	//================//
	else if (_val_stat <= 130){
		return "B-";
	}
	else if (_val_stat <= 140){
		return "B";
	}
	else if (_val_stat <= 150){
		return "B+";
	}

	//================//
	//A GRADE//
	//================//
	else if (_val_stat <= 160){
		return "A-";
	}
	else if (_val_stat <= 170){
		return "A";
	}
	else if (_val_stat <= 180){
		return "A+";
	}

	//================//
	//S GRADE//
	//================//
	else if (_val_stat <= 190){
		return "S-";
	}
	else if (_val_stat <= 200){
		return "S";
	}
	else if (_val_stat <= 210){
		return "S+";
	}

	//================//
	//EX GRADE//
	//================//
	return "EX";
}