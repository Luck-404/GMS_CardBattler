//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_REWARD_RESOLVE
// FUNCTION: Resolves the dedicated premium reward package for one completed
//           World Event without modifying normal battle rewards.
//
//           GUARANTEED:
//           - 750-1500 Gold.
//           - Event EXP to each living Party Beast at 3x ordinary-equivalent
//             completion EXP; ELITE_SIGHTING uses 4x.
//           - 1 premium Card, rarity II/III/IV at 50/30/20.
//           - 1 premium Item from the World Event premium Item roll.
//
// ARGUMENTS: _stct_world_event - Active World Event being completed.
// RETURNS: Premium reward result struct. Repeated calls return the stored result.
//
//===============================================================================//

function scr_world_event_reward_resolve(_stct_world_event){

	if (!is_struct(_stct_world_event)){
		return undefined;
	}

	if (!is_struct(_stct_world_event._stct_payload)){
		_stct_world_event._stct_payload = {};
	}

	var _stct_payload =
		_stct_world_event._stct_payload;

	if (
		_stct_world_event._flag_reward_claimed &&
		variable_struct_exists(
			_stct_payload,
			"_stct_premium_reward_result"
		) &&
		is_struct(
			_stct_payload._stct_premium_reward_result
		)
	){
		return _stct_payload._stct_premium_reward_result;
	}

	var _stct_config =
		scr_world_event_reward_get_config(
			_stct_world_event._str_event_id
		);

	var _arr_rewards = [];

	//================//
	//GOLD//
	//================//
	var _ct_gold =
		irandom_range(
			min(_stct_config._val_gold_min,_stct_config._val_gold_max),
			max(_stct_config._val_gold_min,_stct_config._val_gold_max)
		);

	global.val_player_gold +=
		_ct_gold;

	array_push(
		_arr_rewards,
		{
			_str_reward_type : "GOLD",
			_str_reward_subtype : "GOLD",
			_str_reward_id : "GOLD",
			_str_display_name : "GOLD",
			_ct_amount : _ct_gold,
			_str_rarity : "",
			_str_source : "WORLD_EVENT",
			_str_source_detail : _stct_world_event._str_event_id,
			_spr_reward : undefined
		}
	);

	scr_world_event_reward_notify(
		"GOLD",
		undefined,
		_ct_gold
	);

	//================//
	//REFERENCE LEVEL//
	//================//
	var _val_reference_level = 1;

	if (
		_stct_world_event._str_event_id == "MIGRATION" &&
		variable_struct_exists(
			_stct_payload,
			"_stct_migration_scaling"
		) &&
		is_struct(
			_stct_payload._stct_migration_scaling
		) &&
		variable_struct_exists(
			_stct_payload._stct_migration_scaling,
			"_val_enemy_level_target"
		)
	){
		_val_reference_level =
			max(
				1,
				_stct_payload
					._stct_migration_scaling
					._val_enemy_level_target
			);
	}
	else if (
		_stct_world_event._str_event_id == "ELITE_SIGHTING" &&
		variable_struct_exists(
			_stct_payload,
			"_stct_elite_sighting_scaling"
		) &&
		is_struct(
			_stct_payload._stct_elite_sighting_scaling
		) &&
		variable_struct_exists(
			_stct_payload._stct_elite_sighting_scaling,
			"_val_enemy_level_target"
		)
	){
		_val_reference_level =
			max(
				1,
				_stct_payload
					._stct_elite_sighting_scaling
					._val_enemy_level_target
			);
	}
	else if (
		variable_global_exists("list_player_party") &&
		ds_exists(global.list_player_party,ds_type_list) &&
		ds_list_size(global.list_player_party) > 0
	){

		var _val_level_total = 0;
		var _ct_level_beasts = 0;

		for (
			var _it_level = 0;
			_it_level < ds_list_size(global.list_player_party);
			_it_level++
		){

			var _stct_level_beast =
				ds_list_find_value(
					global.list_player_party,
					_it_level
				);

			if (!is_struct(_stct_level_beast)){
				continue;
			}

			_val_level_total +=
				max(1,_stct_level_beast._val_beast_level);

			_ct_level_beasts++;
		}

		if (_ct_level_beasts > 0){
			_val_reference_level =
				_val_level_total /
				_ct_level_beasts;
		}
	}

	//================//
	//EXP//
	//================//
	var _stct_battle_reward_config =
		scr_reward_get_battle_roll_config();

	var _ct_exp_level_band =
		floor(
			(
				max(1,floor(_val_reference_level)) - 1
			) /
			5
		);

	var _ct_exp_ordinary_equivalent =
		_stct_battle_reward_config._ct_exp_base +
		(
			_ct_exp_level_band *
			_stct_battle_reward_config._ct_exp_per_level_band
		);

	var _ct_exp_each =
		max(
			1,
			floor(
				_ct_exp_ordinary_equivalent *
				_stct_config._val_exp_multiplier
			)
		);

	var _ct_exp_recipients = 0;

	if (
		variable_global_exists("list_player_party") &&
		ds_exists(global.list_player_party,ds_type_list)
	){

		for (
			var _it_party = 0;
			_it_party < ds_list_size(global.list_player_party);
			_it_party++
		){

			var _stct_party_beast =
				ds_list_find_value(
					global.list_player_party,
					_it_party
				);

			if (
				!is_struct(_stct_party_beast) ||
				_stct_party_beast._val_beast_hp_cur <= 0
			){
				continue;
			}

			scr_beast_add_exp(
				_stct_party_beast,
				_ct_exp_each
			);

			_ct_exp_recipients++;
		}
	}

	array_push(
		_arr_rewards,
		{
			_str_reward_type : "EXP",
			_str_reward_subtype : "EXP",
			_str_reward_id : "EXP",
			_str_display_name : "EXP",
			_ct_amount : _ct_exp_each,
			_ct_recipients : _ct_exp_recipients,
			_str_rarity : "",
			_str_source : "WORLD_EVENT",
			_str_source_detail : _stct_world_event._str_event_id,
			_spr_reward : undefined
		}
	);

	//================//
	//PREMIUM CARD//
	//================//
	var _stct_card_award =
		scr_world_event_reward_roll_premium_card(
			_stct_world_event
		);

	if (is_struct(_stct_card_award)){
		array_push(
			_arr_rewards,
			_stct_card_award._stct_entry
		);

		scr_world_event_reward_notify(
			"CARD",
			_stct_card_award._stct_entry._str_reward_id,
			max(1,_stct_card_award._stct_entry._ct_amount)
		);
	}

	//================//
	//PREMIUM ITEM//
	//================//
	var _stct_item_award =
		scr_world_event_reward_roll_premium_item(
			_stct_world_event
		);

	if (is_struct(_stct_item_award)){
		array_push(
			_arr_rewards,
			_stct_item_award._stct_entry
		);

		scr_world_event_reward_notify(
			"ITEM",
			_stct_item_award._stct_entry._str_reward_id,
			max(1,_stct_item_award._stct_entry._ct_amount)
		);
	}

	var _stct_result = {
		_flag_success : true,
		_str_event_id : _stct_world_event._str_event_id,
		_ct_gold : _ct_gold,
		_ct_exp_each : _ct_exp_each,
		_ct_exp_recipients : _ct_exp_recipients,
		_val_exp_multiplier : _stct_config._val_exp_multiplier,
		_arr_rewards : _arr_rewards,
		_stct_card_award : _stct_card_award,
		_stct_item_award : _stct_item_award
	};

	_stct_payload._arr_premium_rewards =
		_arr_rewards;

	_stct_payload._stct_premium_reward_result =
		_stct_result;

	_stct_payload._flag_premium_reward_resolved =
		true;

	_stct_world_event._flag_reward_claimed =
		true;

	scr_debug_log(
		"WORLD_EVENT",
		"REWARD",
		scr_world_event_get_controller(),
		"PREMIUM WORLD EVENT REWARD RESOLVED" +
		" | EVENT: " +
		_stct_world_event._str_event_id +
		" | GOLD: " +
		string(_ct_gold) +
		" | EXP EACH: " +
		string(_ct_exp_each) +
		" | EXP RECIPIENTS: " +
		string(_ct_exp_recipients) +
		" | CARD: " +
		(
			is_struct(_stct_card_award)
			? _stct_card_award._stct_entry._str_reward_id
			: "NONE"
		) +
		" | ITEM: " +
		(
			is_struct(_stct_item_award)
			? _stct_item_award._stct_entry._str_reward_id
			: "NONE"
		),
		"INFO",
		"SCR_WORLD_EVENT_REWARD_RESOLVE"
	);

	return _stct_result;
}
