//===============================================================================//
//
// CLEANUP: OBJ_BATTLE_BEAST
// FUNCTION: Destroys attached battle instances and releases Beast-owned lists.
//           Cleans Minions, Statuses, Traps, and the Beast Card deck.
//
//===============================================================================//

#region MINIONS

//----------------//
//DESTROY MINIONS//
//----------------//
if (ds_exists(_list_minions,ds_type_list)){

	for (var _it_minion = ds_list_size(_list_minions) - 1; _it_minion >= 0; _it_minion--){

		var _ref_minion = ds_list_find_value(_list_minions,_it_minion);

		if (instance_exists(_ref_minion)){
			instance_destroy(_ref_minion);
		}
	}

	ds_list_destroy(_list_minions);
}

#endregion

#region STATUSES

//------------------//
//DESTROY STATUSES//
//------------------//
if (ds_exists(_list_statuses,ds_type_list)){

	for (var _it_status = ds_list_size(_list_statuses) - 1; _it_status >= 0; _it_status--){

		var _ref_status = ds_list_find_value(_list_statuses,_it_status);

		if (instance_exists(_ref_status)){
			instance_destroy(_ref_status);
		}
	}

	ds_list_destroy(_list_statuses);
}

#endregion

#region TRAPS

//---------------//
//DESTROY TRAPS//
//---------------//
if (ds_exists(_list_traps,ds_type_list)){

	for (var _it_trap = ds_list_size(_list_traps) - 1; _it_trap >= 0; _it_trap--){

		var _ref_trap = ds_list_find_value(_list_traps,_it_trap);

		if (instance_exists(_ref_trap)){
			instance_destroy(_ref_trap);
		}
	}

	ds_list_destroy(_list_traps);
}

#endregion

#region CARDS

//-------------//
//DESTROY DECK//
//-------------//
if (ds_exists(_list_deck,ds_type_list)){
	ds_list_destroy(_list_deck);
}

#endregion

#region CHEAT STAT ROLLBACK

//====================================//
//RESTORE TEMPORARY CHEAT STAT WRITES//
//====================================//
// Status/Minion cleanup runs first so their owned stat deltas can rollback
// normally. Then restore only persistent fields touched by the Cheats stat editor.
if (
	is_struct(_ref_unit) &&
	is_struct(_stct_cheat_stat_original) &&
	is_array(_arr_cheat_stat_dirty_ids)
){
	var _arr_cheat_stat_fields = [
		["HP","_val_beast_hp_stat"],
		["CON","_val_beast_con_stat"],
		["PPOW","_val_beast_ppow_stat"],
		["MPOW","_val_beast_mpow_stat"],
		["PDEF","_val_beast_pdef_stat"],
		["MDEF","_val_beast_mdef_stat"],
		["SPEED","_val_beast_speed_stat"],
		["CRIT","_val_beast_crit_stat"],
		["CRIT_DMG","_val_beast_crit_dmg_stat"],
		["DODGE","_val_beast_dod_stat"],
		["MIN","_val_beast_min_stat"]
	];

	for (var _it_cheat_stat = 0; _it_cheat_stat < array_length(_arr_cheat_stat_fields); _it_cheat_stat++){
		var _str_cheat_stat_id = _arr_cheat_stat_fields[_it_cheat_stat][0];
		var _str_cheat_stat_field = _arr_cheat_stat_fields[_it_cheat_stat][1];

		if (!array_contains(_arr_cheat_stat_dirty_ids,_str_cheat_stat_id)){
			continue;
		}

		if (!variable_struct_exists(_stct_cheat_stat_original,_str_cheat_stat_field)){
			continue;
		}

		variable_struct_set(
			_ref_unit,
			_str_cheat_stat_field,
			variable_struct_get(
				_stct_cheat_stat_original,
				_str_cheat_stat_field
			)
		);
	}
}

_stct_cheat_stat_original = undefined;
_arr_cheat_stat_dirty_ids = [];

#endregion