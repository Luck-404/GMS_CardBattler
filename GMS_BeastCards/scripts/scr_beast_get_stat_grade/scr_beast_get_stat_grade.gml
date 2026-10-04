//===============================================================================//
//
// SCRIPT: SCR_BEAST_GET_STAT_GRADE
// FUNCTION: Returns the major display Grade for a primary Beast Stat.
//           Grades describe the raw Stat value only and do not determine
//           the Stat's mechanical effect.
//
//           0       = NULL
//           1-50    = F
//           51-100  = D
//           101-150 = C
//           151-200 = B
//           201-250 = A
//           251-300 = S
//           301+    = EX
//
// ARGUMENTS: _val_stat - Raw or effective primary Stat value.
// RETURNS: Grade string.
//
//===============================================================================//

function scr_beast_get_stat_grade(_val_stat){

	#region VALIDATION

	//================//
	//SANITIZE STAT//
	//================//
	if (!is_real(_val_stat)){
		return "NULL";
	}

	_val_stat = max(0,_val_stat);

	#endregion

	#region GRADE

	//------//
	//NULL//
	//------//
	if (_val_stat == 0){
		return "NULL";
	}

	//---//
	//F//
	//---//
	if (_val_stat <= 50){
		return "F";
	}

	//---//
	//D//
	//---//
	if (_val_stat <= 100){
		return "D";
	}

	//---//
	//C//
	//---//
	if (_val_stat <= 150){
		return "C";
	}

	//---//
	//B//
	//---//
	if (_val_stat <= 200){
		return "B";
	}

	//---//
	//A//
	//---//
	if (_val_stat <= 250){
		return "A";
	}

	//---//
	//S//
	//---//
	if (_val_stat <= 300){
		return "S";
	}

	//----//
	//EX//
	//----//
	return "EX";

	#endregion
}