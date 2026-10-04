//===============================================================================//
//
// SCRIPT: SCR_REWARD_GET_BEAST_CARD_POOL
// FUNCTION: Returns the Card IDs this specific Beast instance can currently cast.
//           Uses SCR_BEAST_GET_DECK as the authoritative Card source.
//           An optional rarity filter may be supplied.
//
// ARGUMENTS: _stct_beast - Initialized Beast struct.
//            _str_rarity - Optional rarity ID: I, II, III, or IV.
// RETURNS: Array of unique eligible Card IDs.
//
//===============================================================================//

function scr_reward_get_beast_card_pool(_stct_beast,_str_rarity=undefined){

	#region VARIABLES

	var _arr_return = [];

	#endregion

	#region VALIDATION

	if (!is_struct(_stct_beast)){
		return _arr_return;
	}

	if (
		!variable_struct_exists(
			_stct_beast,
			"_str_beast_name"
		) ||
		!variable_struct_exists(
			_stct_beast,
			"_str_beast_color_type"
		)
	){
		return _arr_return;
	}

	var _str_beast_name =
		string_upper(
			string(
				_stct_beast
					._str_beast_name
			)
		);

	var _str_beast_type =
		string_upper(
			string(
				_stct_beast
					._str_beast_color_type
			)
		);

	var _str_rarity_filter =
		undefined;

	if (_str_rarity != undefined){

		_str_rarity_filter =
			string_upper(
				string(
					_str_rarity
				)
			);
	}

	#endregion

	#region GET DECK

	var _arr_deck =
		scr_beast_get_deck(
			_str_beast_name,
			_str_beast_type
		);

	if (!is_array(_arr_deck)){
		return _arr_return;
	}

	#endregion

	#region BUILD CARD POOL

	for (
		var _it_card = 0;
		_it_card < array_length(_arr_deck);
		_it_card++
	){

		var _stct_card =
			_arr_deck[
				_it_card
			];

		if (!is_struct(_stct_card)){
			continue;
		}

		if (
			!variable_struct_exists(
				_stct_card,
				"_str_card_name"
			)
		){
			continue;
		}

		if (_str_rarity_filter != undefined){

			if (
				!variable_struct_exists(
					_stct_card,
					"_str_card_rarity"
				)
			){
				continue;
			}

			if (
				string_upper(
					string(
						_stct_card
							._str_card_rarity
					)
				) !=
				_str_rarity_filter
			){
				continue;
			}
		}

		var _str_card_id =
			string_upper(
				string(
					_stct_card
						._str_card_name
				)
			);

		var _flag_duplicate =
			false;

		for (
			var _it_existing = 0;
			_it_existing < array_length(_arr_return);
			_it_existing++
		){

			if (
				_arr_return[
					_it_existing
				] ==
				_str_card_id
			){
				_flag_duplicate =
					true;

				break;
			}
		}

		if (_flag_duplicate){
			continue;
		}

		array_push(
			_arr_return,
			_str_card_id
		);
	}

	#endregion

	return _arr_return;
}
