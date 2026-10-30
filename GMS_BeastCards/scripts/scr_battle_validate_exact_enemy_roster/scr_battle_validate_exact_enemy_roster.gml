//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VALIDATE_EXACT_ENEMY_ROSTER
// FUNCTION: Validates a fully initialized exact enemy roster before it is handed
//           across an overworld-to-battle room transition.
//
//           Exact rosters contain 1-5 initialized Beast structs. Their species,
//           UID, level, subtype, breed, ability, held item, HP, and Elite metadata
//           are treated as authoritative by the enemy battle controller.
//
// ARGUMENTS: _arr_enemy_units - Candidate exact roster.
// RETURNS: True when every entry is a valid initialized Beast struct.
//
//===============================================================================//

function scr_battle_validate_exact_enemy_roster(_arr_enemy_units){

	if (!is_array(_arr_enemy_units)){
		return false;
	}

	var _ct_enemy_units =
		array_length(
			_arr_enemy_units
		);

	if (
		_ct_enemy_units < 1 ||
		_ct_enemy_units > 5
	){
		return false;
	}

	for (
		var _it_unit = 0;
		_it_unit < _ct_enemy_units;
		_it_unit++
	){

		var _stct_unit =
			_arr_enemy_units[
				_it_unit
			];

		if (!is_struct(_stct_unit)){
			return false;
		}

		if (
			!variable_struct_exists(
				_stct_unit,
				"_str_beast_name"
			) ||
			!is_string(
				_stct_unit
					._str_beast_name
			) ||
			_stct_unit
				._str_beast_name ==
			""
		){
			return false;
		}

		if (
			!variable_struct_exists(
				_stct_unit,
				"_uid_beast"
			) ||
			!is_real(
				_stct_unit
					._uid_beast
			) ||
			_stct_unit
				._uid_beast <
			0
		){
			return false;
		}

		if (
			!variable_struct_exists(
				_stct_unit,
				"_val_beast_level"
			) ||
			!is_real(
				_stct_unit
					._val_beast_level
			) ||
			_stct_unit
				._val_beast_level <=
			0
		){
			return false;
		}

		if (
			!variable_struct_exists(
				_stct_unit,
				"_val_beast_hp_max"
			) ||
			!variable_struct_exists(
				_stct_unit,
				"_val_beast_hp_cur"
			) ||
			!is_real(
				_stct_unit
					._val_beast_hp_max
			) ||
			!is_real(
				_stct_unit
					._val_beast_hp_cur
			) ||
			_stct_unit
				._val_beast_hp_max <=
			0 ||
			_stct_unit
				._val_beast_hp_cur <=
			0
		){
			return false;
		}

		if (
			!variable_struct_exists(
				_stct_unit,
				"_spr_beast"
			) ||
			_stct_unit
				._spr_beast ==
			undefined
		){
			return false;
		}

		if (
			!variable_struct_exists(
				_stct_unit,
				"_str_beast_color_type"
			) ||
			!is_string(
				_stct_unit
					._str_beast_color_type
			)
		){
			return false;
		}

		if (
			!variable_struct_exists(
				_stct_unit,
				"_str_beast_breed"
			) ||
			!is_string(
				_stct_unit
					._str_beast_breed
			)
		){
			return false;
		}

		if (
			!variable_struct_exists(
				_stct_unit,
				"_str_beast_ability"
			) ||
			!is_string(
				_stct_unit
					._str_beast_ability
			)
		){
			return false;
		}

		if (
			!variable_struct_exists(
				_stct_unit,
				"_stct_beast_held_item"
			)
		){
			return false;
		}
	}

	return true;
}
