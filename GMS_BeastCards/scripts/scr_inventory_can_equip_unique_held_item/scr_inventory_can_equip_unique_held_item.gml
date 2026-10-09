//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_CAN_EQUIP_UNIQUE_HELD_ITEM
// FUNCTION: Enforces active-Party uniqueness for Held Items.
//
//           _flag_unique_team = true blocks duplicate copies of the same Item ID.
//
//           _str_unique_team_group optionally creates a shared exclusivity group.
//           Only one Item from the same non-empty group may be equipped across the
//           active Party. Challenger's Bell and Hunter's Trophy both use:
//               "ELITE_ENCOUNTER"
//
//           The target Beast is excluded from the scan so replacing/swapping the
//           Item on that same Beast remains legal.
//
//           Legacy Bell/Trophy structs that predate _str_unique_team_group are
//           treated as members of ELITE_ENCOUNTER by Item ID.
//
// ARGUMENTS: _stct_item - Held Item being equipped.
//            _stct_target_unit - persistent Party Beast receiving the Item.
// RETURNS: True when legal; otherwise false.
//
//===============================================================================//
function scr_inventory_can_equip_unique_held_item(_stct_item,_stct_target_unit){

	#region VALIDATION

	if (!is_struct(_stct_item)){
		return false;
	}

	if (!is_struct(_stct_target_unit)){
		return false;
	}

	if (
		!variable_struct_exists(
			_stct_item,
			"_str_item_id"
		)
	){
		return false;
	}

	var _str_item_id =
		string_upper(
			string(
				_stct_item._str_item_id
			)
		);

	if (_str_item_id == ""){
		return false;
	}

	var _flag_unique_team =
		variable_struct_exists(
			_stct_item,
			"_flag_unique_team"
		) &&
		_stct_item._flag_unique_team;

	var _str_unique_team_group = "";

	if (
		variable_struct_exists(
			_stct_item,
			"_str_unique_team_group"
		)
	){
		_str_unique_team_group =
			string_upper(
				string(
					_stct_item
						._str_unique_team_group
				)
			);
	}

	// Backward compatibility for Item structs created before the group field existed.
	if (
		_str_item_id == "HELD_CHALLENGERS_BELL" ||
		_str_item_id == "HELD_HUNTERS_TROPHY"
	){
		_flag_unique_team = true;
		_str_unique_team_group = "ELITE_ENCOUNTER";
	}

	//================//
	//NOT RESTRICTED//
	//================//
	if (
		!_flag_unique_team &&
		_str_unique_team_group == ""
	){
		return true;
	}

	//================//
	//NO PARTY LIST//
	//================//
	if (
		!variable_global_exists(
			"list_player_party"
		) ||
		!ds_exists(
			global.list_player_party,
			ds_type_list
		)
	){
		return true;
	}

	#endregion

	#region CHECK PARTY

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

		//================//
		//SKIP TARGET//
		//================//
		if (_stct_party_beast == _stct_target_unit){
			continue;
		}

		if (
			variable_struct_exists(
				_stct_party_beast,
				"_uid_beast"
			) &&
			variable_struct_exists(
				_stct_target_unit,
				"_uid_beast"
			) &&
			_stct_party_beast._uid_beast ==
				_stct_target_unit._uid_beast
		){
			continue;
		}

		//================//
		//GET HELD ITEM//
		//================//
		if (
			!variable_struct_exists(
				_stct_party_beast,
				"_stct_beast_held_item"
			)
		){
			continue;
		}

		var _stct_party_item =
			_stct_party_beast
				._stct_beast_held_item;

		if (!is_struct(_stct_party_item)){
			continue;
		}

		if (
			!variable_struct_exists(
				_stct_party_item,
				"_str_item_id"
			)
		){
			continue;
		}

		var _str_party_item_id =
			string_upper(
				string(
					_stct_party_item
						._str_item_id
				)
			);

		//================//
		//SAME ITEM ID//
		//================//
		if (
			_flag_unique_team &&
			_str_party_item_id ==
				_str_item_id
		){
			return false;
		}

		//================//
		//PARTY ITEM GROUP//
		//================//
		var _str_party_unique_group = "";

		if (
			variable_struct_exists(
				_stct_party_item,
				"_str_unique_team_group"
			)
		){
			_str_party_unique_group =
				string_upper(
					string(
						_stct_party_item
							._str_unique_team_group
					)
				);
		}

		if (
			_str_party_item_id == "HELD_CHALLENGERS_BELL" ||
			_str_party_item_id == "HELD_HUNTERS_TROPHY"
		){
			_str_party_unique_group = "ELITE_ENCOUNTER";
		}

		//================//
		//SAME GROUP//
		//================//
		if (
			_str_unique_team_group != "" &&
			_str_party_unique_group ==
				_str_unique_team_group
		){
			return false;
		}
	}

	#endregion

	return true;
}