//===============================================================================//
//
// FUNCTION: SCR_BATTLE_ELITE_CHEAT_SET_RISK_TIER
// FUNCTION: Rebuilds one living ENEMY Elite at Risk Tier 0, 1, or 2 while retaining
//           its current Elite modifier and exact special Elite/Monarch Card IDs.
//
//           Uses the same reversible pre-Elite snapshot as modifier Cheats.
//           Current HP percentage is preserved by the normal modifier rebuild.
//
// RETURNS: True on success.
//===============================================================================//
function scr_battle_elite_cheat_set_risk_tier(_ref_beast,_val_risk_tier){
	#region VALIDATION

	if (
		!instance_exists(
			_ref_beast
		) ||
		_ref_beast.object_index !=
			obj_battle_beast ||
		_ref_beast._str_team !=
			"ENEMY" ||
		_ref_beast._str_list !=
			"ALIVE" ||
		_ref_beast._val_cur_hp <= 0 ||
		!is_struct(
			_ref_beast._ref_unit
		)
	){
		return false;
	}

	var _stct_unit =
		_ref_beast._ref_unit;

	if (
		!variable_struct_exists(
			_stct_unit,
			"_flag_elite"
		) ||
		!_stct_unit._flag_elite
	){
		return false;
	}

	var _str_modifier =
		string_upper(
			string(
				_stct_unit
					._str_elite_modifier
			)
		);

	if (
		scr_battle_elite_get_info(
			_str_modifier
		) == undefined
	){
		return false;
	}

	_val_risk_tier =
		clamp(
			round(
				_val_risk_tier
			),
			0,
			2
		);

	var _val_old_risk_tier = 0;

	if (
		variable_struct_exists(
			_stct_unit,
			"_val_elite_risk_tier"
		)
	){
		_val_old_risk_tier =
			max(
				0,
				round(
					_stct_unit
						._val_elite_risk_tier
				)
			);
	}

	if (_val_old_risk_tier == _val_risk_tier){
		_ref_beast._val_elite_risk_tier =
			_val_risk_tier;

		return true;
	}

	#endregion

	#region PRESERVE SPECIAL CARD IDS

	var _arr_saved_elite_card_ids = [];

	if (
		variable_struct_exists(
			_stct_unit,
			"_arr_elite_card_ids"
		) &&
		is_array(
			_stct_unit
				._arr_elite_card_ids
		)
	){
		for (
			var _it_card = 0;
			_it_card <
				array_length(
					_stct_unit
						._arr_elite_card_ids
				);
			_it_card++
		){
			array_push(
				_arr_saved_elite_card_ids,
				_stct_unit
					._arr_elite_card_ids[
						_it_card
					]
			);
		}
	}

	var _str_saved_primary_card_id = "";
	var _str_saved_monarch_card_id = "";

	if (
		variable_struct_exists(
			_stct_unit,
			"_str_elite_primary_card_id"
		)
	){
		_str_saved_primary_card_id =
			string(
				_stct_unit
					._str_elite_primary_card_id
			);
	}

	if (
		variable_struct_exists(
			_stct_unit,
			"_str_elite_monarch_card_id"
		)
	){
		_str_saved_monarch_card_id =
			string(
				_stct_unit
					._str_elite_monarch_card_id
			);
	}

	#endregion

	#region REBUILD

	_stct_unit._val_elite_risk_tier =
		_val_risk_tier;

	if (
		!scr_battle_elite_cheat_set_modifier(
			_ref_beast,
			_str_modifier
		)
	){
		_stct_unit._val_elite_risk_tier =
			_val_old_risk_tier;

		return false;
	}

	// Restore exact special-Card metadata cleared by the baseline rebuild.
	_stct_unit._arr_elite_card_ids =
		_arr_saved_elite_card_ids;

	_stct_unit._str_elite_primary_card_id =
		_str_saved_primary_card_id;

	_stct_unit._str_elite_monarch_card_id =
		_str_saved_monarch_card_id;

	_stct_unit._val_elite_risk_tier =
		_val_risk_tier;

	_ref_beast._val_elite_risk_tier =
		_val_risk_tier;

	#endregion

	scr_debug_log(
		"BATTLE",
		"ELITE",
		_ref_beast,
		"CHEAT ELITE RISK TIER SET" +
		" | MODIFIER: " +
		_str_modifier +
		" | OLD TIER: " +
		string(_val_old_risk_tier) +
		" | NEW TIER: " +
		string(_val_risk_tier) +
		" | HP: " +
		string(
			_ref_beast._val_cur_hp
		) +
		"/" +
		string(
			_ref_beast._val_max_hp
		),
		"CHEAT",
		"SCR_BATTLE_ELITE_CHEAT_SET_RISK_TIER"
	);

	return true;
}


//===============================================================================//
//
// FUNCTION: SCR_BATTLE_ELITE_CHEAT_DEMOTE
// FUNCTION: Removes Elite state and restores the pre-Elite baseline.
// RETURNS: True when an Elite enemy is successfully demoted.
//===============================================================================//
function scr_battle_elite_cheat_demote(_ref_beast){
	if (
		!instance_exists(
			_ref_beast
		) ||
		_ref_beast.object_index !=
			obj_battle_beast ||
		_ref_beast._str_team !=
			"ENEMY" ||
		!is_struct(
			_ref_beast._ref_unit
		) ||
		!variable_struct_exists(
			_ref_beast._ref_unit,
			"_flag_elite"
		) ||
		!_ref_beast
			._ref_unit
			._flag_elite
	){
		return false;
	}

	var _str_old_modifier =
		"";

	if (
		variable_struct_exists(
			_ref_beast._ref_unit,
			"_str_elite_modifier"
		)
	){
		_str_old_modifier =
			string_upper(
				string(
					_ref_beast
						._ref_unit
						._str_elite_modifier
				)
			);
	}

	if (
		!scr_battle_elite_cheat_restore_base(
			_ref_beast
		)
	){
		return false;
	}

	_ref_beast
		._ref_unit
		._val_elite_risk_tier =
		0;

	_ref_beast._val_elite_risk_tier =
		0;

	scr_debug_log(
		"BATTLE",
		"ELITE",
		_ref_beast,
		"CHEAT ELITE DEMOTED" +
		" | OLD MODIFIER: " +
		_str_old_modifier +
		" | HP: " +
		string(
			_ref_beast._val_cur_hp
		) +
		"/" +
		string(
			_ref_beast._val_max_hp
		),
		"CHEAT",
		"SCR_BATTLE_ELITE_CHEAT_DEMOTE"
	);

	return true;
}