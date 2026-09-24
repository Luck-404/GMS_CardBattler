
//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_TAUNT_TARGET
// FUNCTION: Returns the host of the newest valid Taunt on a team.
//           Considers both TAUNT and FLAMEGUARD_TAUNT.
//           Older Taunts remain present but do not control targeting.
//           Flameguard Taunt requires its exact source Minion to be alive.
//           Returns undefined when no valid Taunt exists.
//
// ARGUMENTS: _list_team is the target team's Beast DS list.
// RETURNS: The selected living Beast or undefined.
//
//===============================================================================//

function scr_status_get_taunt_target(_list_team){

	//===============//
	//VALIDATE TEAM//
	//===============//
	if (
		_list_team == undefined ||
		!ds_exists(_list_team,ds_type_list)
	){
		return undefined;
	}

	//================//
	//SELECTION DATA//
	//================//
	var _ref_best_beast = undefined;
	var _val_best_priority = -1;

	//================//
	//CHECK TEAM//
	//================//
	for (
		var _it_beast = 0;
		_it_beast < ds_list_size(_list_team);
		_it_beast++
	){

		var _ref_beast = ds_list_find_value(
			_list_team,
			_it_beast
		);

		//----------------//
		//VALIDATE BEAST//
		//----------------//
		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (
			_ref_beast._str_list != "ALIVE" ||
			_ref_beast._val_cur_hp <= 0
		){
			continue;
		}

		if (!ds_exists(_ref_beast._list_statuses,ds_type_list)){
			continue;
		}

		//================//
		//CHECK STATUSES//
		//================//
		for (
			var _it_status = 0;
			_it_status < ds_list_size(_ref_beast._list_statuses);
			_it_status++
		){

			var _ref_status = ds_list_find_value(
				_ref_beast._list_statuses,
				_it_status
			);

			if (!instance_exists(_ref_status)){
				continue;
			}

			//================//
			//VALID TAUNT TYPES//
			//================//
			var _flag_normal_taunt =
				(_ref_status._str_status_name == "TAUNT");

			var _flag_flameguard_taunt =
				(_ref_status._str_status_name == "FLAMEGUARD_TAUNT");

			if (
				!_flag_normal_taunt &&
				!_flag_flameguard_taunt
			){
				continue;
			}

			//================//
			//VALIDATE HOST//
			//================//
			if (_ref_status._ref_host != _ref_beast){
				continue;
			}

			//================//
			//NORMAL TAUNT//
			//================//
			if (_flag_normal_taunt){

				// A status awaiting expiration must not control targeting.
				if (_ref_status._val_status_lifetime <= 0){
					continue;
				}
			}

			//=======================//
			//FLAMEGUARD SOURCE CHECK//
			//=======================//
			if (_flag_flameguard_taunt){

				if (
					!variable_instance_exists(
						_ref_status,
						"_ref_source_minion"
					)
				){
					continue;
				}

				var _ref_source_minion =
					_ref_status._ref_source_minion;

				if (!instance_exists(_ref_source_minion)){
					continue;
				}

				if (
					_ref_source_minion._str_name != "FLAMEGUARD" ||
					_ref_source_minion._val_cur_hp <= 0 ||
					_ref_source_minion._ref_host != _ref_beast
				){
					continue;
				}

				if (
					!ds_exists(_ref_beast._list_minions,ds_type_list)
				){
					continue;
				}

				if (
					ds_list_find_index(
						_ref_beast._list_minions,
						_ref_source_minion
					) == -1
				){
					continue;
				}
			}

			//================//
			//GET PRIORITY//
			//================//
			var _val_priority = 0;

			if (
				variable_instance_exists(
					_ref_status,
					"_val_taunt_priority"
				)
			){

				_val_priority =
					_ref_status._val_taunt_priority;
			}

			//================//
			//PREFER NEWEST//
			//================//
			if (_val_priority > _val_best_priority){

				_val_best_priority = _val_priority;
				_ref_best_beast = _ref_beast;
			}
		}
	}

	return _ref_best_beast;
}