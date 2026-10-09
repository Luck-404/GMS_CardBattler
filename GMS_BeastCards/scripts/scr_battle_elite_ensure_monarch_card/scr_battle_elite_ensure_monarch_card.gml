//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ELITE_ENSURE_MONARCH_CARD
// FUNCTION: Ensures a MONARCH Elite has one persisted legal Archetype Card.
//
//           The candidate must:
//           - belong to the Monarch pool for the Beast's primary color;
//           - exist in SCR_CARD_GET_INFO;
//           - be an ARCHETYPE Card;
//           - satisfy the Card-color requirement used by SCR_BATTLE_CAST_CARD;
//           - satisfy the Beast's Archetype requirement when one exists;
//           - satisfy the Beast's Class requirement when one exists.
//
//           New rolls prefer a Card not already present in the ordinary deck or
//           persisted Elite-card array. Existing valid persisted Monarch Cards
//           are retained.
//
// ARGUMENTS: _stct_unit - initialized Elite Beast struct.
//            _arr_current_deck - Card structs already assigned before Monarch.
// RETURNS: persisted Monarch Card ID, or "" when no legal Card exists.
//
//===============================================================================//
function scr_battle_elite_ensure_monarch_card(_stct_unit,_arr_current_deck=[]){
	#region VALIDATION

	if (!is_struct(_stct_unit)){
		return "";
	}

	if (
		!variable_struct_exists(_stct_unit,"_flag_elite") ||
		!_stct_unit._flag_elite ||
		!variable_struct_exists(_stct_unit,"_str_elite_modifier") ||
		string_upper(string(_stct_unit._str_elite_modifier)) != "MONARCH"
	){
		return "";
	}

	if (
		!variable_struct_exists(_stct_unit,"_arr_beast_colors") ||
		!is_array(_stct_unit._arr_beast_colors) ||
		array_length(_stct_unit._arr_beast_colors) < 2 ||
		!variable_struct_exists(_stct_unit,"_str_beast_archetype") ||
		!variable_struct_exists(_stct_unit,"_str_beast_class")
	){
		return "";
	}

	if (!is_array(_arr_current_deck)){
		_arr_current_deck = [];
	}

	#endregion

	#region BEAST DATA

	var _str_color = "";

	for (
		var _it_color = 0;
		_it_color < min(2,array_length(_stct_unit._arr_beast_colors));
		_it_color++
	){
		var _var_color = _stct_unit._arr_beast_colors[_it_color];

		if (_var_color == undefined){
			continue;
		}

		var _str_try_color = string_upper(string(_var_color));

		if (
			_str_try_color == "VIRIDIAN" ||
			_str_try_color == "CERULEAN" ||
			_str_try_color == "VERMILION"
		){
			_str_color = _str_try_color;
			break;
		}
	}

	if (_str_color == ""){
		return "";
	}

	var _str_archetype =
		(_stct_unit._str_beast_archetype == undefined)
		? ""
		: string_upper(string(_stct_unit._str_beast_archetype));

	var _str_class =
		(_stct_unit._str_beast_class == undefined)
		? ""
		: string_upper(string(_stct_unit._str_beast_class));

	var _str_beast_color_1 = _stct_unit._arr_beast_colors[0];
	var _str_beast_color_2 = _stct_unit._arr_beast_colors[1];

	#endregion

	#region USED CARD IDS

	var _arr_used_ids = [];

	for (
		var _it_card = 0;
		_it_card < array_length(_arr_current_deck);
		_it_card++
	){
		var _stct_card = _arr_current_deck[_it_card];

		if (!is_struct(_stct_card)){
			continue;
		}

		var _str_card_id = "";

		if (variable_struct_exists(_stct_card,"_str_card_id")){
			_str_card_id =
				string_upper(
					string(
						_stct_card._str_card_id
					)
				);
		}

		if (_str_card_id != ""){
			array_push(_arr_used_ids,_str_card_id);
		}
	}

	if (
		variable_struct_exists(_stct_unit,"_arr_elite_card_ids") &&
		is_array(_stct_unit._arr_elite_card_ids)
	){
		for (
			var _it_elite = 0;
			_it_elite < array_length(_stct_unit._arr_elite_card_ids);
			_it_elite++
		){
			array_push(
				_arr_used_ids,
				string_upper(
					string(
						_stct_unit._arr_elite_card_ids[_it_elite]
					)
				)
			);
		}
	}

	#endregion

	#region LEGAL CANDIDATES

	var _arr_pool =
		scr_battle_elite_get_monarch_pool(
			_str_color
		);

	var _arr_legal = [];
	var _arr_legal_unused = [];

	for (
		var _it_pool = 0;
		_it_pool < array_length(_arr_pool);
		_it_pool++
	){
		var _str_candidate =
			string_upper(
				string(
					_arr_pool[_it_pool]
				)
			);

		var _stct_candidate =
			scr_card_get_info(
				_str_candidate
			);

		if (!is_struct(_stct_candidate)){
			continue;
		}

		if (
			!variable_struct_exists(_stct_candidate,"_str_card_type") ||
			string_upper(string(_stct_candidate._str_card_type)) != "ARCHETYPE"
		){
			continue;
		}

		if (
			!variable_struct_exists(_stct_candidate,"_arr_card_colors") ||
			!variable_struct_exists(_stct_candidate,"_str_card_archetype_req") ||
			!variable_struct_exists(_stct_candidate,"_str_card_class_req") ||
			!is_array(_stct_candidate._arr_card_colors) ||
			array_length(_stct_candidate._arr_card_colors) < 2
		){
			continue;
		}

		var _str_card_color_1 = _stct_candidate._arr_card_colors[0];
		var _str_card_color_2 = _stct_candidate._arr_card_colors[1];

		var _flag_color_match = (
			_str_card_color_1 == "UNCOLORED" ||
			_str_beast_color_1 == "UNCOLORED" ||
			_str_beast_color_2 == "UNCOLORED" ||
			(
				_str_card_color_1 != undefined &&
				(
					_str_card_color_1 == _str_beast_color_1 ||
					_str_card_color_1 == _str_beast_color_2
				)
			) ||
			(
				_str_card_color_2 != undefined &&
				(
					_str_card_color_2 == _str_beast_color_1 ||
					_str_card_color_2 == _str_beast_color_2
				)
			)
		);

		if (!_flag_color_match){
			continue;
		}

		if (
			_stct_candidate._str_card_archetype_req != undefined &&
			_stct_candidate._str_card_archetype_req !=
				_stct_unit._str_beast_archetype
		){
			continue;
		}

		if (
			_stct_candidate._str_card_class_req != undefined &&
			_stct_candidate._str_card_class_req !=
				_stct_unit._str_beast_class
		){
			continue;
		}

		array_push(
			_arr_legal,
			_str_candidate
		);

		var _flag_used =
			array_contains(
				_arr_used_ids,
				_str_candidate
			);

		if (!_flag_used){
			array_push(
				_arr_legal_unused,
				_str_candidate
			);
		}
	}

	if (array_length(_arr_legal) <= 0){
		_stct_unit._str_elite_monarch_card_id = "";

		scr_debug_log(
			"BATTLE",
			"ELITE",
			_stct_unit,
			"MONARCH CARD FAILED" +
			" | BEAST: " +
			string_upper(string(_stct_unit._str_beast_name)) +
			" | COLOR: " + _str_color +
			" | ARCHETYPE: " + _str_archetype +
			" | CLASS: " + _str_class +
			" | REASON: NO LEGAL ARCHETYPE CARD",
			"WARNING",
			"SCR_BATTLE_ELITE_ENSURE_MONARCH_CARD"
		);

		return "";
	}

	#endregion

	#region PRESERVE EXISTING

	if (
		variable_struct_exists(_stct_unit,"_str_elite_monarch_card_id")
	){
		var _str_existing =
			string_upper(
				string(
					_stct_unit._str_elite_monarch_card_id
				)
			);

		if (
			_str_existing != "" &&
			array_contains(
				_arr_legal,
				_str_existing
			)
		){
			_stct_unit._str_elite_monarch_card_id =
				_str_existing;

			return _str_existing;
		}
	}

	#endregion

	#region ROLL

	var _arr_roll_pool =
		(
			array_length(_arr_legal_unused) > 0
		)
		? _arr_legal_unused
		: _arr_legal;

	var _str_selected =
		_arr_roll_pool[
			irandom(
				array_length(_arr_roll_pool) - 1
			)
		];

	_stct_unit._str_elite_monarch_card_id =
		_str_selected;

	scr_debug_log(
		"BATTLE",
		"ELITE",
		_stct_unit,
		"MONARCH CARD ROLLED" +
		" | BEAST: " +
		string_upper(string(_stct_unit._str_beast_name)) +
		" | COLOR: " + _str_color +
		" | ARCHETYPE: " + _str_archetype +
		" | CLASS: " + _str_class +
		" | CARD: " + _str_selected,
		"INIT",
		"SCR_BATTLE_ELITE_ENSURE_MONARCH_CARD"
	);

	return _str_selected;

	#endregion
}
