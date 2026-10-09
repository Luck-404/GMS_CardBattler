//===============================================================================//
//
// SCRIPT RESOURCE: SCR_BATTLE_ELITE_CHEAT_MODIFIER
//
// FUNCTIONS:
//   scr_battle_elite_get_cheat_modifiers
//   scr_battle_elite_cheat_restore_base
//   scr_battle_elite_cheat_set_modifier
//   scr_battle_elite_cheat_set_risk_tier
//   scr_battle_elite_cheat_demote
//
// PURPOSE:
//   Safe battle-Cheat mutation of ENEMY Elite state.
//
//   This is the authoritative foundation used by the Cheats pane:
//   - promote a normal enemy to one selected Elite modifier;
//   - change an existing Elite to another modifier;
//   - demote an Elite back to its pre-Elite baseline.
//
//   REFORGED is deliberately omitted because its gameplay mechanic is deferred.
//
// IMPORTANT:
//   Card synchronization for SCHOLARLY / MONARCH / normal Elite-pool Cards is
//   handled by the next Cheats-pane integration chunk.
//
//===============================================================================//

//===============================================================================//
//
// FUNCTION: SCR_BATTLE_ELITE_GET_CHEAT_MODIFIERS
// RETURNS: All selectable, implemented Elite modifiers.
//===============================================================================//
function scr_battle_elite_get_cheat_modifiers(){
	return [
		"BLOODTHIRSTY",
		"ELEMENTAL",
		"ENLIGHTENED",
		"EVASIVE",
		"GOLDEN",
		"HARDY",
		"LEECHING",
		"MARTYR",
		"MONARCH",
		"PHASING",
		"SCHOLARLY",
		"SOULBOUND",
		"THORNY",
		"VENGEFUL"
	];
}


//===============================================================================//
//
// FUNCTION: SCR_BATTLE_ELITE_CHEAT_RESTORE_BASE
// FUNCTION: Restores a battle enemy to its snapshotted pre-Elite stat state.
//
//           Current HP percentage is preserved across the rebuild rather than
//           fully healing the target.
//
// RETURNS: True on success.
//===============================================================================//
function scr_battle_elite_cheat_restore_base(_ref_beast){
	#region VALIDATION

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
		)
	){
		return false;
	}

	var _stct_unit =
		_ref_beast._ref_unit;

	if (
		!variable_struct_exists(
			_stct_unit,
			"_stct_elite_base_stats"
		) ||
		!is_struct(
			_stct_unit
				._stct_elite_base_stats
		)
	){
		return false;
	}

	var _stct_base =
		_stct_unit
			._stct_elite_base_stats;

	#endregion

	#region PRESERVE HP RATIO

	var _val_hp_ratio = 1;

	if (_ref_beast._val_max_hp > 0){
		_val_hp_ratio =
			clamp(
				_ref_beast._val_cur_hp /
					_ref_beast._val_max_hp,
				0,
				1
			);
	}

	#endregion

	#region RESTORE UNIT PRIMARY STATS

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
		max(
			1,
			_stct_base._val_beast_hp_max
		);

	#endregion

	#region RESTORE RUNTIME STATS

	_ref_beast._val_max_hp =
		_stct_unit._val_beast_hp_max;

	_ref_beast._val_cur_hp =
		clamp(
			ceil(
				_ref_beast._val_max_hp *
				_val_hp_ratio
			),
			0,
			_ref_beast._val_max_hp
		);

	if (
		_ref_beast._str_list ==
			"ALIVE" &&
		_ref_beast._val_cur_hp <= 0
	){
		_ref_beast._val_cur_hp = 1;
	}

	_stct_unit._val_beast_hp_cur =
		_ref_beast._val_cur_hp;

	_ref_beast._val_crit_chance =
		_stct_unit._val_beast_crit_stat;

	_ref_beast._val_speed_base =
		_stct_unit._val_beast_speed_stat;

	#endregion

	#region RESET ELITE-OWNED STATE

	_stct_unit._flag_elite =
		false;

	_stct_unit._str_elite_modifier =
		"";

	_stct_unit._flag_elite_stats_applied =
		false;

	_stct_unit
		._str_elite_modifier_stats_applied =
		"";

	_stct_unit._arr_elite_card_ids =
		[];

	_stct_unit._str_elite_primary_card_id =
		"";

	_stct_unit._str_elite_monarch_card_id =
		"";

	_stct_unit
		._arr_elite_vengeful_counted_death_uids =
		[];

	_stct_unit
		._arr_elite_vengeful_starting_ally_uids =
		[];

	_stct_unit
		._stct_elite_vengeful_stat_basis =
		undefined;

	_stct_unit
		._str_elite_elemental_variant =
		"";

	_stct_unit
		._uid_elite_soulbound_protected =
		undefined;

	_stct_unit
		._flag_elite_soulbound_assignment_initialized =
		false;

	_ref_beast
		._ref_elite_soulbound_protected =
		undefined;

	_ref_beast
		._ct_elite_phasing_turns_seen =
		0;

	_ref_beast
		._flag_elite_elemental_entry_applied =
		false;

	_ref_beast
		._flag_elite_entry_effect_applied =
		false;

	_ref_beast
		._flag_elite_death_modifiers_resolved =
		false;

	#endregion

	return true;
}


//===============================================================================//
//
// FUNCTION: SCR_BATTLE_ELITE_CHEAT_SET_MODIFIER
// FUNCTION: Promotes/changes one living ENEMY battle Beast to a selected Elite.
//
//           The target is rebuilt from its pre-Elite snapshot before applying
//           the selected modifier, preventing HARDY/BLOODTHIRSTY/etc. stacking.
//
//           Cheats may optionally force ELEMENTAL to STORM, FIRE, FROST, or
//           VERDANT. Natural Elemental Elites remain random.
//
// ARGUMENTS: _ref_beast - Living ENEMY battle Beast.
//            _str_modifier - Elite modifier ID.
//            _str_elemental_variant - Optional forced ELEMENTAL variant.
// RETURNS: True on success.
//===============================================================================//
function scr_battle_elite_cheat_set_modifier(_ref_beast,_str_modifier,_str_elemental_variant=undefined){
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

	_str_modifier =
		string_upper(
			string(
				_str_modifier
			)
		);

	if (
		_str_modifier ==
			"REFORGED" ||
		!array_contains(
			scr_battle_elite_get_cheat_modifiers(),
			_str_modifier
		)
	){
		return false;
	}

	//====================//
	//ELEMENTAL OVERRIDE//
	//====================//
	var _str_forced_elemental_variant =
		"";

	if (
		_str_elemental_variant !=
			undefined
	){
		_str_forced_elemental_variant =
			string_upper(
				string(
					_str_elemental_variant
				)
			);
	}

	if (
		_str_modifier ==
			"ELEMENTAL"
	){
		if (
			_str_forced_elemental_variant !=
				"" &&
			_str_forced_elemental_variant !=
				"STORM" &&
			_str_forced_elemental_variant !=
				"FIRE" &&
			_str_forced_elemental_variant !=
				"FROST" &&
			_str_forced_elemental_variant !=
				"VERDANT"
		){
			return false;
		}
	}
	else{
		_str_forced_elemental_variant =
			"";
	}

	var _stct_unit =
		_ref_beast._ref_unit;

	var _flag_was_elite =
		variable_struct_exists(
			_stct_unit,
			"_flag_elite"
		) &&
		_stct_unit._flag_elite;

	if (!_flag_was_elite){
		_stct_unit._val_elite_risk_tier = 0;
	}

	#endregion

	#region ENSURE BASE SNAPSHOT

	/*
		Normal enemies do not pass through SCR_BATTLE_ELITE_APPLY during spawn.
		Calling APPLY once here creates the clean baseline before its first Elite
		mutation. We then immediately restore and perform the normal rebuild path.
	*/
	if (
		!variable_struct_exists(
			_stct_unit,
			"_stct_elite_base_stats"
		) ||
		!is_struct(
			_stct_unit
				._stct_elite_base_stats
		)
	){
		/*
			Manually snapshot current normal state so no temporary Elite mutation
			is needed merely to establish the baseline.
		*/
		_stct_unit._stct_elite_base_stats = {
			_val_beast_hp_stat :
				_stct_unit._val_beast_hp_stat,

			_val_beast_con_stat :
				_stct_unit._val_beast_con_stat,

			_val_beast_ppow_stat :
				_stct_unit._val_beast_ppow_stat,

			_val_beast_mpow_stat :
				_stct_unit._val_beast_mpow_stat,

			_val_beast_pdef_stat :
				_stct_unit._val_beast_pdef_stat,

			_val_beast_mdef_stat :
				_stct_unit._val_beast_mdef_stat,

			_val_beast_speed_stat :
				_stct_unit._val_beast_speed_stat,

			_val_beast_crit_stat :
				_stct_unit._val_beast_crit_stat,

			_val_beast_hp_max :
				_ref_beast._val_max_hp,

			_val_beast_hp_cur :
				_ref_beast._val_cur_hp
		};
	}

	#endregion

	#region REBUILD FROM BASE

	if (
		!scr_battle_elite_cheat_restore_base(
			_ref_beast
		)
	){
		return false;
	}

	if (
		!scr_battle_elite_apply(
			_stct_unit,
			_str_modifier
		)
	){
		return false;
	}

	//================================//
	//FORCE ELEMENTAL CHEAT VARIANT//
	//================================//
	/*
		Natural Elemental Elites continue to roll randomly. Cheats may supply one
		explicit variant so the matching immunity/VFX/Weather can be tested.
	*/
	if (
		_str_modifier ==
			"ELEMENTAL" &&
		_str_forced_elemental_variant !=
			""
	){
		_stct_unit._str_elite_elemental_variant =
			_str_forced_elemental_variant;
	}

	#endregion

	#region SYNC LIVE INSTANCE

	var _val_hp_ratio =
		1;

	if (
		_stct_unit
			._stct_elite_base_stats
			._val_beast_hp_max >
		0
	){
		_val_hp_ratio =
			clamp(
				_ref_beast._val_cur_hp /
				_stct_unit
					._stct_elite_base_stats
					._val_beast_hp_max,
				0,
				1
			);
	}

	_ref_beast._val_max_hp =
		_stct_unit._val_beast_hp_max;

	_ref_beast._val_cur_hp =
		clamp(
			ceil(
				_ref_beast._val_max_hp *
				_val_hp_ratio
			),
			1,
			_ref_beast._val_max_hp
		);

	_stct_unit._val_beast_hp_cur =
		_ref_beast._val_cur_hp;

	_ref_beast._val_crit_chance =
		_stct_unit._val_beast_crit_stat;

	_ref_beast._val_speed_base =
		_stct_unit._val_beast_speed_stat;

	/*
		Entry effects resolve against the LIVE battle instance. Sync the newly
		selected Elite state before triggering them so SOULBOUND and ELEMENTAL
		immediately see the new modifier through SCR_BATTLE_ELITE_GET_MODIFIER.
	*/
	_ref_beast._flag_elite =
		true;

	_ref_beast._str_elite_modifier =
		_str_modifier;

	if (
		variable_struct_exists(
			_stct_unit,
			"_val_elite_risk_tier"
		)
	){
		_ref_beast._val_elite_risk_tier =
			_stct_unit._val_elite_risk_tier;
	}

	#endregion

	#region ENTRY EFFECTS

	/*
		Elemental and Soulbound entry mechanics must occur immediately when the
		modifier is selected through Cheats.
	*/
	if (
		instance_exists(
			obj_battle_enemy_controller
		) &&
		ds_exists(
			obj_battle_enemy_controller
				._list_beasts_alive,
			ds_type_list
		)
	){
		scr_battle_elite_trigger_entry_effects(
			obj_battle_enemy_controller
				._list_beasts_alive
		);
	}

	#endregion

	scr_debug_log(
		"BATTLE",
		"ELITE",
		_ref_beast,
		"CHEAT ELITE MODIFIER SET" +
		" | MODIFIER: " +
		_str_modifier +
		" | HP: " +
		string(
			_ref_beast._val_cur_hp
		) +
		"/" +
		string(
			_ref_beast._val_max_hp
		),
		"CHEAT",
		"SCR_BATTLE_ELITE_CHEAT_SET_MODIFIER"
	);

	return true;
}


//===============================================================================//
//
// FUNCTION: SCR_BATTLE_ELITE_CHEAT_SET_RISK_TIER
// FUNCTION: Rebuilds one living ENEMY Elite at Risk Tier 0 or 1 while retaining
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
			1
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
