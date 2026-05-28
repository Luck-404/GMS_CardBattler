//
//
// SCRIPT: SCR_GET_BEAST_GRADE_LETTER | GETS THE GRADE (F- to EX) BASED ON INPUT STAT | RETURNS STRING OF GRADE STAT
//
//
function scr_get_beast_grade_letter(_stat){

	//F (0-30)
	#region F
	if (_stat <= 10){ //F-
		return "F-";
	}
	
	else if (_stat <= 20){ //F
		return "F";
	}
	
	else if (_stat <= 30){ //F+
		return "F+";
	}
	#endregion
	
	//E (30-60)
	#region E
	else if (_stat <= 40){ //E-
		return "E-";
	}
	
	else if (_stat <= 50){ //E
		return "E";
	}
	
	else if (_stat <= 60){ //E+
		return "E+";
	}
	#endregion
	
	//D (60-90)
	#region D
	else if (_stat <= 70){ //D-
		return "D-";
	}
	
	else if (_stat <= 80){ //D
		return "D";
	}
	
	else if (_stat <= 90){ //D+
		return "D+";
	}
	#endregion
	
	//C (90-120)
	#region C
	else if (_stat <= 100){ //C-
		return "C-";
	}
	
	else if (_stat <= 110){ //C
		return "C";
	}
	
	else if (_stat <= 120){ //C+
		return "C+";
	}
	#endregion
	
	//B (120-160)
	#region B
	else if (_stat <= 130){ //B-
		return "B-";
	}
	
	else if (_stat <= 140){ //B
		return "B";
	}
	
	else if (_stat <= 150){ //B+
		return "B+";
	}
	#endregion
	
	//A (150-180)
	#region A
	else if (_stat <= 160){ //A-
		return "A-";
	}
	
	else if (_stat <= 170){ //A
		return "A";
	}
	
	else if (_stat <= 180){ //A+
		return "A+";
	}
	#endregion
	
	//S (180-210)
	#region S
	else if (_stat <= 190){ //S-
		return "S-";
	}
	
	else if (_stat <= 200){ //S
		return "S";
	}
	
	else if (_stat <= 210){ //S+
		return "S+";
	}
	#endregion
	
	//EX (210+)
	return "EX";
}