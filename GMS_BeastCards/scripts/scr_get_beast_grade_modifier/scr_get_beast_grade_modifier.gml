//
//
// SCRIPT: SCR_GET_BEAST_GRADE_MODIFIER | GETS THE MODIFIER (0.1 TO 2.1) BASED ON INPUT STAT | RETURNS DOUBLE OF STAT MODIFIER
//
//
function scr_get_beast_grade_modifier(_stat){

	//F (0-30)
	#region F
	if (_stat <= 10){ //F-
		return 0.1;
	}
	
	else if (_stat <= 20){ //F
		return 0.2;
	}
	
	else if (_stat <= 30){ //F+
		return 0.3;
	}
	#endregion
	
	//E (30-60)
	#region E
	else if (_stat <= 40){ //E-
		return 0.4;
	}
	
	else if (_stat <= 50){ //E
		return 0.5;
	}
	
	else if (_stat <= 60){ //E+
		return 0.6;
	}
	#endregion
	
	//D (60-90)
	#region D
	else if (_stat <= 70){ //D-
		return 0.7;
	}
	
	else if (_stat <= 80){ //D
		return 0.8;
	}
	
	else if (_stat <= 90){ //D+
		return 0.9;
	}
	#endregion
	
	//C (90-120)
	#region C
	else if (_stat <= 100){ //C-
		return 1.0;
	}
	
	else if (_stat <= 110){ //C
		return 1.1;
	}
	
	else if (_stat <= 120){ //C+
		return 1.2;
	}
	#endregion
	
	//B (120-160)
	#region B
	else if (_stat <= 130){ //B-
		return 1.3;
	}
	
	else if (_stat <= 140){ //B
		return 1.4;
	}
	
	else if (_stat <= 150){ //B+
		return 1.5;
	}
	#endregion
	
	//A (150-180)
	#region A
	else if (_stat <= 160){ //A-
		return 1.6;
	}
	
	else if (_stat <= 170){ //A
		return 1.7;
	}
	
	else if (_stat <= 180){ //A+
		return 1.8;
	}
	#endregion
	
	//S (180-210)
	#region S
	else if (_stat <= 190){ //S-
		return 1.9;
	}
	
	else if (_stat <= 200){ //S
		return 2.0;
	}
	
	else if (_stat <= 210){ //S+
		return 2.1;
	}
	#endregion
	
	//EX (210+)
	return 2.1;
}