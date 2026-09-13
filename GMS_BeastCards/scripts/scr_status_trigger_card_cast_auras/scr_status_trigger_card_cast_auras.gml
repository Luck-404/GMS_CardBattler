//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_CARD_CAST_AURAS
// FUNCTION: Triggers Team Auras responding to a qualifying card cast.
//           Searches living allied Beasts for Team-scoped Auras.
//           Currently supports Auras triggered by Attack card casts.
//           Logs every Aura that successfully triggers.
//
// ARGUMENTS: _ref_caster is the Beast that cast the qualifying card.
//            _stct_card is the Card struct that was cast.
// RETURNS: True when at least one Aura successfully triggers; otherwise false.
//
//===============================================================================//

function scr_status_trigger_card_cast_auras(_ref_caster,_stct_card){

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return false;
	}

	//--------------//
	//VALIDATE CARD//
	//--------------//
	if (!is_struct(_stct_card)){
		return false;
	}

	if (_stct_card._str_card_type != "ATTACK"){
		return false;
	}

	//---------------//
	//GET TEAM LIST//
	//---------------//
	var _list_team = scr_battle_get_target_team_list(_ref_caster);

	if (!ds_exists(_list_team,ds_type_list)){
		return false;
	}

	var _flag_triggered = false;

	//================//
	//CHECK TEAM AURAS//
	//================//
	for (var _it_beast = 0;_it_beast < ds_list_size(_list_team);_it_beast++){

		var _ref_beast = ds_list_find_value(_list_team,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (!ds_exists(_ref_beast._list_statuses,ds_type_list)){
			continue;
		}

		//----------------//
		//CHECK STATUSES//
		//----------------//
		for (var _it_status = ds_list_size(_ref_beast._list_statuses) - 1;_it_status >= 0;_it_status--){

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

			//----------------//
			//SNAPSHOT AURA//
			//----------------//
			var _str_status_name = _ref_status._str_status_name;
			var _ref_status_host = _ref_status._ref_host;

			//--------------//
			//TRIGGER AURA//
			//--------------//
			var _flag_aura_triggered = _ref_status._scr_status(
				"TRIGGER",
				_ref_status,
				undefined,
				_ref_caster
			);

			if (_flag_aura_triggered){

				_flag_triggered = true;

				scr_debug_log_battle_trigger(
					_str_status_name,
					_ref_status_host,
					_ref_caster,
					"",
					"SCR_STATUS_TRIGGER_CARD_CAST_AURAS"
				);
			}
		}
	}

	return _flag_triggered;
}