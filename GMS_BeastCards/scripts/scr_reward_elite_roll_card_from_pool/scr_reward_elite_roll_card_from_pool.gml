//===============================================================================//
//
// SCRIPT: SCR_REWARD_ELITE_ROLL_CARD_FROM_POOL
// FUNCTION: Rolls one Card ID from a supplied valid Card-ID pool using the normal
//           battle-reward Card rarity distribution and downward rarity fallback.
//
//           Optional exclusions are honored when alternatives exist. Callers may
//           retry without exclusions when duplicate Card rewards are preferable
//           to failing a guaranteed Elite reward slot.
//
// ARGUMENTS: _arr_card_ids - Candidate Card IDs.
//            _arr_exclude - Optional Card IDs to exclude.
//            _stct_rarity_weights - Optional rarity weights; defaults to normal.
// RETURNS: Struct containing selected ID plus requested/resolved rarity.
//          Undefined when no valid candidate resolves.
//
//===============================================================================//

function scr_reward_elite_roll_card_from_pool(_arr_card_ids,_arr_exclude=[],_stct_rarity_weights=undefined){
	#region VALIDATION

	if (
		!is_array(_arr_card_ids) ||
		array_length(_arr_card_ids) <= 0
	){
		return undefined;
	}

	if (!is_array(_arr_exclude)){
		_arr_exclude = [];
	}

	if (!is_struct(_stct_rarity_weights)){
		_stct_rarity_weights =
			scr_reward_get_card_rarity_weights();
	}

	#endregion

	#region RARITY ROLL

	var _str_requested_rarity =
		scr_reward_roll_card_rarity(
			_stct_rarity_weights
		);

	var _arr_rarity_fallback =
		scr_reward_get_card_rarity_fallback(
			_str_requested_rarity
		);

	#endregion

	#region RESOLVE

	for (
		var _it_rarity = 0;
		_it_rarity <
			array_length(
				_arr_rarity_fallback
			);
		_it_rarity++
	){

		var _str_try_rarity =
			_arr_rarity_fallback[
				_it_rarity
			];

		var _arr_candidates = [];

		for (
			var _it_card = 0;
			_it_card <
				array_length(
					_arr_card_ids
				);
			_it_card++
		){

			var _str_card_id =
				string_upper(
					string(
						_arr_card_ids[
							_it_card
						]
					)
				);

			if (_str_card_id == ""){
				continue;
			}

			var _flag_excluded = false;

			for (
				var _it_exclude = 0;
				_it_exclude <
					array_length(
						_arr_exclude
					);
				_it_exclude++
			){

				if (
					string_upper(
						string(
							_arr_exclude[
								_it_exclude
							]
						)
					) ==
					_str_card_id
				){
					_flag_excluded = true;
					break;
				}
			}

			if (_flag_excluded){
				continue;
			}

			var _stct_card =
				scr_card_get_info(
					_str_card_id
				);

			if (!is_struct(_stct_card)){
				continue;
			}

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
				_str_try_rarity
			){
				continue;
			}

			array_push(
				_arr_candidates,
				_str_card_id
			);
		}

		if (array_length(_arr_candidates) <= 0){
			continue;
		}

		return {
			_str_card_id :
				_arr_candidates[
					irandom(
						array_length(
							_arr_candidates
						) -
						1
					)
				],

			_str_requested_rarity :
				_str_requested_rarity,

			_str_resolved_rarity :
				_str_try_rarity
		};
	}

	#endregion

	return undefined;
}
