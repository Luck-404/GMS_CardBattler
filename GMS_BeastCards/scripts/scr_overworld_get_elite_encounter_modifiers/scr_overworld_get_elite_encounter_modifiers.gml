//===============================================================================//
//
// SCRIPT: SCR_OVERWORLD_GET_ELITE_ENCOUNTER_MODIFIERS
// FUNCTION: Resolves the Party's current Elite-encounter Held Item modifiers.
//
//           Base Elite chance is 4% (1/25).
//           Multiple copies of the same Held Item ID do not stack.
//           Different Elite encounter modifiers do not stack with each other;
//           the strongest Elite chance bonus wins. Ties prefer higher Risk Tier.
//
//           Non-Elite ENCOUNTER Held Items are safely ignored after TRIGGER.
//
// ARGUMENTS: None.
// RETURNS: Struct containing base chance, winning bonus, final chance,
//          Risk Tier, and source Item metadata.
//
//===============================================================================//

function scr_overworld_get_elite_encounter_modifiers(){
	#region RESULT

	var _stct_result = {
		_val_base_elite_chance_percent : 4,
		_val_elite_chance_bonus : 0,
		_val_elite_chance_percent : 4,
		_val_elite_risk_tier : 0,
		_str_elite_source_item_id : "BASE",
		_str_elite_source_item_name : "BASE"
	};

	#endregion

	#region VALIDATE PARTY

	if (
		!variable_global_exists("list_player_party") ||
		!ds_exists(global.list_player_party,ds_type_list)
	){
		return _stct_result;
	}

	#endregion

	#region COLLECT MODIFIERS

	var _arr_processed_item_ids = [];

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

		if (!is_struct(_stct_party_beast)){
			continue;
		}

		if (
			!variable_struct_exists(
				_stct_party_beast,
				"_stct_beast_held_item"
			)
		){
			continue;
		}

		var _stct_item =
			_stct_party_beast
				._stct_beast_held_item;

		if (!is_struct(_stct_item)){
			continue;
		}

		if (
			!variable_struct_exists(
				_stct_item,
				"_str_item_trigger_type"
			) ||
			string_upper(
				string(
					_stct_item
						._str_item_trigger_type
				)
			) !=
			"ENCOUNTER"
		){
			continue;
		}

		if (
			!variable_struct_exists(
				_stct_item,
				"_scr_item"
			) ||
			_stct_item._scr_item ==
				undefined
		){
			continue;
		}

		var _str_item_id =
			string_upper(
				string(
					_stct_item._str_item_id
				)
			);

		var _flag_already_processed = false;

		for (
			var _it_processed = 0;
			_it_processed <
				array_length(
					_arr_processed_item_ids
				);
			_it_processed++
		){

			if (
				_arr_processed_item_ids[
					_it_processed
				] ==
				_str_item_id
			){
				_flag_already_processed = true;
				break;
			}
		}

		if (_flag_already_processed){
			continue;
		}

		array_push(
			_arr_processed_item_ids,
			_str_item_id
		);

		var _stct_modifier =
			_stct_item._scr_item(
				"TRIGGER",
				_stct_item,
				_stct_party_beast
			);

		if (!is_struct(_stct_modifier)){
			continue;
		}

		if (
			!variable_struct_exists(
				_stct_modifier,
				"_val_elite_chance_bonus"
			)
		){
			continue;
		}

		var _val_bonus =
			max(
				0,
				round(
					_stct_modifier
						._val_elite_chance_bonus
				)
			);

		var _val_risk_tier = 0;

		if (
			variable_struct_exists(
				_stct_modifier,
				"_val_elite_risk_tier"
			)
		){
			_val_risk_tier =
				max(
					0,
					round(
						_stct_modifier
							._val_elite_risk_tier
					)
				);
		}

		if (
			_val_bonus >
				_stct_result
					._val_elite_chance_bonus ||
			(
				_val_bonus ==
					_stct_result
						._val_elite_chance_bonus &&
				_val_risk_tier >
					_stct_result
						._val_elite_risk_tier
			)
		){

			_stct_result
				._val_elite_chance_bonus =
				_val_bonus;

			_stct_result
				._val_elite_risk_tier =
				_val_risk_tier;

			_stct_result
				._str_elite_source_item_id =
				_str_item_id;

			_stct_result
				._str_elite_source_item_name =
				string_upper(
					string(
						_stct_item
							._str_item_name
					)
				);
		}
	}

	#endregion

	#region FINALIZE

	_stct_result
		._val_elite_chance_percent =
		clamp(
			_stct_result
				._val_base_elite_chance_percent +
			_stct_result
				._val_elite_chance_bonus,
			0,
			100
		);

	#endregion

	return _stct_result;
}
