//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_REWARD_ROLL_PREMIUM_CARD
// FUNCTION: Awards one premium World Event Card from the global Card catalog.
//           Tier I is never requested and is never used as fallback.
//           Premium rarity weights: II 50%, III 30%, IV 20%.
//
// ARGUMENTS: _stct_world_event - Completed World Event struct.
// RETURNS: SCR_REWARD_AWARD_CARD result struct, or undefined on failure.
//
//===============================================================================//

function scr_world_event_reward_roll_premium_card(_stct_world_event){

	if (!is_struct(_stct_world_event)){
		return undefined;
	}

	var _stct_config =
		scr_world_event_reward_get_config(
			_stct_world_event._str_event_id
		);

	var _str_requested_rarity =
		scr_reward_roll_card_rarity(
			_stct_config._stct_card_rarity_weights
		);

	var _arr_fallback = [];

	switch (_str_requested_rarity){
		case "IV":
			_arr_fallback = ["IV","III","II"];
		break;

		case "III":
			_arr_fallback = ["III","II","IV"];
		break;

		case "II":
		default:
			_arr_fallback = ["II","III","IV"];
		break;
	}

	var _arr_pool = [];
	var _str_resolved_rarity = "";

	for (
		var _it_rarity = 0;
		_it_rarity < array_length(_arr_fallback);
		_it_rarity++
	){

		var _str_try_rarity =
			_arr_fallback[_it_rarity];

		_arr_pool =
			scr_reward_get_global_card_pool(
				_str_try_rarity
			);

		if (
			is_array(_arr_pool) &&
			array_length(_arr_pool) > 0
		){
			_str_resolved_rarity =
				_str_try_rarity;
			break;
		}
	}

	if (
		!is_array(_arr_pool) ||
		array_length(_arr_pool) <= 0
	){
		return undefined;
	}

	var _str_card_id =
		_arr_pool[
			irandom(
				array_length(_arr_pool) - 1
			)
		];

	var _stct_award =
		scr_reward_award_card(
			_str_card_id,
			"WORLD_EVENT",
			_stct_world_event._str_event_id
		);

	if (is_struct(_stct_award)){
		_stct_award._str_requested_rarity = _str_requested_rarity;
		_stct_award._str_resolved_rarity = _str_resolved_rarity;
	}

	return _stct_award;
}
