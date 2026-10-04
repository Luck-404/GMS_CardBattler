//===============================================================================//
//
// SCRIPT: SCR_REWARD_AWARD_INVENTORY_ITEM
// FUNCTION: Validates and grants one Inventory Item reward, then returns both
//           normalized reward metadata and the Item struct needed by the current
//           Phase 3 compatibility GUI.
//
// ARGUMENTS: _str_item_id - Inventory Item ID.
//            _str_source - Reward source category.
//            _str_source_detail - Optional Beast/Zone source detail.
// RETURNS: Award result struct, or undefined when the Item is invalid.
//
//===============================================================================//

function scr_reward_award_inventory_item(
	_str_item_id,
	_str_source,
	_str_source_detail=""
){

	#region VALIDATION

	_str_item_id =
		string_upper(
			string(
				_str_item_id
			)
		);

	var _stct_item =
		scr_inventory_get_item_info(
			_str_item_id
		);

	if (!is_struct(_stct_item)){

		scr_debug_log(
			"REWARD",
			"ITEM",
			undefined,
			"ITEM REWARD FAILED" +
			" | ITEM: " + _str_item_id +
			" | SOURCE: " + string_upper(_str_source) +
			" | REASON: INVALID ITEM DATA",
			"WARNING",
			"SCR_REWARD_AWARD_INVENTORY_ITEM"
		);

		return undefined;
	}

	#endregion

	#region AWARD

	scr_inventory_add_item(
		_str_item_id,
		1
	);

	#endregion

	#region RESULT

	var _stct_entry = {
		_str_reward_type : "ITEM",
		_str_reward_subtype : _stct_item._str_item_type,
		_str_reward_id : _str_item_id,
		_str_display_name : _stct_item._str_item_name,
		_ct_amount : 1,
		_str_rarity : "",
		_str_source : string_upper(_str_source),
		_str_source_detail : string_upper(string(_str_source_detail)),
		_spr_reward : _stct_item._spr_item
	};

	return {
		_stct_entry : _stct_entry,
		_stct_item : _stct_item
	};

	#endregion
}