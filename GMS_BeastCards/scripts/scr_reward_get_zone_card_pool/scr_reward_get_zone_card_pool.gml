//===============================================================================//
//
// SCRIPT: SCR_REWARD_GET_ZONE_CARD_POOL
// FUNCTION: Returns valid Card IDs from a Zone reward definition.
//           Optionally filters the Zone Card pool by Card rarity.
//
// ARGUMENTS: _stct_zone_loot - Zone reward definition struct.
//            _str_rarity - Optional rarity ID: I, II, III, or IV.
// RETURNS: Array of valid Zone Card IDs.
//
//===============================================================================//

function scr_reward_get_zone_card_pool(
	_stct_zone_loot,
	_str_rarity=undefined
){

	#region VARIABLES

	var _arr_return = [];

	var _str_rarity_filter =
		undefined;

	#endregion

	#region VALIDATION

	if (!is_struct(_stct_zone_loot)){
		return _arr_return;
	}

	if (
		!variable_struct_exists(
			_stct_zone_loot,
			"_arr_card_pool"
		) ||
		!is_array(
			_stct_zone_loot._arr_card_pool
		)
	){
		return _arr_return;
	}

	if (_str_rarity != undefined){

		_str_rarity_filter =
			string_upper(
				string(
					_str_rarity
				)
			);
	}

	#endregion

	#region BUILD POOL

	for (
		var _it_card = 0;
		_it_card <
			array_length(
				_stct_zone_loot._arr_card_pool
			);
		_it_card++
	){

		var _str_card_id =
			string_upper(
				string(
					_stct_zone_loot
						._arr_card_pool[
							_it_card
						]
				)
			);

		var _stct_card =
			scr_card_get_info(
				_str_card_id
			);

		if (!is_struct(_stct_card)){
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
						_stct_card._str_card_rarity
					)
				) !=
				_str_rarity_filter
			){
				continue;
			}
		}

		array_push(
			_arr_return,
			_str_card_id
		);
	}

	#endregion

	return _arr_return;
}