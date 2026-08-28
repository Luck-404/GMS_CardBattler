//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_CARD_CAST_AURAS
// FUNCTION: Triggers Team Auras responding to a qualifying card cast.
//           Searches living allied Beasts for Team-scoped Auras.
//           Currently supports Auras triggered by Attack card casts.
//
//===============================================================================//
function scr_trigger_card_cast_auras(_ref_caster,_stct_card){

	if (!instance_exists(_ref_caster)){
		return false;
	}

	if (!is_struct(_stct_card)){
		return false;
	}

	if (_stct_card._str_card_type != "ATTACK"){
		return false;
	}

	var _list_team = scr_get_target_team_list(_ref_caster);

	if (_list_team == undefined){
		return false;
	}

	var _flag_triggered = false;

	//------------------//
	//CHECK TEAM AURAS//
	//------------------//
	for (var _it_beast = 0; _it_beast < ds_list_size(_list_team); _it_beast++){

		var _ref_beast = ds_list_find_value(_list_team,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		for (
			var _it_status = ds_list_size(_ref_beast._list_statuses) - 1;
			_it_status >= 0;
			_it_status--
		){

			var _ref_status = ds_list_find_value(_ref_beast._list_statuses,_it_status);

			if (!instance_exists(_ref_status)){
				continue;
			}

			if (_ref_status._str_status_type != "AURA"){
				continue;
			}

			if (_ref_status._str_aura_scope != "TEAM"){
				continue;
			}

			if (_ref_status._str_aura_trigger != "ATTACK_CAST"){
				continue;
			}

			if (_ref_status._scr_status == undefined){
				continue;
			}

			//--------------//
			//TRIGGER AURA//
			//--------------//
			var _flag_aura_triggered = _ref_status._scr_status("TRIGGER",_ref_status,undefined,_ref_caster);

			if (_flag_aura_triggered){
				_flag_triggered = true;
			}
		}
	}

	return _flag_triggered;
}