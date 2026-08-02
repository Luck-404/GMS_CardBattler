//===============================================================================//
//
// SCRIPT: SCR_CLEANSE_NEGATIVE
// FUNCTION: Randomly removes negative statuses from a target Beast.
//           Negative statuses include DEBUFF, DOT, and CC.
//           Removes the full selected status including all stacks.
//
//===============================================================================//

function scr_cleanse_negative(_ref_target,_ct_amount){

	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (_ct_amount <= 0){
		return 0;
	}

	var _ct_removed = 0;

	while (_ct_removed < _ct_amount){

		var _arr_candidates = [];

		//----------------//
		//BUILD CANDIDATES//
		//----------------//
		for (
			var _it_status = 0;
			_it_status < ds_list_size(_ref_target._list_statuses);
			_it_status++
		){

			var _ref_status =
				ds_list_find_value(
					_ref_target._list_statuses,
					_it_status
				);

			if (!instance_exists(_ref_status)){
				continue;
			}

			var _flag_negative = (
				_ref_status._str_status_type == "DEBUFF" ||
				_ref_status._str_status_type == "DOT" ||
				_ref_status._str_status_type == "CC"
			);

			if (!_flag_negative){
				continue;
			}

			if (_ref_status._flag_status_uncleansable){
				continue;
			}

			array_push(
				_arr_candidates,
				_ref_status
			);
		}

		//-------------------//
		//NO VALID NEGATIVES//
		//-------------------//
		if (array_length(_arr_candidates) <= 0){
			break;
		}

		//---------------//
		//SELECT RANDOM//
		//---------------//
		var _ref_status_cleanse =
			_arr_candidates[
				irandom(
					array_length(_arr_candidates) - 1
				)
			];

		if (!instance_exists(_ref_status_cleanse)){
			continue;
		}

		var _str_status_name =
			_ref_status_cleanse._str_status_name;

		//----------------//
		//CLEANSE STATUS//
		//----------------//
		if (_ref_status_cleanse._scr_status != undefined){

			_ref_status_cleanse._scr_status(
				"DEATH",
				_ref_status_cleanse
			);
		}
		else{

			scr_destroy_status(
				_ref_status_cleanse
			);
		}

		_ct_removed++;

		scr_spawn_popup_scrolling(
			"TEXT",
			"CLEANSED " + _str_status_name,
			undefined,
			c_green,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

	return _ct_removed;
}