//===============================================================================//
//
// SCRIPT: SCR_GET_MINION_TARGET
// FUNCTION: Selects an enemy target for a Minion.
//           Prioritizes living Beasts affected by Focus.
//           Supports optional positional targeting preferences.
//           Falls back to a random living enemy.
//
//===============================================================================//

function scr_get_minion_target(
	_list_enemy,
	_ref_exclude=undefined,
	_str_preference=undefined
){

	if (_list_enemy == undefined){
		return undefined;
	}

	if (ds_list_size(_list_enemy) <= 0){
		return undefined;
	}

	var _arr_targets = [];
	var _arr_focus_targets = [];

	//-----------------------//
	//BUILD ELIGIBLE TARGETS//
	//-----------------------//
	for (
		var _it_enemy = 0;
		_it_enemy < ds_list_size(_list_enemy);
		_it_enemy++
	){

		var _ref_enemy =
			ds_list_find_value(
				_list_enemy,
				_it_enemy
			);

		if (!instance_exists(_ref_enemy)){
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

		array_push(
			_arr_targets,
			_ref_enemy
		);

		//-------------//
		//CHECK FOCUS//
		//-------------//
		if (
			scr_check_for_status(
				"FOCUS",
				_ref_enemy
			) != -1
		){

			array_push(
				_arr_focus_targets,
				_ref_enemy
			);
		}
	}

	//------------------------//
	//PRIORITIZE FOCUS TARGET//
	//------------------------//
	if (array_length(_arr_focus_targets) > 0){

		return _arr_focus_targets[
			irandom(
				array_length(_arr_focus_targets) - 1
			)
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

		for (
			var _it_target = _it_back_start;
			_it_target < array_length(_arr_targets);
			_it_target++
		){

			array_push(
				_arr_preferred_targets,
				_arr_targets[_it_target]
			);
		}

		if (array_length(_arr_preferred_targets) > 0){

			return _arr_preferred_targets[
				irandom(
					array_length(_arr_preferred_targets) - 1
				)
			];
		}
	}

	//--------------------//
	//GET RANDOM TARGET//
	//--------------------//
	return _arr_targets[
		irandom(
			array_length(_arr_targets) - 1
		)
	];
}