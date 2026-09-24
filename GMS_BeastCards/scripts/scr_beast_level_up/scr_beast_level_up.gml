//===============================================================================//
//
// SCRIPT: SCR_BEAST_LEVEL_UP
// FUNCTION: Increases a living Beast's level by 1.
//           Recalculates maximum HP through the shared level-setting helper.
//           Preserves the Beast's current HP percentage after leveling.
//
// ARGUMENTS: _stct_beast is the Beast struct to level up.
// RETURNS: True if the Beast successfully levels up; otherwise false.
//
//===============================================================================//

function scr_beast_level_up(_stct_beast){

	//================//
	//VALIDATE BEAST//
	//================//
	if (!is_struct(_stct_beast)){
		return false;
	}

	//========================//
	//CHECK BEAST IS LIVING//
	//========================//
	if (_stct_beast._val_beast_hp_cur <= 0){
		return false;
	}

	//================//
	//CHECK LEVEL CAP//
	//================//
	if (_stct_beast._val_beast_level >= 30){
		_stct_beast._val_beast_level = 30;
		return false;
	}

	//================//
	//LEVEL UP BEAST//
	//================//
	return scr_beast_set_level(
		_stct_beast,
		_stct_beast._val_beast_level + 1,
		false
	);
}