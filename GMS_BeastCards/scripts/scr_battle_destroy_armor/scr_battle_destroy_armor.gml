//===============================================================================//
//
// SCRIPT: SCR_BATTLE_DESTROY_ARMOR
// FUNCTION: Removes up to the requested Armor without damage, feedback or triggers.
//           Keeps Armor bookkeeping independent of its caller's effect timing.
//
// ARGUMENTS: _ref_target - battle Beast whose Armor is removed.
//            _val_amount - nonnegative requested Armor removal.
// RETURNS: Struct: _val_armor_removed, _val_armor_before, _val_armor_after,
//          _flag_armor_broken. Invalid/no-op requests remove zero Armor.
//
//===============================================================================//
function scr_battle_destroy_armor(_ref_target,_val_amount){
	//================//
	//DEFAULT RESULT//
	//================//
	var _stct_result = {
		_val_armor_removed : 0,
		_val_armor_before : 0,
		_val_armor_after : 0,
		_flag_armor_broken : false
	};

	//================//
	//VALIDATE INPUTS//
	//================//
	if (_ref_target == -1 || !instance_exists(_ref_target)){
		return _stct_result;
	}

	if (!variable_instance_exists(_ref_target,"_val_armor") || !is_real(_ref_target._val_armor)){
		return _stct_result;
	}

	var _val_before = _ref_target._val_armor;
	_stct_result._val_armor_before = _val_before;
	_stct_result._val_armor_after = _val_before;

	if (!is_real(_val_amount) || _val_amount <= 0 || _val_before <= 0){
		return _stct_result;
	}

	//================//
	//REMOVE ARMOR//
	//================//
	var _val_removed = min(_val_before,_val_amount);
	_ref_target._val_armor = max(0,_val_before - _val_removed);

	_stct_result._val_armor_removed = _val_removed;
	_stct_result._val_armor_after = _ref_target._val_armor;
	_stct_result._flag_armor_broken = (_val_before > 0 && _ref_target._val_armor <= 0);

	return _stct_result;
}