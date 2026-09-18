//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_FRONT_TWO_TARGETS
// FUNCTION: Returns the two targets for FRONT2 attacks.
//
//           Normally returns the front two living Beasts.
//
//           When the selected primary target is a Taunting Beast, returns
//           that Beast and one adjacent living Beast.
//
//           Taunt changes the primary selection, not the number of targets.
//
// INPUT:    _ref_primary_target - Selected primary Beast.
// RETURNS:  Array containing up to two living Beast references.
//
//===============================================================================//

function scr_battle_get_front_two_targets(_ref_primary_target){

	var _arr_targets = [];

	//================//
	//VALIDATE TARGET//
	//================//
	if (!instance_exists(_ref_primary_target)){
		return _arr_targets;
	}

	//================//
	//GET TARGET TEAM//
	//================//
	var _list_targets = scr_battle_get_target_team_list(_ref_primary_target);

	if (
		_list_targets == undefined ||
		!ds_exists(_list_targets,ds_type_list)
	){
		return _arr_targets;
	}

	if (ds_list_size(_list_targets) <= 0){
		return _arr_targets;
	}

	//=========================//
	//CHECK SELECTED TAUNTER//
	//=========================//
	var _ref_taunt_target = scr_status_get_taunt_target(_list_targets);

	if (
		instance_exists(_ref_taunt_target) &&
		_ref_primary_target == _ref_taunt_target
	){

		//----------------//
		//PRIMARY TARGET//
		//----------------//
		array_push(_arr_targets,_ref_taunt_target);

		//-----------------//
		//SECONDARY TARGET//
		//-----------------//
		var _ref_second_target = scr_battle_get_right_target(_ref_taunt_target);

		if (!instance_exists(_ref_second_target)){
			_ref_second_target = scr_battle_get_left_target(_ref_taunt_target);
		}

		if (
			instance_exists(_ref_second_target) &&
			_ref_second_target._str_list == "ALIVE" &&
			_ref_second_target._val_cur_hp > 0
		){
			array_push(_arr_targets,_ref_second_target);
		}

		return _arr_targets;
	}

	//==================//
	//NORMAL FRONT TWO//
	//==================//
	for (var _it_target = 0;_it_target < ds_list_size(_list_targets);_it_target++){

		var _ref_target = ds_list_find_value(_list_targets,_it_target);

		if (!instance_exists(_ref_target)){
			continue;
		}

		if (
			_ref_target._str_list != "ALIVE" ||
			_ref_target._val_cur_hp <= 0
		){
			continue;
		}

		array_push(_arr_targets,_ref_target);

		if (array_length(_arr_targets) >= 2){
			break;
		}
	}

	return _arr_targets;
}