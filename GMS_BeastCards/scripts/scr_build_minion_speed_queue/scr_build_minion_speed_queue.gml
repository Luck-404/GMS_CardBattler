//===============================================================================//
//
// SCRIPT: SCR_BUILD_MINION_SPEED_QUEUE
// FUNCTION: Builds a snapshot Minion activation queue for one active team.
//           Sorts Beast hosts from highest to lowest current Speed.
//           Randomizes the order of different hosts with identical Speed.
//           Keeps every host's Minions together in their existing list order.
//
//===============================================================================//

function scr_build_minion_speed_queue(_list_beasts_alive){

	var _list_return = ds_list_create();
	var _arr_hosts = [];

	//------------------//
	//BUILD HOST ENTRIES//
	//------------------//
	for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

		var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (_ref_beast._str_list != "ALIVE" || _ref_beast._val_cur_hp <= 0){
			continue;
		}

		if (ds_list_size(_ref_beast._list_minions) <= 0){
			continue;
		}

		var _stct_host_entry = {
			_ref_host : _ref_beast,
			_val_speed : scr_get_battle_beast_speed(_ref_beast),
			_val_tie_roll : random(1)
		};

		array_push(_arr_hosts,_stct_host_entry);
	}


	//------------------//
	//SORT HOSTS BY SPEED//
	//------------------//
	/*
		Insertion sort is used here because Beast teams are tiny.

		Primary:
		Higher Speed goes first.

		Secondary:
		Equal-Speed hosts use the random tie roll generated when
		this queue was created.

		The tie roll is stored before sorting so the comparison
		remains stable throughout this snapshot.
	*/
	for (var _it_host = 1; _it_host < array_length(_arr_hosts); _it_host++){

		var _stct_key =
			_arr_hosts[_it_host];

		var _it_compare =
			_it_host - 1;

		while (_it_compare >= 0){

			var _stct_current =
				_arr_hosts[_it_compare];

			var _flag_key_goes_first =
				false;

			// HIGHER SPEED
			if (_stct_key._val_speed > _stct_current._val_speed){

				_flag_key_goes_first =
					true;
			}

			// SPEED TIE
			else if (
				_stct_key._val_speed ==
				_stct_current._val_speed
			){

				if (
					_stct_key._val_tie_roll >
					_stct_current._val_tie_roll
				){

					_flag_key_goes_first =
						true;
				}
			}

			if (!_flag_key_goes_first){
				break;
			}

			_arr_hosts[_it_compare + 1] =
				_stct_current;

			_it_compare--;
		}

		_arr_hosts[_it_compare + 1] =
			_stct_key;
	}


	//------------------//
	//BUILD MINION QUEUE//
	//------------------//
	for (var _it_host = 0; _it_host < array_length(_arr_hosts); _it_host++){

		var _ref_host =
			_arr_hosts[_it_host]._ref_host;

		if (!instance_exists(_ref_host)){
			continue;
		}

		for (var _it_minion = 0; _it_minion < ds_list_size(_ref_host._list_minions); _it_minion++){

			var _ref_minion =
				ds_list_find_value(
					_ref_host._list_minions,
					_it_minion
				);

			if (!instance_exists(_ref_minion)){
				continue;
			}

			ds_list_add(
				_list_return,
				_ref_minion
			);
		}
	}

	return _list_return;
}