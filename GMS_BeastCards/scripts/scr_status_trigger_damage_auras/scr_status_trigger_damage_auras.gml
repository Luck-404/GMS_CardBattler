//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_DAMAGE_AURAS
// FUNCTION: Triggers opposing Team Auras when a Beast takes damage.
//           Searches living enemy Beasts for Team-scoped Auras responding to
//           ENEMY_DAMAGED and logs successful reactive Aura triggers.
//
// ARGUMENTS: _ref_damaged_beast is the Beast that received damage.
//            _val_damage is the qualifying Beast damage amount.
// RETURNS: True when at least one Aura successfully triggers; otherwise false.
//
//===============================================================================//

function scr_status_trigger_damage_auras(_ref_damaged_beast,_val_damage){

	//------------------------//
	//VALIDATE DAMAGED BEAST//
	//------------------------//
	if (!instance_exists(_ref_damaged_beast)){
		return false;
	}

	if (_val_damage <= 0){
		return false;
	}

	if (_ref_damaged_beast._val_cur_hp <= 0){
		return false;
	}

	//-------------------//
	//GET OPPOSING TEAM//
	//-------------------//
	var _list_aura_team = (_ref_damaged_beast._str_team == "PLAYER") ? obj_battle_enemy_controller._list_beasts_alive : obj_battle_player_controller._list_beasts_alive;

	if (!ds_exists(_list_aura_team,ds_type_list)){
		return false;
	}

	var _flag_triggered = false;

	//================//
	//CHECK TEAM AURAS//
	//================//
	for (var _it_beast = 0;_it_beast < ds_list_size(_list_aura_team);_it_beast++){

		var _ref_beast = ds_list_find_value(_list_aura_team,_it_beast);

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

			if (_ref_status._str_aura_trigger != "ENEMY_DAMAGED"){
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
				_ref_damaged_beast
			);

			if (_flag_aura_triggered){

				_flag_triggered = true;

				scr_debug_log_battle_trigger(
					_str_status_name,
					_ref_status_host,
					_ref_damaged_beast,
					"DAMAGE EVENT: " + string(_val_damage),
					"SCR_STATUS_TRIGGER_DAMAGE_AURAS"
				);
			}
		}
	}

	return _flag_triggered;
}