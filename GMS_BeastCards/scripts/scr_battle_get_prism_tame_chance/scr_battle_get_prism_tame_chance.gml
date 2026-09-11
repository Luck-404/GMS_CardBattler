//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_PRISM_TAME_CHANCE
// FUNCTION: Calculates the final tame chance for a Prism used on an enemy Beast.
//           Combines base chance, Logbook familiarity, current ownership,
//           Prism tier bonus, and the target's missing HP.
//
// INPUTS:   _str_prism_id - Item ID of the Prism being used.
//           _ref_target_beast - Enemy battle Beast being targeted for capture.
// USES:     Prism data, Beast Logbook data, ownership data, and the target's
//           current and maximum battle HP.
//
//===============================================================================//

function scr_battle_get_prism_tame_chance(_str_prism_id,_ref_target_beast){

	#region VALIDATION

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target_beast)){
		return 0;
	}

	if (_ref_target_beast._str_team != "ENEMY"){
		return 0;
	}

	if (_ref_target_beast._val_cur_hp <= 0){
		return 0;
	}

	//----------------//
	//VALIDATE PRISM//
	//----------------//
	var _stct_prism_info = scr_inventory_get_prism_info(_str_prism_id);

	if (_stct_prism_info == undefined){
		return 0;
	}

	//-------------------//
	//GUARANTEED CAPTURE//
	//-------------------//
	if (_stct_prism_info._flag_guaranteed){
		return 100;
	}

	//--------------//
	//VALIDATE UNIT//
	//--------------//
	var _stct_target_unit = _ref_target_beast._ref_unit;

	if (_stct_target_unit == undefined){
		return 0;
	}

	#endregion

	#region CAPTURE BONUSES

	//----------------//
	//BASE VALUES//
	//----------------//
	var _str_beast_id = _stct_target_unit._str_beast_name;

	var _val_base_chance = 10;
	var _val_familiarity_bonus = 0;
	var _val_owned_bonus = 0;
	var _val_prism_bonus = _stct_prism_info._val_tame_bonus;
	var _val_hp_bonus = 0;

	//-------------------//
	//FAMILIARITY BONUS//
	//-------------------//
	if (variable_global_exists("map_logbook_beasts") && ds_map_exists(global.map_logbook_beasts,_str_beast_id)){

		var _stct_logbook_entry = global.map_logbook_beasts[? _str_beast_id];

		if (_stct_logbook_entry._flag_captured){
			_val_familiarity_bonus = 5;
		}
	}

	//-----------//
	//OWNED BONUS//
	//-----------//
	if (scr_logbook_get_beast_owned_count(_str_beast_id) > 0){
		_val_owned_bonus = 5;
	}

	//--------//
	//HP BONUS//
	//--------//
	var _val_hp_percent = clamp(_ref_target_beast._val_cur_hp / _ref_target_beast._val_max_hp,0,1);
	var _val_missing_hp_percent = 1 - _val_hp_percent;

	_val_hp_bonus = floor(_val_missing_hp_percent * 10);

	if (_val_hp_percent <= 0.05){
		_val_hp_bonus = 10;
	}

	#endregion

	#region FINAL CHANCE

	//----------------------//
	//CALCULATE FINAL CHANCE//
	//----------------------//
	var _val_final_chance =
		_val_base_chance +
		_val_familiarity_bonus +
		_val_owned_bonus +
		_val_prism_bonus +
		_val_hp_bonus;

	return clamp(_val_final_chance,0,100);

	#endregion
}