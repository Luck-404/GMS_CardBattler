//===============================================================================//
//
// SCRIPT: SCR_INIT_BEAST_RANDOM
// FUNCTION: Creates a randomized beast struct from a base beast.
//           Randomizes its color subtype, ability, and breed.
//           Initializes HP values and assigns a unique UID.
//
//===============================================================================//

function scr_init_beast_random(_str_beast_name){

	// GET BASE BEAST
	var _stct_new_beast = scr_get_beast_info(_str_beast_name);

	//
	// RANDOMIZE COLOR TYPE
	//
	#region COLOR TYPE
	var _arr_color_types = _stct_new_beast._str_beast_color_type;
	_stct_new_beast._str_beast_color_type = _arr_color_types[irandom(array_length(_arr_color_types) - 1)];
	#endregion

	//
	// RANDOMIZE ABILITY
	//
	#region ABILITY
	var _arr_abilities = _stct_new_beast._str_beast_ability;
	_stct_new_beast._str_beast_ability = _arr_abilities[irandom(array_length(_arr_abilities) - 1)];
	#endregion

	//
	// RANDOMIZE BREED
	//
	#region BREED
	var _arr_breeds = [
		"BULKY",
		"HALE",
		"STRONG",
		"INTELLIGENT",
		"STEADFAST",
		"WARDED"
	];

	_stct_new_beast._str_beast_breed = _arr_breeds[irandom(array_length(_arr_breeds) - 1)];
	#endregion

	//
	// INITIALIZE HP
	//
	#region HP
	var _val_hp_modifier = scr_get_beast_grade_modifier(_stct_new_beast._val_beast_hp_stat);
	var _val_hp = ceil(10 + ((_val_hp_modifier * 10) * _stct_new_beast._val_beast_level) / 4);

	_stct_new_beast._val_beast_hp_cur = _val_hp;
	_stct_new_beast._val_beast_hp_max = _val_hp;
	#endregion

	//
	// ASSIGN UID
	//
	#region UID
	_stct_new_beast.beast_uid = global.uid_next_beast;
	global.uid_next_beast++;
	#endregion

	return _stct_new_beast;
}