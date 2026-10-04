//===============================================================================//
//
// SCRIPT: SCR_BEAST_GET_FORMATION_PRIORITY
// FUNCTION: Converts a Beast's preferred formation-role tags into one sortable
//           front-to-back priority value for enemy battle initialization.
//
//           FL = 0
//           MF = 1
//           C  = 2
//           MB = 3
//           BL = 4
//
//           Multi-role Beasts use the average of their listed roles.
//           If role metadata is missing, Archetype provides a soft fallback.
//
// ARGUMENTS: _stct_beast - Beast data struct.
// RETURNS: Formation priority from 0 to 4.
//
//===============================================================================//

function scr_beast_get_formation_priority(_stct_beast){

	#region VALIDATION

	//================//
	//VALIDATE BEAST//
	//================//
	if (!is_struct(_stct_beast)){
		return 2;
	}

	#endregion

	#region ROLE TAGS

	//================//
	//GET ROLE PREFIX//
	//================//
	var _str_role_tags = "";

	if (
		variable_struct_exists(
			_stct_beast,
			"_str_beast_role"
		)
	){

		_str_role_tags =
			string_upper(
				string(
					_stct_beast._str_beast_role
				)
			);

		var _it_separator =
			string_pos(
				"|",
				_str_role_tags
			);

		if (_it_separator > 0){

			_str_role_tags =
				string_copy(
					_str_role_tags,
					1,
					_it_separator - 1
				);
		}

		_str_role_tags =
			string_replace_all(
				_str_role_tags,
				" ",
				""
			);

		_str_role_tags =
			"," +
			_str_role_tags +
			",";
	}

	//===================//
	//ACCUMULATE ROLES//
	//===================//
	var _val_priority_total = 0;
	var _ct_roles = 0;

	if (string_pos(",FL,",_str_role_tags) > 0){
		_val_priority_total += 0;
		_ct_roles++;
	}

	if (string_pos(",MF,",_str_role_tags) > 0){
		_val_priority_total += 1;
		_ct_roles++;
	}

	if (string_pos(",C,",_str_role_tags) > 0){
		_val_priority_total += 2;
		_ct_roles++;
	}

	if (string_pos(",MB,",_str_role_tags) > 0){
		_val_priority_total += 3;
		_ct_roles++;
	}

	if (string_pos(",BL,",_str_role_tags) > 0){
		_val_priority_total += 4;
		_ct_roles++;
	}

	if (_ct_roles > 0){
		return _val_priority_total / _ct_roles;
	}

	#endregion

	#region ARCHETYPE FALLBACK

	//====================//
	//ARCHETYPE FALLBACK//
	//====================//
	if (
		variable_struct_exists(
			_stct_beast,
			"_str_beast_archetype"
		)
	){

		switch (
			string_upper(
				string(
					_stct_beast._str_beast_archetype
				)
			)
		){

			case "MARTIAL":
				return 1;

			case "MAGICAL":
			case "TECHNICAL":
				return 3;
		}
	}

	#endregion

	return 2;
}