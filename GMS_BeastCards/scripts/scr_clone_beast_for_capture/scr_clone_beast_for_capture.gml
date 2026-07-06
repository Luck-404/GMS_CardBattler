//===============================================================================//
//
// SCRIPT: SCR_CLONE_BEAST_FOR_CAPTURE
// FUNCTION: Creates an independent captured beast copy from a battle beast.
//           Copies the enemy's unit struct instead of reusing the same reference.
//           Assigns a new beast UID and preserves current battle HP.
//
//===============================================================================//

function scr_clone_beast_for_capture(_ref_battle_beast){

	if (!instance_exists(_ref_battle_beast)){
		return undefined;
	}

	if (_ref_battle_beast._ref_unit == undefined){
		return undefined;
	}

	var _stct_source = _ref_battle_beast._ref_unit;
	var _stct_copy = {};

	//—------------------------------------------------------------------------------//
	// LOCAL HELPER: CLONE ARRAY
	//—------------------------------------------------------------------------------//
	function hscr_clone_array(_arr_source){

		var _arr_copy = [];

		for (var _it_value = 0; _it_value < array_length(_arr_source); _it_value++){
			array_push(_arr_copy,_arr_source[_it_value]);
		}

		return _arr_copy;
	}

	//—------------------------------------------------------------------------------//
	// COPY STRUCT VARIABLES
	//—------------------------------------------------------------------------------//
	var _arr_names = variable_struct_get_names(_stct_source);

	for (var _it_name = 0; _it_name < array_length(_arr_names); _it_name++){

		var _str_name = _arr_names[_it_name];
		var _val_source = variable_struct_get(_stct_source,_str_name);

		if (is_array(_val_source)){
			variable_struct_set(_stct_copy,_str_name,hscr_clone_array(_val_source));
		}
		else{
			variable_struct_set(_stct_copy,_str_name,_val_source);
		}
	}

	//—------------------------------------------------------------------------------//
	// GIVE THE CAPTURED COPY A NEW UID
	//—------------------------------------------------------------------------------//
	_stct_copy._uid_beast = global.uid_next_beast;
	global.uid_next_beast++;

	//—------------------------------------------------------------------------------//
	// PRESERVE BATTLE HP, BUT DO NOT CAPTURE AS DEAD
	//—------------------------------------------------------------------------------//
	_stct_copy._val_beast_hp_cur = max(1,_ref_battle_beast._val_cur_hp);
	_stct_copy._val_beast_hp_max = _ref_battle_beast._val_max_hp;

	return _stct_copy;
}