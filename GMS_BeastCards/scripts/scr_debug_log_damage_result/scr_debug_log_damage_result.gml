//===============================================================================//
//
// SCRIPT: SCR_DEBUG_LOG_DAMAGE_RESULT
// FUNCTION: Logs one completed direct-damage resolution.
//           Reports final damage after combat calculations and how that damage
//           was distributed across Minions, Armor, Overhealth, and HP.
//
// ARGUMENTS: _ref_caster and _ref_target are the battle Beasts.
//            _stct_card is the resolving Card struct.
//            _val_final_damage is damage after scaling and mitigation.
//            Remaining values are actual damage applied to each layer.
//            _flag_critical marks a Critical Hit.
//            _str_mode identifies Standard, Armor Pierce, or Percent damage.
//            _str_origin identifies the damage helper that resolved the hit.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_debug_log_damage_result(_ref_caster,_ref_target,_stct_card,_val_final_damage,_val_minion_damage,_val_armor_damage,_val_overhealth_damage,_val_hp_damage,_flag_critical,_str_mode,_str_origin){

	//================//
	//VALIDATE DATA//
	//================//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!instance_exists(_ref_target)){
		return;
	}

	if (!is_struct(_ref_caster._ref_unit)){
		return;
	}

	if (!is_struct(_ref_target._ref_unit)){
		return;
	}

	if (!is_struct(_stct_card)){
		return;
	}

	//================//
	//GET IDENTITIES//
	//================//
	var _str_caster_team = string_upper(_ref_caster._str_team);
	var _str_caster_name = string_upper(_ref_caster._ref_unit._str_beast_name);

	var _str_target_team = string_upper(_ref_target._str_team);
	var _str_target_name = string_upper(_ref_target._ref_unit._str_beast_name);

	var _str_card_name = string_upper(_stct_card._str_card_name);
	var _str_damage_type = string_upper(_stct_card._str_card_stat);
	var _str_damage_mode = string_upper(_str_mode);

	//================//
	//BUILD MESSAGE//
	//================//
	var _str_message =
		_str_caster_team + " " +
		_str_caster_name +
		" DEALT " +
		string(_val_final_damage) +
		" " + _str_damage_type +
		" DAMAGE TO " +
		_str_target_team + " " +
		_str_target_name +
		" | CARD: " + _str_card_name;

	if (_str_damage_mode != "STANDARD"){
		_str_message += " | MODE: " + _str_damage_mode;
	}

	_str_message +=
		" | MINIONS: " + string(_val_minion_damage) +
		" | ARMOR: " + string(_val_armor_damage) +
		" | OVERHEALTH: " + string(_val_overhealth_damage) +
		" | HP: " + string(_val_hp_damage) +
		" | TARGET HP: " + string(_ref_target._val_cur_hp) +
		"/" + string(_ref_target._val_max_hp);

	if (_flag_critical){
		_str_message += " (CRIT)";
	}

	//================//
	//WRITE DAMAGE LOG//
	//================//
	scr_debug_log(
		"BATTLE",
		"DAMAGE",
		_ref_target,
		_str_message,
		"BATTLE",
		_str_origin
	);
}