//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_CAN_EQUIP_UNIQUE_HELD_ITEM
// FUNCTION: Enforces the universal one-per-team rule for Unique Held Items.
//
//           Every Item struct contains:
//               _flag_unique_team
//
//           When false, the item is unrestricted.
//           When true, no OTHER Beast in the active player Party may already
//           have the same Held Item ID equipped.
//
//           The target Beast is deliberately excluded from the duplicate scan,
//           allowing a Unique item to replace the same Unique item on that same
//           Beast without falsely detecting itself.
//
//           This helper performs validation only. It does not remove inventory,
//           unequip items, equip items, or display feedback.
//
// ARGUMENTS: _stct_item - Held Item being equipped.
//            _stct_target_unit - Persistent Party Beast receiving the item.
// RETURNS: True when the equip is legal; false when the one-per-team rule would
//          be violated.
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

	//================//
	//NOT UNIQUE//
	//================//
	if (
		!variable_struct_exists(
			_stct_item,
			"_flag_unique_team"
		) ||
		!_stct_item._flag_unique_team
	){
		return true;
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

		//================//
		//DUPLICATE//
		//================//
		if (
			string_upper(
				string(
					_stct_party_item
						._str_item_id
				)
			) ==
			_str_item_id
		){
			return false;
		}
	}

	#endregion

	return true;
}
