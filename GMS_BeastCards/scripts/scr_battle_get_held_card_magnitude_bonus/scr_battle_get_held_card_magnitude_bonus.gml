//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_HELD_CARD_MAGNITUDE_BONUS
// FUNCTION: Returns the base Card-magnitude bonus supplied by the casting Beast's
//           Held Item for the current Attack Card.
//
//           Only Attack Cards using LINEAR or PERCENT damage magnitude qualify.
//           This deliberately excludes DoT-stack magnitudes, Buff/Debuff values,
//           Minion effects, weather, retaliation, and other triggered damage.
//
//           PASSIVE_MODIFIER Held Items return a modifier struct containing:
//             _str_card_color
//             _val_card_magnitude_bonus
//
//           A dual-color Card qualifies when its color array contains the Held
//           Item's requested color.
//
// ARGUMENTS: _ref_caster - Battle Beast casting the Card.
//            _stct_card - Card struct being resolved.
// RETURNS: Nonnegative base-magnitude bonus. Returns 0 when no modifier applies.
//
//===============================================================================//

function scr_battle_get_held_card_magnitude_bonus(_ref_caster,_stct_card){

	#region VALIDATION

	if (!instance_exists(_ref_caster)){
		return 0;
	}

	if (!is_struct(_stct_card)){
		return 0;
	}

	if (
		!variable_struct_exists(_stct_card,"_str_card_type") ||
		string_upper(string(_stct_card._str_card_type)) != "ATTACK"
	){
		return 0;
	}

	if (
		!variable_struct_exists(_stct_card,"_str_card_scalar") ||
		!is_string(_stct_card._str_card_scalar)
	){
		return 0;
	}

	var _str_scalar =
		string_upper(
			string(
				_stct_card._str_card_scalar
			)
		);

	if (
		_str_scalar != "LINEAR" &&
		_str_scalar != "PERCENT"
	){
		return 0;
	}

	if (
		!variable_struct_exists(_stct_card,"_arr_card_colors") ||
		!is_array(_stct_card._arr_card_colors)
	){
		return 0;
	}

	if (!variable_instance_exists(_ref_caster,"_stct_held_item")){
		return 0;
	}

	var _stct_item =
		_ref_caster._stct_held_item;

	if (!is_struct(_stct_item)){
		return 0;
	}

	if (
		!variable_struct_exists(_stct_item,"_str_item_trigger_type") ||
		string_upper(string(_stct_item._str_item_trigger_type)) !=
			"PASSIVE_MODIFIER"
	){
		return 0;
	}

	if (
		!variable_struct_exists(_stct_item,"_scr_item") ||
		_stct_item._scr_item == undefined
	){
		return 0;
	}

	#endregion

	#region GET MODIFIER

	var _stct_target_unit = undefined;

	if (
		variable_instance_exists(_ref_caster,"_ref_unit") &&
		is_struct(_ref_caster._ref_unit)
	){
		_stct_target_unit = _ref_caster._ref_unit;
	}

	var _stct_modifier =
		script_execute(
			_stct_item._scr_item,
			"TRIGGER",
			_stct_item,
			_stct_target_unit
		);

	if (!is_struct(_stct_modifier)){
		return 0;
	}

	if (
		!variable_struct_exists(_stct_modifier,"_str_card_color") ||
		!variable_struct_exists(_stct_modifier,"_val_card_magnitude_bonus") ||
		!is_real(_stct_modifier._val_card_magnitude_bonus)
	){
		return 0;
	}

	var _str_required_color =
		string_upper(
			string(
				_stct_modifier._str_card_color
			)
		);

	var _val_bonus =
		max(
			0,
			_stct_modifier._val_card_magnitude_bonus
		);

	if (_val_bonus <= 0){
		return 0;
	}

	#endregion

	#region COLOR MATCH

	for (
		var _it_color = 0;
		_it_color < array_length(_stct_card._arr_card_colors);
		_it_color++
	){

		var _str_card_color =
			_stct_card._arr_card_colors[_it_color];

		if (_str_card_color == undefined){
			continue;
		}

		if (
			string_upper(string(_str_card_color)) ==
				_str_required_color
		){
			return _val_bonus;
		}
	}

	#endregion

	return 0;
}
