//===============================================================================//
//
// SCRIPT: SCR_INIT_BEAST_SPECIFIC
// FUNCTION: Creates a beast struct from a base beast.
//           Applies a specific color subtype, ability, and breed.
//           Initializes HP values and assigns a unique UID.
//
//===============================================================================//

function scr_init_beast_specific(_str_beast_name,_arr_specific_data){

	// GET BASE BEAST
	var _stct_new_beast = scr_get_beast_info(_str_beast_name);

	//
	// COLOR TYPE
	//
	#region COLOR TYPE
	_stct_new_beast._str_beast_color_type = _arr_specific_data[0];
	#endregion

	//
	// ABILITY
	//
	#region ABILITY
	_stct_new_beast._str_beast_ability = _arr_specific_data[1];
	#endregion

	//
	// BREED
	//
	#region BREED
	_stct_new_beast._str_beast_breed = _arr_specific_data[2];
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