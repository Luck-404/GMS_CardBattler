//===============================================================================//
//
// SCRIPT: SCR_BATTLE_CLONE_BEAST_FOR_CAPTURE
// FUNCTION: Creates an independent captured Beast copy from a battle Beast.
//           Copies the enemy's unit struct without reusing its original struct
//           reference, assigns a new Beast UID, and preserves current battle HP.
//
// INPUT:    _ref_battle_beast - Battle Beast instance being captured.
// USES:     The battle Beast's _ref_unit struct and global.uid_next_beast.
//           Arrays are shallow-copied so the captured struct owns new arrays.
//
//===============================================================================//

function scr_battle_clone_beast_for_capture(_ref_battle_beast){

	#region VALIDATION

	//----------------------//
	//VALIDATE BATTLE BEAST//
	//----------------------//
	if (!instance_exists(_ref_battle_beast)){
		return undefined;
	}

	if (!is_struct(_ref_battle_beast._ref_unit)){
		return undefined;
	}

	#endregion

	#region COPY BEAST DATA

	//------------------//
	//INITIALIZE STRUCTS//
	//------------------//
	var _stct_source_beast = _ref_battle_beast._ref_unit;
	var _stct_captured_beast = {};

	//---------------------//
	//GET STRUCT VARIABLES//
	//---------------------//
	var _arr_variable_names = variable_struct_get_names(_stct_source_beast);

	//----------------------//
	//COPY STRUCT VARIABLES//
	//----------------------//
	for (var _it_variable = 0; _it_variable < array_length(_arr_variable_names); _it_variable++){

		var _str_variable_name = _arr_variable_names[_it_variable];

		//------------//
		//COPY ARRAYS//
		//------------//
		if (is_array(variable_struct_get(_stct_source_beast,_str_variable_name))){

			var _arr_source = variable_struct_get(_stct_source_beast,_str_variable_name);
			var _arr_copy = [];

			for (var _it_array = 0; _it_array < array_length(_arr_source); _it_array++){
				array_push(_arr_copy,_arr_source[_it_array]);
			}

			variable_struct_set(_stct_captured_beast,_str_variable_name,_arr_copy);
		}

		//--------------------//
		//COPY OTHER VARIABLES//
		//--------------------//
		else{
			variable_struct_set(_stct_captured_beast,_str_variable_name,variable_struct_get(_stct_source_beast,_str_variable_name));
		}
	}

	#endregion

	#region CAPTURE STATE

	//---------------//
	//ASSIGN NEW UID//
	//---------------//
	_stct_captured_beast._uid_beast = global.uid_next_beast;
	global.uid_next_beast++;

	//-------------------//
	//PRESERVE MAXIMUM HP//
	//-------------------//
	var _val_captured_max_hp = max(1,_stct_source_beast._val_beast_hp_max);

	_stct_captured_beast._val_beast_hp_max = _val_captured_max_hp;

	//-------------------//
	//PRESERVE CURRENT HP//
	//-------------------//
	_stct_captured_beast._val_beast_hp_cur = clamp(_ref_battle_beast._val_cur_hp,1,_val_captured_max_hp);

	#endregion

	return _stct_captured_beast;
}