//===============================================================================//
//
// SCRIPT: SCR_SET_BEAST_LEVEL
// FUNCTION: Sets a Beast directly to a supplied level.
//           Recalculates maximum HP through the shared HP formula.
//           Can fully heal the Beast or preserve its current HP percentage.
//
//===============================================================================//

function scr_set_beast_level(_stct_beast,_val_level,_flag_full_heal=false){

	//--------------//
	//VALIDATE BEAST//
	//--------------//
	if (!is_struct(_stct_beast)){
		return false;
	}

	//-----------------------//
	//STORE CURRENT HP RATIO//
	//-----------------------//
	var _val_old_max_hp = max(1,_stct_beast._val_beast_hp_max);
	var _val_hp_ratio = clamp(_stct_beast._val_beast_hp_cur / _val_old_max_hp,0,1);

	//----------//
	//SET LEVEL//
	//----------//
	_stct_beast._val_beast_level = clamp(floor(_val_level),1,30);

	//----------------------//
	//RECALCULATE MAXIMUM HP//
	//----------------------//
	_stct_beast._val_beast_hp_max = scr_get_beast_max_hp(
		_stct_beast._val_beast_hp_stat,
		_stct_beast._val_beast_level
	);

	//----------//
	//UPDATE HP//
	//----------//
	if (_flag_full_heal){
		_stct_beast._val_beast_hp_cur = _stct_beast._val_beast_hp_max;
	}
	else{
		_stct_beast._val_beast_hp_cur = ceil(
			_stct_beast._val_beast_hp_max *
			_val_hp_ratio
		);

		_stct_beast._val_beast_hp_cur = clamp(
			_stct_beast._val_beast_hp_cur,
			0,
			_stct_beast._val_beast_hp_max
		);
	}

	return true;
}