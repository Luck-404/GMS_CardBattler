//===============================================================================//
//
// SCRIPT: SCR_SORT_BEAST_TRIGGER_QUEUE_BY_SPEED
// FUNCTION: Sorts a Beast-owned trigger queue by current host Speed.
//           Higher-Speed Beasts resolve all of their triggers first.
//           Different Beasts with identical Speed receive a random tie roll.
//           For two tied Beasts, this functions as a 50/50 coin flip.
//           Triggers belonging to the same Beast preserve their original order.
//
//===============================================================================//

function scr_sort_beast_trigger_queue_by_speed(_list_triggers){

	if (!ds_exists(_list_triggers,ds_type_list)){
		return false;
	}

	if (ds_list_size(_list_triggers) <= 1){
		return true;
	}

	var _arr_hosts = [];
	var _arr_original_triggers = [];

	//----------------------//
	//SNAPSHOT TRIGGER QUEUE//
	//----------------------//
	for (var _it_trigger = 0; _it_trigger < ds_list_size(_list_triggers); _it_trigger++){

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

		//-------------------------//
		//CHECK IF HOST WAS ADDED//
		//-------------------------//
		var _flag_host_exists = false;

		for (var _it_host_check = 0; _it_host_check < array_length(_arr_hosts); _it_host_check++){

			if (_arr_hosts[_it_host_check]._ref_beast == _ref_beast){
				_flag_host_exists = true;
				break;
			}
		}

		if (_flag_host_exists){
			continue;
		}

		//----------------//
		//ADD HOST ENTRY//
		//----------------//
		var _stct_host = {
			_ref_beast : _ref_beast,
			_val_speed : scr_get_battle_beast_speed(_ref_beast),
			_val_tie_roll : random(1)
		};

		array_push(_arr_hosts,_stct_host);
	}


	//-------------------//
	//SORT BEAST HOSTS//
	//-------------------//
	/*
		Higher Speed always resolves first.

		Exact Speed tie:
		A random tie value is generated once when the queue is built.
		For two tied Beasts, either Beast has a 50% chance to go first.

		For three or more tied Beasts, the tied group receives a random
		order rather than repeatedly rerolling during queue execution.
	*/
	for (var _it_host = 1; _it_host < array_length(_arr_hosts); _it_host++){

		var _stct_key = _arr_hosts[_it_host];
		var _it_compare = _it_host - 1;

		while (_it_compare >= 0){

			var _stct_current = _arr_hosts[_it_compare];

			var _flag_key_first = false;

			if (_stct_key._val_speed > _stct_current._val_speed){
				_flag_key_first = true;
			}
			else if (_stct_key._val_speed == _stct_current._val_speed){

				if (_stct_key._val_tie_roll > _stct_current._val_tie_roll){
					_flag_key_first = true;
				}
			}

			if (!_flag_key_first){
				break;
			}

			_arr_hosts[_it_compare + 1] = _stct_current;

			_it_compare--;
		}

		_arr_hosts[_it_compare + 1] = _stct_key;
	}


	//----------------//
	//REBUILD QUEUE//
	//----------------//
	ds_list_clear(_list_triggers);

	for (var _it_host = 0; _it_host < array_length(_arr_hosts); _it_host++){

		var _ref_host = _arr_hosts[_it_host]._ref_beast;

		for (var _it_trigger = 0; _it_trigger < array_length(_arr_original_triggers); _it_trigger++){

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


	//--------------------------------//
	//PRESERVE NON-BEAST TRIGGERS LAST//
	//--------------------------------//
	for (var _it_trigger = 0; _it_trigger < array_length(_arr_original_triggers); _it_trigger++){

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