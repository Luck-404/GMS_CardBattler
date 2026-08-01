//===============================================================================//
//
// SCRIPT: SCR_LEVEL_UP_BEAST
// FUNCTION: Increases a living Beast's level by one.
//           Recalculates maximum HP through the shared HP formula.
//           Preserves the Beast's current HP percentage after leveling.
//
//===============================================================================//

function scr_level_up_beast(_stct_beast){

	//----------------//
	//VALIDATE BEAST//
	//----------------//
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

	//-----------------------//
	//STORE CURRENT HP RATIO//
	//-----------------------//
	var _val_old_cur_hp =
		_stct_beast._val_beast_hp_cur;

	var _val_old_max_hp =
		max(
			1,
			_stct_beast._val_beast_hp_max
		);

	var _val_hp_ratio = clamp(
		_val_old_cur_hp / _val_old_max_hp,
		0,
		1
	);

	//----------------//
	//INCREASE LEVEL//
	//----------------//
	_stct_beast._val_beast_level++;

	//----------------------//
	//RECALCULATE MAXIMUM HP//
	//----------------------//
	var _val_new_max_hp = scr_get_beast_max_hp(
		_stct_beast._val_beast_hp_stat,
		_stct_beast._val_beast_level
	);

	_stct_beast._val_beast_hp_max =
		_val_new_max_hp;

	//----------------------//
	//PRESERVE HP PERCENTAGE//
	//----------------------//
	var _val_new_cur_hp = ceil(
		_val_new_max_hp *
		_val_hp_ratio
	);

	_stct_beast._val_beast_hp_cur = clamp(
		_val_new_cur_hp,
		1,
		_val_new_max_hp
	);

	return true;
}