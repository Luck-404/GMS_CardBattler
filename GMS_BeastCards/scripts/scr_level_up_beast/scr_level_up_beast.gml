//===============================================================================//
//
// SCRIPT: SCR_LEVEL_UP_BEAST
// FUNCTION: Increases a living Beast's level by one.
//           Recalculates maximum HP through the shared level-setting helper.
//           Preserves the Beast's current HP percentage after leveling.
//
//===============================================================================//

function scr_level_up_beast(_stct_beast){

	//--------------//
	//VALIDATE BEAST//
	//--------------//
	if (!is_struct(_stct_beast)){
		return false;
	}

	//-----------------------------//
	//DEAD BEASTS CANNOT LEVEL UP//
	//-----------------------------//
	if (_stct_beast._val_beast_hp_cur <= 0){
		return false;
	}

	//-------------------//
	//CHECK LEVEL CAP//
	//-------------------//
	if (_stct_beast._val_beast_level >= 30){
		_stct_beast._val_beast_level = 30;
		return false;
	}

	return scr_set_beast_level(
		_stct_beast,
		_stct_beast._val_beast_level + 1,
		false
	);
}