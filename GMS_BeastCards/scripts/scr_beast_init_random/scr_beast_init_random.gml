//===============================================================================//
//
// SCRIPT: SCR_BEAST_INIT_RANDOM
// FUNCTION: Creates a randomized Beast struct from its base Beast definition.
//           Randomizes its color subtype, ability, and breed.
//           Initializes persistent runtime fields, HP, held item state,
//           and assigns a unique Beast UID.
//
// ARGUMENTS: _str_beast_name is the Beast species to initialize.
// RETURNS: A newly randomized Beast struct, or undefined if initialization fails.
//
//===============================================================================//

function scr_beast_init_random(_str_beast_name){

	//================//
	//GET BASE BEAST//
	//================//
	var _stct_new_beast = scr_beast_get_info(_str_beast_name);

	if (!is_struct(_stct_new_beast)){

		scr_debug_log(
			"BEAST",
			"INIT",
			undefined,
			"INVALID BEAST DEFINITION: " + string_upper(string(_str_beast_name)),
			"ERROR",
			"SCR_BEAST_INIT_RANDOM"
		);

		return undefined;
	}

	//======================//
	//INITIALIZE HELD ITEM//
	//======================//
	_stct_new_beast._stct_beast_held_item = "EMPTY";

	//======================//
	//RANDOMIZE COLOR TYPE//
	//======================//
	var _arr_color_types = _stct_new_beast._arr_beast_color_types;

	if (
		!is_array(_arr_color_types) ||
		array_length(_arr_color_types) <= 0
	){

		scr_debug_log(
			"BEAST",
			"INIT",
			_stct_new_beast,
			"INVALID COLOR TYPE ARRAY",
			"ERROR",
			"SCR_BEAST_INIT_RANDOM"
		);

		return undefined;
	}

	_stct_new_beast._str_beast_color_type = _arr_color_types[
		irandom(array_length(_arr_color_types) - 1)
	];

	//==================//
	//RANDOMIZE ABILITY//
	//==================//
	var _arr_abilities = _stct_new_beast._arr_beast_abilities;

	if (
		!is_array(_arr_abilities) ||
		array_length(_arr_abilities) <= 0
	){

		scr_debug_log(
			"BEAST",
			"INIT",
			_stct_new_beast,
			"INVALID ABILITY ARRAY",
			"ERROR",
			"SCR_BEAST_INIT_RANDOM"
		);

		return undefined;
	}

	_stct_new_beast._str_beast_ability = _arr_abilities[
		irandom(array_length(_arr_abilities) - 1)
	];

	//================//
	//RANDOMIZE BREED//
	//================//
	static _arr_breeds = [
		"BULKY",
		"HALE",
		"STRONG",
		"INTELLIGENT",
		"STEADFAST",
		"WARDED"
	];

	_stct_new_beast._str_beast_breed = _arr_breeds[
		irandom(array_length(_arr_breeds) - 1)
	];

	//================//
	//INITIALIZE HP//
	//================//
	var _val_max_hp = scr_beast_get_max_hp(
		_stct_new_beast._val_beast_hp_stat,
		_stct_new_beast._val_beast_level
	);

	if (_val_max_hp <= 0){

		scr_debug_log(
			"BEAST",
			"INIT",
			_stct_new_beast,
			"INVALID MAXIMUM HP: " + string(_val_max_hp),
			"ERROR",
			"SCR_BEAST_INIT_RANDOM"
		);

		return undefined;
	}

	_stct_new_beast._val_beast_hp_max = _val_max_hp;
	_stct_new_beast._val_beast_hp_cur = _val_max_hp;

	//================//
	//ASSIGN UID//
	//================//
	_stct_new_beast._uid_beast = global.uid_next_beast;
	global.uid_next_beast++;

	return _stct_new_beast;
}