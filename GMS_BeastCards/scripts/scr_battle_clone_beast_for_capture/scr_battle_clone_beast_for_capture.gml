//===============================================================================//
//
// SCRIPT: SCR_BATTLE_CLONE_BEAST_FOR_CAPTURE
// FUNCTION: Creates an independent captured Beast copy from a battle Beast.
//
//           Copies the enemy's persistent Beast struct without reusing its
//           original struct reference, assigns a new Beast UID, and preserves
//           the Beast's current battle Maximum HP and Current HP.
//
//           Battle Beast instances use:
//               _val_cur_hp
//               _val_max_hp
//
//           Persistent Beast structs use:
//               _val_beast_hp_cur
//               _val_beast_hp_max
//
// INPUT:    _ref_battle_beast - Battle Beast instance being captured.
// USES:     The battle Beast's _ref_unit struct and global.uid_next_beast.
//           Arrays are shallow-copied so the captured struct owns new arrays.
//
// RETURNS:  Independent persistent Beast struct, or undefined on failure.
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

	if (
		!variable_instance_exists(
			_ref_battle_beast,
			"_ref_unit"
		) ||
		!is_struct(
			_ref_battle_beast._ref_unit
		)
	){
		return undefined;
	}

	if (
		!variable_instance_exists(
			_ref_battle_beast,
			"_val_max_hp"
		) ||
		!variable_instance_exists(
			_ref_battle_beast,
			"_val_cur_hp"
		)
	){
		return undefined;
	}

	#endregion

	#region COPY BEAST DATA

	//------------------//
	//INITIALIZE STRUCTS//
	//------------------//
	var _stct_source_beast =
		_ref_battle_beast._ref_unit;

	var _stct_captured_beast = {};

	//---------------------//
	//GET STRUCT VARIABLES//
	//---------------------//
	var _arr_variable_names =
		variable_struct_get_names(
			_stct_source_beast
		);

	//----------------------//
	//COPY STRUCT VARIABLES//
	//----------------------//
	for (
		var _it_variable = 0;
		_it_variable <
			array_length(
				_arr_variable_names
			);
		_it_variable++
	){

		var _str_variable_name =
			_arr_variable_names[
				_it_variable
			];

		var _var_source =
			variable_struct_get(
				_stct_source_beast,
				_str_variable_name
			);

		//------------//
		//COPY ARRAYS//
		//------------//
		if (is_array(_var_source)){

			var _arr_copy = [];

			for (
				var _it_array = 0;
				_it_array <
					array_length(
						_var_source
					);
				_it_array++
			){
				array_push(
					_arr_copy,
					_var_source[
						_it_array
					]
				);
			}

			variable_struct_set(
				_stct_captured_beast,
				_str_variable_name,
				_arr_copy
			);
		}

		//--------------------//
		//COPY OTHER VARIABLES//
		//--------------------//
		else{
			variable_struct_set(
				_stct_captured_beast,
				_str_variable_name,
				_var_source
			);
		}
	}

	#endregion

	#region CAPTURE STATE

	//---------------//
	//ASSIGN NEW UID//
	//---------------//
	_stct_captured_beast._uid_beast =
		global.uid_next_beast;

	global.uid_next_beast++;

	//-------------------//
	//PRESERVE MAXIMUM HP//
	//-------------------//
	var _val_captured_max_hp =
		max(
			1,
			_ref_battle_beast._val_max_hp
		);

	_stct_captured_beast._val_beast_hp_max =
		_val_captured_max_hp;

	//-------------------//
	//PRESERVE CURRENT HP//
	//-------------------//
	_stct_captured_beast._val_beast_hp_cur =
		clamp(
			_ref_battle_beast._val_cur_hp,
			1,
			_val_captured_max_hp
		);

	#endregion

	return _stct_captured_beast;
}