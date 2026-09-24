//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRANSFER_ARMOR
// FUNCTION: Moves existing Armor between battle Beasts without generating Armor.
//           Does not apply Armorbreak, Armor-gain reactions, damage or feedback.
//
// ARGUMENTS: _ref_source - Beast giving up Armor.
//            _ref_target - Beast receiving Armor.
//            _val_amount - maximum Armor to transfer.
// RETURNS: Struct: _val_armor_transferred, source/target Armor before and after.
//          Invalid, zero and self-transfers are no-ops.
//
//===============================================================================//
function scr_battle_transfer_armor(_ref_source,_ref_target,_val_amount){
	//================//
	//DEFAULT RESULT//
	//================//
	var _stct_result = {
		_val_armor_transferred : 0,
		_val_source_before : 0,
		_val_source_after : 0,
		_val_target_before : 0,
		_val_target_after : 0
	};

	//================//
	//VALIDATE BEASTS//
	//================//
	if (_ref_source == -1 || _ref_target == -1 || !instance_exists(_ref_source) || !instance_exists(_ref_target)){
		return _stct_result;
	}

	if (!variable_instance_exists(_ref_source,"_val_armor") || !variable_instance_exists(_ref_target,"_val_armor")){
		return _stct_result;
	}

	if (!is_real(_ref_source._val_armor) || !is_real(_ref_target._val_armor)){
		return _stct_result;
	}

	_stct_result._val_source_before = _ref_source._val_armor;
	_stct_result._val_source_after = _ref_source._val_armor;
	_stct_result._val_target_before = _ref_target._val_armor;
	_stct_result._val_target_after = _ref_target._val_armor;

	if (_ref_source == _ref_target || !is_real(_val_amount) || _val_amount <= 0 || _ref_source._val_armor <= 0){
		return _stct_result;
	}

	//================//
	//TRANSFER ARMOR//
	//================//
	var _val_transfer = min(_ref_source._val_armor,_val_amount);
	_ref_source._val_armor = max(0,_ref_source._val_armor - _val_transfer);
	_ref_target._val_armor += _val_transfer;

	_stct_result._val_armor_transferred = _val_transfer;
	_stct_result._val_source_after = _ref_source._val_armor;
	_stct_result._val_target_after = _ref_target._val_armor;

	return _stct_result;
}
