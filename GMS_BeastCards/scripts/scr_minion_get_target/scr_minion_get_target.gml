//===============================================================================//
//
// SCRIPT: SCR_MINION_GET_TARGET
// FUNCTION: Selects a living, valid enemy target for a battle Minion.
//           Prioritizes living Beasts affected by Focus.
//           Supports optional positional targeting preferences.
//           Falls back to a random living enemy.
//
// ARGUMENTS: _list_enemy      - Enemy team's living Beast list.
//            _ref_exclude     - Optional Beast to exclude from selection.
//            _str_preference  - Optional positional targeting preference.
// RETURNS: Eligible Beast instance or undefined when none exist.
//
//===============================================================================//

function scr_minion_get_target(_list_enemy,_ref_exclude=undefined,_str_preference=undefined){

	//--------------------//
	//VALIDATE ENEMY LIST//
	//--------------------//
	if (!ds_exists(_list_enemy,ds_type_list)){
		return undefined;
	}

	var _ct_enemy_candidates = ds_list_size(_list_enemy);
	if (_ct_enemy_candidates <= 0){
		return undefined;
	}

	//---------------//
	//TARGET ARRAYS//
	//---------------//
	var _arr_targets = [];
	var _arr_focus_targets = [];

	//-----------------------//
	//BUILD ELIGIBLE TARGETS//
	//-----------------------//
	for (var _it_enemy = 0;_it_enemy < _ct_enemy_candidates;_it_enemy++){

		var _ref_enemy = ds_list_find_value(
			_list_enemy,
			_it_enemy
		);

		if (!instance_exists(_ref_enemy)){
			continue;
		}

		if (!variable_instance_exists(_ref_enemy,"_ref_unit") || !is_struct(_ref_enemy._ref_unit)){
			continue;
		}

		if (_ref_enemy == _ref_exclude){
			continue;
		}

		if (
			_ref_enemy._str_list != "ALIVE" ||
			_ref_enemy._val_cur_hp <= 0
		){
			continue;
		}

		array_push(_arr_targets,_ref_enemy);

		//-------------//
		//CHECK FOCUS//
		//-------------//
		if (scr_status_check("FOCUS",_ref_enemy) != -1){
			array_push(_arr_focus_targets,_ref_enemy);
		}
	}

	//------------------------//
	//PRIORITIZE FOCUS TARGET//
	//------------------------//
	if (array_length(_arr_focus_targets) > 0){

		return _arr_focus_targets[
			irandom(array_length(_arr_focus_targets) - 1)
		];
	}

	//----------------//
	//NO VALID TARGET//
	//----------------//
	if (array_length(_arr_targets) <= 0){
		return undefined;
	}

	//======================//
	//BACK HALF PREFERENCE//
	//======================//
	if (_str_preference == "BACK_HALF"){

		var _arr_preferred_targets = [];

		var _it_back_start =
			floor(
				array_length(_arr_targets) /
				2
			);

		for (var _it_target = _it_back_start;_it_target < array_length(_arr_targets);_it_target++){
			array_push(_arr_preferred_targets,_arr_targets[_it_target]);
		}

		if (array_length(_arr_preferred_targets) > 0){

			return _arr_preferred_targets[
				irandom(array_length(_arr_preferred_targets) - 1)
			];
		}
	}

	//------------------//
	//GET RANDOM TARGET//
	//------------------//
	return _arr_targets[
		irandom(array_length(_arr_targets) - 1)
	];
}
