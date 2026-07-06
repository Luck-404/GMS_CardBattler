//===============================================================================//
//
// SCRIPT: SCR_GET_PRISM_TAME_CHANCE
// FUNCTION: Calculates final tame chance for a prism used on a battle beast.
//           Uses base chance, logbook familiarity, current ownership,
//           prism tier bonus, and missing HP bonus.
//
//===============================================================================//

function scr_get_prism_tame_chance(_str_prism_id,_ref_target_beast){

	if (!instance_exists(_ref_target_beast)){
		return 0;
	}

	if (_ref_target_beast._str_team != "ENEMY"){
		return 0;
	}

	if (_ref_target_beast._val_cur_hp <= 0){
		return 0;
	}

	var _stct_prism_info = scr_get_prism_info(_str_prism_id);

	if (_stct_prism_info == undefined){
		return 0;
	}

	if (_stct_prism_info._flag_guaranteed){
		return 100;
	}

	var _stct_unit = _ref_target_beast._ref_unit;

	if (_stct_unit == undefined){
		return 0;
	}

	var _str_beast_id = _stct_unit._str_beast_name;

	var _val_base_chance = 10;
	var _val_familiarity_bonus = 0;
	var _val_owned_bonus = 0;
	var _val_prism_bonus = _stct_prism_info._val_tame_bonus;
	var _val_hp_bonus = 0;

	//-------------------//
	//LOGBOOK FAMILIARITY//
	//-------------------//
	if (variable_global_exists("map_logbook_beasts") && ds_map_exists(global.map_logbook_beasts,_str_beast_id)){

		var _stct_entry = global.map_logbook_beasts[? _str_beast_id];

		if (_stct_entry._flag_captured){
			_val_familiarity_bonus = 5;
		}
	}

	//-------------//
	//OWNED BONUS//
	//-------------//
	if (scr_logbook_get_beast_owned_count(_str_beast_id) > 0){
		_val_owned_bonus = 5;
	}

	//---------//
	//HP BONUS//
	//---------//
	var _val_hp_percent = clamp(_ref_target_beast._val_cur_hp / _ref_target_beast._val_max_hp,0,1);
	var _val_missing_percent = 1 - _val_hp_percent;

	_val_hp_bonus = floor(_val_missing_percent * 10);

	if (_val_hp_percent <= 0.05){
		_val_hp_bonus = 10;
	}

	var _val_final_chance =
		_val_base_chance +
		_val_familiarity_bonus +
		_val_owned_bonus +
		_val_prism_bonus +
		_val_hp_bonus;

	return clamp(_val_final_chance,0,100);
}