//===============================================================================//
//
// SCRIPT: SCR_GET_TAUNT_TARGET
// FUNCTION: Returns the living Taunting Beast from a supplied team list.
//           Returns undefined when the team has no active Taunt.
//
//===============================================================================//
function scr_get_taunt_target(_list_team){

	if (!ds_exists(_list_team,ds_type_list)){
		return undefined;
	}

	for (var _it_beast = 0; _it_beast < ds_list_size(_list_team); _it_beast++){

		var _ref_beast = ds_list_find_value(_list_team,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (_ref_beast._val_cur_hp <= 0 || _ref_beast._str_list != "ALIVE"){
			continue;
		}

		var _ref_taunt = scr_check_for_status("TAUNT",_ref_beast);

		if (_ref_taunt != -1){
			return _ref_beast;
		}
	}

	return undefined;
}