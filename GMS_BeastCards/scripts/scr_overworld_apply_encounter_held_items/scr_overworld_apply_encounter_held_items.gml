//===============================================================================//
//
// SCRIPT: SCR_OVERWORLD_APPLY_ENCOUNTER_HELD_ITEMS
// FUNCTION: Applies Party Held Item encounter modifiers to a valid encounter pool.
//
//           The supplied pool remains the authoritative list of species allowed
//           to appear in the current area. Encounter Held Items may only add
//           additional weighted copies of species already inside that pool.
//
//           Duplicate copies are intentional. SCR_BEAST_GET_RANDOM applies each
//           pool entry's normal species rarity weight, so an additional copy
//           increases that species' total encounter weight without replacing its
//           existing rarity.
//
//           Multiple copies of the same Held Item ID do not stack.
//
// ARGUMENTS: _arr_encounter_pool - Valid local Beast encounter pool.
//
// RETURNS: A new weighted encounter pool.
//
//===============================================================================//

function scr_overworld_apply_encounter_held_items(_arr_encounter_pool){

	#region VALIDATION

	if (!is_array(_arr_encounter_pool)){
		return [];
	}

	var _ct_base_pool =
		array_length(
			_arr_encounter_pool
		);

	if (_ct_base_pool <= 0){
		return [];
	}

	#endregion

	#region COPY BASE POOL

	var _arr_weighted_pool = [];

	for (
		var _it_base = 0;
		_it_base < _ct_base_pool;
		_it_base++
	){

		var _str_beast_id =
			string_upper(
				string(
					_arr_encounter_pool[
						_it_base
					]
				)
			);

		array_push(
			_arr_weighted_pool,
			_str_beast_id
		);
	}

	#endregion

	#region VALIDATE PARTY

	if (
		!variable_global_exists(
			"list_player_party"
		) ||
		!ds_exists(
			global.list_player_party,
			ds_type_list
		)
	){
		return _arr_weighted_pool;
	}

	#endregion

	#region COLLECT ENCOUNTER MODIFIERS

	var _arr_modifiers = [];
	var _arr_processed_item_ids = [];

	for (
		var _it_party = 0;
		_it_party <
			ds_list_size(
				global.list_player_party
			);
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

		//=======================//
		//PREVENT SAME-ID STACKING//
		//=======================//
		var _flag_already_processed =
			false;

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

				_flag_already_processed =
					true;

				break;
			}
		}

		if (_flag_already_processed){
			continue;
		}

		//================//
		//TRIGGER ITEM//
		//================//
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
				"_str_encounter_color"
			) ||
			!variable_struct_exists(
				_stct_modifier,
				"_ct_extra_pool_entries"
			)
		){
			continue;
		}

		var _str_encounter_color =
			string_upper(
				string(
					_stct_modifier
						._str_encounter_color
				)
			);

		var _ct_extra_pool_entries =
			max(
				0,
				round(
					_stct_modifier
						._ct_extra_pool_entries
				)
			);

		if (
			_str_encounter_color == "" ||
			_ct_extra_pool_entries <= 0
		){
			continue;
		}

		array_push(
			_arr_modifiers,
			{
				_str_item_id :
					_str_item_id,

				_str_item_name :
					string_upper(
						string(
							_stct_item
								._str_item_name
						)
					),

				_str_encounter_color :
					_str_encounter_color,

				_ct_extra_pool_entries :
					_ct_extra_pool_entries
			}
		);

		array_push(
			_arr_processed_item_ids,
			_str_item_id
		);
	}

	#endregion

	#region APPLY MODIFIERS

	var _ct_modifiers =
		array_length(
			_arr_modifiers
		);

	if (_ct_modifiers <= 0){
		return _arr_weighted_pool;
	}

	for (
		var _it_modifier = 0;
		_it_modifier <
			_ct_modifiers;
		_it_modifier++
	){

		var _stct_modifier =
			_arr_modifiers[
				_it_modifier
			];

		var _ct_matching_entries =
			0;

		for (
			var _it_beast = 0;
			_it_beast <
				_ct_base_pool;
			_it_beast++
		){

			var _str_beast_id =
				string_upper(
					string(
						_arr_encounter_pool[
							_it_beast
						]
					)
				);

			var _stct_beast_info =
				scr_beast_get_info(
					_str_beast_id
				);

			if (!is_struct(_stct_beast_info)){
				continue;
			}

			if (
				!variable_struct_exists(
					_stct_beast_info,
					"_arr_beast_colors"
				) ||
				!is_array(
					_stct_beast_info
						._arr_beast_colors
				)
			){
				continue;
			}

			var _flag_color_match =
				false;

			for (
				var _it_color = 0;
				_it_color <
					array_length(
						_stct_beast_info
							._arr_beast_colors
					);
				_it_color++
			){

				var _var_color =
					_stct_beast_info
						._arr_beast_colors[
							_it_color
						];

				if (_var_color == undefined){
					continue;
				}

				if (
					string_upper(
						string(
							_var_color
						)
					) ==
					_stct_modifier
						._str_encounter_color
				){

					_flag_color_match =
						true;

					break;
				}
			}

			if (!_flag_color_match){
				continue;
			}

			_ct_matching_entries++;

			repeat (
				_stct_modifier
					._ct_extra_pool_entries
			){

				array_push(
					_arr_weighted_pool,
					_str_beast_id
				);
			}
		}

		//================//
		//DEBUG MODIFIER//
		//================//
		scr_debug_log(
			"OVERWORLD",
			"ENCOUNTER",
			undefined,
			"ENCOUNTER HELD ITEM APPLIED" +
			" | ITEM: " +
			_stct_modifier._str_item_name +
			" | COLOR: " +
			_stct_modifier._str_encounter_color +
			" | MATCHING POOL ENTRIES: " +
			string(
				_ct_matching_entries
			) +
			" | EXTRA COPIES PER MATCH: " +
			string(
				_stct_modifier
					._ct_extra_pool_entries
			),
			"INFO",
			"SCR_OVERWORLD_APPLY_ENCOUNTER_HELD_ITEMS"
		);
	}

	#endregion

	#region DEBUG RESULT

	scr_debug_log(
		"OVERWORLD",
		"ENCOUNTER",
		undefined,
		"ENCOUNTER POOL WEIGHTING COMPLETE" +
		" | BASE POOL SIZE: " +
		string(
			_ct_base_pool
		) +
		" | WEIGHTED POOL SIZE: " +
		string(
			array_length(
				_arr_weighted_pool
			)
		),
		"INFO",
		"SCR_OVERWORLD_APPLY_ENCOUNTER_HELD_ITEMS"
	);

	#endregion

	return _arr_weighted_pool;
}