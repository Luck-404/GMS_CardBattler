//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_MOLTEN_BRAND_DAMAGE_BONUS
// FUNCTION: Returns Molten Brand's damage bonus percentage when the target
//           has Molten Brand and the resolving Card is Vermilion.
//
// ARGUMENTS: _ref_target is the Beast receiving damage.
//            _stct_card is the resolving Card struct.
// RETURNS: Bonus percentage, or 0 when the effect does not apply.
//
//===============================================================================//

function scr_status_get_molten_brand_damage_bonus(_ref_target,_stct_card){

	//================//
	//VALIDATION//
	//================//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (!is_struct(_stct_card)){
		return 0;
	}

	if (!variable_struct_exists(_stct_card,"_arr_card_colors")){
		return 0;
	}

	var _arr_card_colors = _stct_card._arr_card_colors;

	if (!is_array(_arr_card_colors)){
		return 0;
	}

	//================//
	//CHECK CARD COLOR//
	//================//
	var _flag_vermilion = false;

	for (var _it_color = 0;_it_color < array_length(_arr_card_colors);_it_color++){

		if (_arr_card_colors[_it_color] == "VERMILION"){
			_flag_vermilion = true;
			break;
		}
	}

	if (!_flag_vermilion){
		return 0;
	}

	//================//
	//CHECK MOLTEN BRAND//
	//================//
	var _ref_molten_brand = scr_status_check(
		"MOLTEN_BRAND",
		_ref_target
	);

	if (
		_ref_molten_brand == -1 ||
		!instance_exists(_ref_molten_brand)
	){
		return 0;
	}

	if (_ref_molten_brand._val_status_lifetime <= 0){
		return 0;
	}

	//================//
	//RETURN BONUS//
	//================//
	return max(
		0,
		_ref_molten_brand._val_status_magnitude
	);
}