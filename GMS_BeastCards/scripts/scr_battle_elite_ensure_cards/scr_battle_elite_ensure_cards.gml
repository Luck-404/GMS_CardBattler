//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ELITE_ENSURE_CARDS
// FUNCTION: Ensures an Elite Beast has the requested number of persisted special
//           Elite Card IDs.
//
//           The Beast's primary color is taken from _arr_beast_colors[0], with
//           the second color used only as a fallback when the first is invalid.
//
//           New rolls first filter the color pool to Cards that satisfy the same
//           static caster requirements enforced by SCR_BATTLE_CAST_CARD: Card
//           color, Beast Archetype, and Beast Class. Invalid persisted Elite Card
//           IDs are discarded and replaced from the legal pool.
//
//           Legal rolls prefer Elite Cards that are not already present in the
//           Beast's ordinary deck and never duplicate another persisted Elite
//           Card when alternatives exist.
//
//           Existing legal Elite Card IDs are preserved. This allows modifiers
//           such as SCHOLARLY to request a second Elite Card without rerolling
//           the first.
//
// ARGUMENTS: _stct_unit - Initialized Elite Beast struct.
//            _arr_base_deck - Ordinary Card structs already assigned to Beast.
//            _ct_required - Number of persisted Elite Cards required.
// RETURNS: Persisted Elite Card ID array. Empty when validation fails.
//
//===============================================================================//

function scr_battle_elite_ensure_cards(_stct_unit,_arr_base_deck,_ct_required=1){
	#region VALIDATION

	if (!is_struct(_stct_unit)){
		return [];
	}

	if (
		!variable_struct_exists(_stct_unit,"_flag_elite") ||
		!_stct_unit._flag_elite
	){
		return [];
	}

	if (
		!variable_struct_exists(_stct_unit,"_arr_beast_colors") ||
		!is_array(_stct_unit._arr_beast_colors) ||
		array_length(_stct_unit._arr_beast_colors) < 2 ||
		!variable_struct_exists(_stct_unit,"_str_beast_archetype") ||
		!variable_struct_exists(_stct_unit,"_str_beast_class")
	){
		return [];
	}

	_ct_required =
		max(
			0,
			floor(
				_ct_required
			)
		);

	if (_ct_required <= 0){
		return [];
	}

	if (!is_array(_arr_base_deck)){
		_arr_base_deck = [];
	}

	#endregion

	#region ELITE COLOR

	var _str_elite_color = "";

	for (
		var _it_color = 0;
		_it_color <
			min(
				2,
				array_length(
					_stct_unit._arr_beast_colors
				)
			);
		_it_color++
	){

		var _var_color =
			_stct_unit._arr_beast_colors[
				_it_color
			];

		if (_var_color == undefined){
			continue;
		}

		var _str_try_color =
			string_upper(
				string(
					_var_color
				)
			);

		if (
			_str_try_color == "VIRIDIAN" ||
			_str_try_color == "CERULEAN" ||
			_str_try_color == "VERMILION"
		){
			_str_elite_color =
				_str_try_color;

			break;
		}
	}

	if (_str_elite_color == ""){
		return [];
	}

	var _arr_elite_pool =
		scr_battle_elite_get_card_pool(
			_str_elite_color
		);

	if (
		!is_array(_arr_elite_pool) ||
		array_length(_arr_elite_pool) <= 0
	){
		return [];
	}

	#endregion

	#region LEGAL ELITE POOL

	var _arr_legal_elite_pool = [];

	var _str_beast_color_1 = _stct_unit._arr_beast_colors[0];
	var _str_beast_color_2 = _stct_unit._arr_beast_colors[1];

	for (
		var _it_pool = 0;
		_it_pool < array_length(_arr_elite_pool);
		_it_pool++
	){

		var _str_candidate =
			string_upper(
				string(
					_arr_elite_pool[_it_pool]
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
			_arr_legal_elite_pool,
			_str_candidate
		);
	}

	#endregion

	#region METADATA

	if (
		!variable_struct_exists(
			_stct_unit,
			"_arr_elite_card_ids"
		) ||
		!is_array(
			_stct_unit._arr_elite_card_ids
		)
	){
		_stct_unit._arr_elite_card_ids = [];
	}

	if (
		!variable_struct_exists(
			_stct_unit,
			"_str_elite_primary_card_id"
		)
	){
		_stct_unit._str_elite_primary_card_id = "";
	}

	#endregion

	#region BASE DECK IDS

	var _arr_base_card_ids = [];

	for (
		var _it_base = 0;
		_it_base <
			array_length(
				_arr_base_deck
			);
		_it_base++
	){

		var _stct_base_card =
			_arr_base_deck[
				_it_base
			];

		if (!is_struct(_stct_base_card)){
			continue;
		}

		var _str_base_card_id = "";

		if (
			variable_struct_exists(
				_stct_base_card,
				"_str_card_id"
			)
		){
			_str_base_card_id =
				string_upper(
					string(
						_stct_base_card
							._str_card_id
					)
				);
		}
		else if (
			variable_struct_exists(
				_stct_base_card,
				"_str_card_name"
			)
		){
			_str_base_card_id =
				string_upper(
					string(
						_stct_base_card
							._str_card_name
					)
				);
		}

		if (_str_base_card_id == ""){
			continue;
		}

		array_push(
			_arr_base_card_ids,
			_str_base_card_id
		);
	}

	#endregion

	#region CLEAN EXISTING ELITE IDS

	var _arr_existing_clean = [];

	for (
		var _it_existing = 0;
		_it_existing <
			array_length(
				_stct_unit._arr_elite_card_ids
			);
		_it_existing++
	){

		var _str_existing_id =
			string_upper(
				string(
					_stct_unit._arr_elite_card_ids[
						_it_existing
					]
				)
			);

		if (_str_existing_id == ""){
			continue;
		}

		var _flag_in_pool = false;

		for (
			var _it_pool_check = 0;
			_it_pool_check <
				array_length(
					_arr_legal_elite_pool
				);
			_it_pool_check++
		){

			if (
				_arr_legal_elite_pool[
					_it_pool_check
				] ==
				_str_existing_id
			){
				_flag_in_pool = true;
				break;
			}
		}

		if (!_flag_in_pool){
			continue;
		}

		var _flag_duplicate = false;

		for (
			var _it_clean = 0;
			_it_clean <
				array_length(
					_arr_existing_clean
				);
			_it_clean++
		){

			if (
				_arr_existing_clean[
					_it_clean
				] ==
				_str_existing_id
			){
				_flag_duplicate = true;
				break;
			}
		}

		if (_flag_duplicate){
			continue;
		}

		array_push(
			_arr_existing_clean,
			_str_existing_id
		);
	}

	_stct_unit._arr_elite_card_ids =
		_arr_existing_clean;

	#endregion

	#region ROLL MISSING ELITE CARDS

	while (
		array_length(
			_stct_unit._arr_elite_card_ids
		) <
		_ct_required
	){

		var _arr_candidates = [];

		// Prefer a special Card that is not already in the normal Beast deck.
		for (
			var _it_pool = 0;
			_it_pool <
				array_length(
					_arr_legal_elite_pool
				);
			_it_pool++
		){

			var _str_candidate =
				_arr_legal_elite_pool[
					_it_pool
				];

			var _flag_used = false;

			for (
				var _it_used = 0;
				_it_used <
					array_length(
						_stct_unit._arr_elite_card_ids
					);
				_it_used++
			){

				if (
					_stct_unit._arr_elite_card_ids[
						_it_used
					] ==
					_str_candidate
				){
					_flag_used = true;
					break;
				}
			}

			if (_flag_used){
				continue;
			}

			var _flag_in_base_deck = false;

			for (
				var _it_base_id = 0;
				_it_base_id <
					array_length(
						_arr_base_card_ids
					);
				_it_base_id++
			){

				if (
					_arr_base_card_ids[
						_it_base_id
					] ==
					_str_candidate
				){
					_flag_in_base_deck = true;
					break;
				}
			}

			if (_flag_in_base_deck){
				continue;
			}

			array_push(
				_arr_candidates,
				_str_candidate
			);
		}

		// If every remaining Elite Card is already in the base deck, permit one
		// of those Cards rather than failing the Elite deck build.
		if (array_length(_arr_candidates) <= 0){

			for (
				var _it_pool = 0;
				_it_pool <
					array_length(
						_arr_legal_elite_pool
					);
				_it_pool++
			){

				var _str_candidate =
					_arr_legal_elite_pool[
						_it_pool
					];

				var _flag_used = false;

				for (
					var _it_used = 0;
					_it_used <
						array_length(
							_stct_unit._arr_elite_card_ids
						);
					_it_used++
				){

					if (
						_stct_unit._arr_elite_card_ids[
							_it_used
						] ==
						_str_candidate
					){
						_flag_used = true;
						break;
					}
				}

				if (!_flag_used){
					array_push(
						_arr_candidates,
						_str_candidate
					);
				}
			}
		}

		if (array_length(_arr_candidates) <= 0){
			break;
		}

		var _str_selected_card =
			_arr_candidates[
				irandom(
					array_length(
						_arr_candidates
					) -
					1
				)
			];

		array_push(
			_stct_unit._arr_elite_card_ids,
			_str_selected_card
		);

		scr_debug_log(
			"BATTLE",
			"ELITE",
			_stct_unit,
			"ELITE CARD ROLLED" +
			" | BEAST: " +
			string_upper(
				string(
					_stct_unit._str_beast_name
				)
			) +
			" | COLOR: " +
			_str_elite_color +
			" | CARD: " +
			_str_selected_card +
			" | ELITE CARD COUNT: " +
			string(
				array_length(
					_stct_unit._arr_elite_card_ids
				)
			),
			"INIT",
			"SCR_BATTLE_ELITE_ENSURE_CARDS"
		);
	}

	#endregion

	#region PRIMARY CARD

	if (
		array_length(
			_stct_unit._arr_elite_card_ids
		) > 0
	){
		_stct_unit._str_elite_primary_card_id =
			_stct_unit._arr_elite_card_ids[0];
	}
	else{
		_stct_unit._str_elite_primary_card_id = "";
	}

	#endregion

	return _stct_unit._arr_elite_card_ids;
}
