//===============================================================================//
//
// SCRIPT: SCR_INIT_BEAST_SPECIFIC
// FUNCTION: Creates a Beast struct from its base Beast data.
//           Applies a specified color subtype, ability, and breed.
//           Calculates maximum HP and assigns a unique Beast UID.
//
//===============================================================================//

function scr_init_beast_specific(_str_beast_name,_arr_specific_data){

	//----------------//
	//GET BASE BEAST//
	//----------------//
	var _stct_new_beast = scr_get_beast_info(_str_beast_name);

	if (!is_struct(_stct_new_beast)){

		show_debug_message(
			"BEAST INIT ERROR | INVALID BEAST: " +
			string(_str_beast_name)
		);

		return undefined;
	}

	//----------//
	//COLOR TYPE//
	//----------//
	#region COLOR TYPE

	_stct_new_beast._str_beast_color_type =
		_arr_specific_data[0];

	#endregion

	//-------//
	//ABILITY//
	//-------//
	#region ABILITY

	_stct_new_beast._str_beast_ability =
		_arr_specific_data[1];

	#endregion

	//-----//
	//BREED//
	//-----//
	#region BREED

	_stct_new_beast._str_beast_breed =
		_arr_specific_data[2];

	#endregion

	//-------------//
	//INITIALIZE HP//
	//-------------//
	#region HP

	var _val_max_hp = scr_get_beast_max_hp(
		_stct_new_beast._val_beast_hp_stat,
		_stct_new_beast._val_beast_level
	);

	_stct_new_beast._val_beast_hp_max =
		_val_max_hp;

	_stct_new_beast._val_beast_hp_cur =
		_val_max_hp;

	if (_stct_new_beast._val_beast_hp_max <= 0){

		show_debug_message(
			"BEAST INIT ERROR | INVALID MAX HP | " +
			_stct_new_beast._str_beast_name
		);

		return undefined;
	}

	#endregion

	//----------//
	//ASSIGN UID//
	//----------//
	#region UID

	_stct_new_beast._uid_beast =
		global.uid_next_beast;

	global.uid_next_beast++;

	#endregion

	return _stct_new_beast;
}