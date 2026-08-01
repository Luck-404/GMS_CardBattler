//===============================================================================//
//
// SCRIPT: SCR_INIT_BEAST_RANDOM
// FUNCTION: Creates a randomized Beast struct from its base Beast data.
//           Randomizes its color subtype, ability, and breed.
//           Calculates maximum HP and assigns a unique Beast UID.
//
//===============================================================================//

function scr_init_beast_random(_str_beast_name){

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

	//---------------------//
	//RANDOMIZE COLOR TYPE//
	//---------------------//
	#region COLOR TYPE

	var _arr_color_types =
		_stct_new_beast._str_beast_color_type;

	_stct_new_beast._str_beast_color_type =
		_arr_color_types[
			irandom(array_length(_arr_color_types) - 1)
		];

	#endregion

	//-----------------//
	//RANDOMIZE ABILITY//
	//-----------------//
	#region ABILITY

	var _arr_abilities =
		_stct_new_beast._str_beast_ability;

	_stct_new_beast._str_beast_ability =
		_arr_abilities[
			irandom(array_length(_arr_abilities) - 1)
		];

	#endregion

	//---------------//
	//RANDOMIZE BREED//
	//---------------//
	#region BREED

	var _arr_breeds = [
		"BULKY",
		"HALE",
		"STRONG",
		"INTELLIGENT",
		"STEADFAST",
		"WARDED"
	];

	_stct_new_beast._str_beast_breed =
		_arr_breeds[
			irandom(array_length(_arr_breeds) - 1)
		];

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