//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_REWARD_GET_CONFIG
// FUNCTION: Returns the dedicated premium World Event completion-reward config.
//           This does not alter ordinary battle reward weights.
//
//===============================================================================//

function scr_world_event_reward_get_config(_str_event_id=""){

	_str_event_id =
		string_upper(
			string(
				_str_event_id
			)
		);

	var _val_exp_multiplier = 3;

	if (_str_event_id == "ELITE_SIGHTING"){
		_val_exp_multiplier = 4;
	}

	return {
		_val_gold_min : 750,
		_val_gold_max : 1500,
		_val_exp_multiplier : _val_exp_multiplier,

		_stct_card_rarity_weights : {
			_val_rarity_I : 0,
			_val_rarity_II : 50,
			_val_rarity_III : 30,
			_val_rarity_IV : 20
		},

		_stct_held_tier_weights : {
			_val_tier_II : 50,
			_val_tier_III : 30,
			_val_tier_IV : 20
		},

		_stct_prism_tier_weights : {
			_val_tier_II : 50,
			_val_tier_III : 30,
			_val_tier_IV : 20
		},

		_stct_item_category_weights : {
			_val_held : 50,
			_val_prism : 30,
			_val_egg : 20
		}
	};
}
