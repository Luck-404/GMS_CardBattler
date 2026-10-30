//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_ELITE_SIGHTING_RESET_UNIT
// FUNCTION: Restores one persistent Elite Sighting roster member to the exact
//           pre-battle baseline stored when the event was generated.
//
//           The Tier 2 Elite is then rebuilt with the same modifier and Risk Tier.
//           This prevents retry attempts from retaining Vengeful/Martyr or other
//           battle-only permanent stat mutations from a lost attempt.
//
// RETURNS: True when the persistent unit was reset successfully.
//
//===============================================================================//

function scr_world_event_elite_sighting_reset_unit(_stct_unit,_uid_elite_beast){

	if (
		!is_struct(_stct_unit) ||
		!variable_struct_exists(
			_stct_unit,
			"_stct_elite_sighting_base_stats"
		) ||
		!is_struct(
			_stct_unit._stct_elite_sighting_base_stats
		)
	){
		return false;
	}

	var _stct_base =
		_stct_unit
			._stct_elite_sighting_base_stats;

	var _flag_target_elite =
		_stct_unit._uid_beast ==
			_uid_elite_beast;

	var _str_elite_modifier = "";
	var _val_elite_risk_tier = 0;

	if (_flag_target_elite){

		if (
			variable_struct_exists(
				_stct_unit,
				"_str_elite_modifier"
			)
		){
			_str_elite_modifier =
				string_upper(
					string(
						_stct_unit._str_elite_modifier
					)
				);
		}

		if (
			variable_struct_exists(
				_stct_unit,
				"_val_elite_risk_tier"
			)
		){
			_val_elite_risk_tier =
				max(
					2,
					round(
						_stct_unit
							._val_elite_risk_tier
					)
				);
		}
	}

	_stct_unit._val_beast_hp_stat =
		_stct_base._val_beast_hp_stat;

	_stct_unit._val_beast_con_stat =
		_stct_base._val_beast_con_stat;

	_stct_unit._val_beast_ppow_stat =
		_stct_base._val_beast_ppow_stat;

	_stct_unit._val_beast_mpow_stat =
		_stct_base._val_beast_mpow_stat;

	_stct_unit._val_beast_pdef_stat =
		_stct_base._val_beast_pdef_stat;

	_stct_unit._val_beast_mdef_stat =
		_stct_base._val_beast_mdef_stat;

	_stct_unit._val_beast_speed_stat =
		_stct_base._val_beast_speed_stat;

	_stct_unit._val_beast_crit_stat =
		_stct_base._val_beast_crit_stat;

	_stct_unit._val_beast_hp_max =
		_stct_base._val_beast_hp_max;

	_stct_unit._val_beast_hp_cur =
		_stct_base._val_beast_hp_max;

	if (!_flag_target_elite){

		_stct_unit._flag_elite = false;
		_stct_unit._str_elite_modifier = "";
		_stct_unit._val_elite_risk_tier = 0;
		_stct_unit._flag_elite_stats_applied = false;
		_stct_unit._str_elite_modifier_stats_applied = "";
		_stct_unit._arr_elite_card_ids = [];
		_stct_unit._str_elite_primary_card_id = "";
		_stct_unit._str_elite_monarch_card_id = "";

		return true;
	}

	_stct_unit._flag_elite = true;
	_stct_unit._str_elite_modifier =
		_str_elite_modifier;
	_stct_unit._val_elite_risk_tier =
		_val_elite_risk_tier;

	_stct_unit._flag_elite_stats_applied = false;
	_stct_unit._str_elite_modifier_stats_applied = "";

	_stct_unit._arr_elite_vengeful_counted_death_uids = [];
	_stct_unit._arr_elite_vengeful_starting_ally_uids = [];
	_stct_unit._stct_elite_vengeful_stat_basis = undefined;
	_stct_unit._uid_elite_soulbound_protected = undefined;
	_stct_unit._flag_elite_soulbound_assignment_initialized = false;

	return scr_battle_elite_apply(
		_stct_unit,
		_str_elite_modifier
	);
}
