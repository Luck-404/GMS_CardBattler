//===============================================================================//
//
// SCRIPT: SCR_REWARD_AWARD_CARD
// FUNCTION: Validates and grants one Card reward, then returns normalized reward
//           metadata plus the Card struct required by the current GUI.
//
// ARGUMENTS: _str_card_id - Card ID.
//            _str_source - Reward source category.
//            _str_source_detail - Optional Beast/Zone source detail.
// RETURNS: Award result struct, or undefined when Card data is invalid.
//
//===============================================================================//

function scr_reward_award_card(
	_str_card_id,
	_str_source,
	_str_source_detail=""
){

	#region VALIDATION

	_str_card_id =
		string_upper(
			string(
				_str_card_id
			)
		);

	var _stct_card =
		scr_card_get_info(
			_str_card_id
		);

	if (!is_struct(_stct_card)){

		scr_debug_log(
			"REWARD",
			"CARD",
			undefined,
			"CARD REWARD FAILED" +
			" | CARD: " + _str_card_id +
			" | SOURCE: " + string_upper(_str_source) +
			" | REASON: INVALID CARD DATA",
			"WARNING",
			"SCR_REWARD_AWARD_CARD"
		);

		return undefined;
	}

	#endregion

	#region AWARD

	scr_deck_add_card(
		_stct_card
	);

	#endregion

	#region RESULT

	var _str_rarity = "";

	if (
		variable_struct_exists(
			_stct_card,
			"_str_card_rarity"
		)
	){

		_str_rarity =
			string_upper(
				string(
					_stct_card._str_card_rarity
				)
			);
	}

	var _stct_entry = {
		_str_reward_type : "CARD",
		_str_reward_subtype : "CARD",
		_str_reward_id : _str_card_id,
		_str_display_name : _stct_card._str_card_name,
		_ct_amount : 1,
		_str_rarity : _str_rarity,
		_str_source : string_upper(_str_source),
		_str_source_detail : string_upper(string(_str_source_detail)),
		_spr_reward : _stct_card._spr_card
	};

	return {
		_stct_entry : _stct_entry,
		_stct_card : _stct_card
	};

	#endregion
}
