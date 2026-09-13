//===============================================================================//
//
// SCRIPT: SCR_BEAST_SET_LEVEL
// FUNCTION: Sets a Beast directly to a supplied level.
//           Recalculates maximum HP through the shared HP formula.
//           Can fully heal the Beast or preserve its current HP percentage.
//
// ARGUMENTS: _stct_beast is the Beast struct to update, _val_level is the target
//            level, and _flag_full_heal determines whether HP is fully restored.
// RETURNS: True if the Beast level is successfully updated; otherwise false.
//
//===============================================================================//

function scr_beast_set_level(_stct_beast,_val_level,_flag_full_heal=false){

	//================//
	//VALIDATE BEAST//
	//================//
	if (!is_struct(_stct_beast)){
		return false;
	}

	//========================//
	//STORE CURRENT HP RATIO//
	//========================//
	var _val_old_max_hp = max(1,_stct_beast._val_max_hp);
	var _val_hp_ratio = clamp(_stct_beast._val_cur_hp / _val_old_max_hp,0,1);

	//================//
	//SET LEVEL//
	//================//
	_stct_beast._val_beast_level = clamp(floor(_val_level),1,30);

	//========================//
	//RECALCULATE MAXIMUM HP//
	//========================//
	_stct_beast._val_max_hp = scr_beast_get_max_hp(
		_stct_beast._val_beast_hp_stat,
		_stct_beast._val_beast_level
	);

	//================//
	//UPDATE HP//
	//================//
	if (_flag_full_heal){
		_stct_beast._val_cur_hp = _stct_beast._val_max_hp;
	}
	else{
		_stct_beast._val_cur_hp = ceil(_stct_beast._val_max_hp * _val_hp_ratio);
		_stct_beast._val_cur_hp = clamp(_stct_beast._val_cur_hp,0,_stct_beast._val_max_hp);
	}

	return true;
}