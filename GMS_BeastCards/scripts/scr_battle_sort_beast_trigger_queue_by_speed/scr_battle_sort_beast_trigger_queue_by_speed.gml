//===============================================================================//
//
// SCRIPT: SCR_BATTLE_SORT_BEAST_TRIGGER_QUEUE_BY_SPEED
// FUNCTION: Sorts a Beast-owned trigger queue by current host Speed.
//           Higher-Speed Beasts resolve all of their triggers first.
//           Different Beasts with identical Speed receive one random tie roll.
//           Triggers belonging to the same Beast preserve their original order.
//           Invalid or non-Beast triggers are preserved at the end.
//
// INPUT:    _list_triggers - Battle trigger queue being sorted.
//
//===============================================================================//

function scr_battle_sort_beast_trigger_queue_by_speed(_list_triggers){

	//---------------//
	//VALIDATE QUEUE//
	//---------------//
	if (!ds_exists(_list_triggers,ds_type_list)){
		return false;
	}

	var _ct_triggers = ds_list_size(_list_triggers);

	if (_ct_triggers <= 1){
		return true;
	}

	//----------------//
	//QUEUE SNAPSHOT//
	//----------------//
	var _arr_hosts = [];
	var _arr_original_triggers = [];

	for (var _it_trigger = 0; _it_trigger < _ct_triggers; _it_trigger++){

		var _stct_trigger = ds_list_find_value(_list_triggers,_it_trigger);

		array_push(_arr_original_triggers,_stct_trigger);

		if (!is_struct(_stct_trigger)){
			continue;
		}

		if (!variable_struct_exists(_stct_trigger,"_ref_beast")){
			continue;
		}

		var _ref_beast = _stct_trigger._ref_beast;

		if (!instance_exists(_ref_beast)){
			continue;
		}

		//-------------------//
		//CHECK KNOWN HOST//
		//-------------------//
		var _flag_host_exists = false;
		var _ct_hosts = array_length(_arr_hosts);

		for (var _it_host = 0; _it_host < _ct_hosts; _it_host++){

			if (_arr_hosts[_it_host]._ref_beast == _ref_beast){

				_flag_host_exists = true;

				break;
			}
		}

		if (_flag_host_exists){
			continue;
		}

		//---------------//
		//ADD HOST DATA//
		//---------------//
		var _stct_host = {
			_ref_beast : _ref_beast,
			_val_speed : scr_battle_get_beast_speed(_ref_beast),
			_val_tie_roll : random(1)
		};

		array_push(_arr_hosts,_stct_host);
	}

	//----------------//
	//SORT BEAST HOSTS//
	//----------------//
	/*
		Higher Speed resolves first.

		Each Beast receives one tie roll when the queue is built.
		Equal-Speed Beasts are ordered by that roll without rerolling
		during trigger execution.

		Triggers belonging to the same Beast remain grouped and retain
		their original order.
	*/
	var _ct_hosts = array_length(_arr_hosts);

	for (var _it_host = 1; _it_host < _ct_hosts; _it_host++){

		var _stct_key_host = _arr_hosts[_it_host];
		var _it_compare = _it_host - 1;

		while (_it_compare >= 0){

			var _stct_compare_host = _arr_hosts[_it_compare];

			var _flag_key_first = false;

			if (_stct_key_host._val_speed > _stct_compare_host._val_speed){
				_flag_key_first = true;
			}
			else if (
				_stct_key_host._val_speed == _stct_compare_host._val_speed &&
				_stct_key_host._val_tie_roll > _stct_compare_host._val_tie_roll
			){
				_flag_key_first = true;
			}

			if (!_flag_key_first){
				break;
			}

			_arr_hosts[_it_compare + 1] = _stct_compare_host;

			_it_compare--;
		}

		_arr_hosts[_it_compare + 1] = _stct_key_host;
	}

	//----------------//
	//REBUILD QUEUE//
	//----------------//
	ds_list_clear(_list_triggers);

	for (var _it_host = 0; _it_host < _ct_hosts; _it_host++){

		var _ref_host = _arr_hosts[_it_host]._ref_beast;

		for (var _it_trigger = 0; _it_trigger < _ct_triggers; _it_trigger++){

			var _stct_trigger = _arr_original_triggers[_it_trigger];

			if (!is_struct(_stct_trigger)){
				continue;
			}

			if (!variable_struct_exists(_stct_trigger,"_ref_beast")){
				continue;
			}

			if (_stct_trigger._ref_beast != _ref_host){
				continue;
			}

			ds_list_add(_list_triggers,_stct_trigger);
		}
	}

	//-----------------------------//
	//PRESERVE NON-BEAST TRIGGERS//
	//-----------------------------//
	for (var _it_trigger = 0; _it_trigger < _ct_triggers; _it_trigger++){

		var _stct_trigger = _arr_original_triggers[_it_trigger];

		if (
			is_struct(_stct_trigger) &&
			variable_struct_exists(_stct_trigger,"_ref_beast") &&
			instance_exists(_stct_trigger._ref_beast)
		){
			continue;
		}

		ds_list_add(_list_triggers,_stct_trigger);
	}

	return true;
}