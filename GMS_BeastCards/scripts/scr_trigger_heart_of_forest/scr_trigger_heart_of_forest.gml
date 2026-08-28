//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_HEART_OF_FOREST
// FUNCTION: Triggers Heart of the Forest when a protected Beast actually
//           receives healing.
//           Grants Armor equal to HP restored.
//           Each Minion hosted by that Beast gains +1 Maximum HP.
//
//===============================================================================//

function scr_trigger_heart_of_forest(_ref_target,_val_healed){

	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_val_healed <= 0){
		return false;
	}

	//--------------------//
	//CHECK ACTIVE HEART//
	//--------------------//
	var _ref_heart =
		scr_get_heart_of_forest_status(
			_ref_target._str_team
		);

	if (_ref_heart == -1){
		return false;
	}

	//------------------//
	//GRANT EQUAL ARMOR//
	//------------------//
	scr_armor_target(
		_val_healed,
		_ref_target
	);

	//---------------------//
	//GROW HOSTED MINIONS//
	//---------------------//
	for (
		var _it_minion = 0;
		_it_minion < ds_list_size(_ref_target._list_minions);
		_it_minion++
	){

		var _ref_minion =
			ds_list_find_value(
				_ref_target._list_minions,
				_it_minion
			);

		if (!instance_exists(_ref_minion)){
			continue;
		}

		if (_ref_minion._val_cur_hp <= 0){
			continue;
		}

		//------------------//
		//+1 MAXIMUM HP ONLY//
		//------------------//
		_ref_minion._val_max_hp +=
			1;
	}

	//----------//
	//FEEDBACK//
	//----------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"HEART OF THE FOREST",
		undefined,
		c_green,
		_ref_target.x,
		_ref_target.y - 48
	);

	return true;
}