//===============================================================================//
//
// SCRIPT: SCR_BEAST_ADD_EXP
// FUNCTION: Adds EXP to a Beast and resolves any resulting Level-ups using the
//           Level-dependent EXP requirement.
//
//           EXP requirements are recalculated after every Level gained so stored
//           EXP can correctly cross multiple progression brackets.
//
// ARGUMENTS: _stct_beast - Beast struct receiving EXP.
//            _ct_exp - EXP amount to add.
// RETURNS: Number of Levels gained.
//
//===============================================================================//

function scr_beast_add_exp(_stct_beast,_ct_exp){

	#region VALIDATION

	if (!is_struct(_stct_beast)){
		return 0;
	}

	if (
		!variable_struct_exists(
			_stct_beast,
			"_val_beast_level"
		)
	){
		return 0;
	}

	if (
		!variable_struct_exists(
			_stct_beast,
			"_val_beast_exp"
		)
	){
		_stct_beast._val_beast_exp = 0;
	}

	_ct_exp =
		max(
			0,
			floor(
				_ct_exp
			)
		);

	#endregion

	#region LEVEL CAP

	if (_stct_beast._val_beast_level >= 30){

		_stct_beast._val_beast_level = 30;
		_stct_beast._val_beast_exp = 0;

		return 0;
	}

	#endregion

	#region ADD EXP

	_stct_beast._val_beast_exp +=
		_ct_exp;

	#endregion

	#region LEVEL UPS

	var _ct_levels_gained = 0;

	while (_stct_beast._val_beast_level < 30){

		var _ct_exp_required =
			scr_beast_get_exp_required(
				_stct_beast._val_beast_level
			);

		if (_ct_exp_required <= 0){
			break;
		}

		if (
			_stct_beast._val_beast_exp <
			_ct_exp_required
		){
			break;
		}

		_stct_beast._val_beast_exp -=
			_ct_exp_required;

		if (
			!scr_beast_level_up(
				_stct_beast
			)
		){
			break;
		}

		_ct_levels_gained++;
	}

	#endregion

	#region LEVEL CAP CLEANUP

	if (_stct_beast._val_beast_level >= 30){

		_stct_beast._val_beast_level = 30;
		_stct_beast._val_beast_exp = 0;
	}

	#endregion

	return _ct_levels_gained;
}