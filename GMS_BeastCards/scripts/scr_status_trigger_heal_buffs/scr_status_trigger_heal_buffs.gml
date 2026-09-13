//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_HEAL_BUFFS
// FUNCTION: Activates Buffs triggered when their host receives healing.
//           Checks the healed Beast's hosted Buff Statuses and logs each
//           successful reactive Buff trigger.
//
// ARGUMENTS: _ref_target is the Beast receiving the healing effect.
//            _val_healed is the qualifying healing-effect amount.
// RETURNS: True when at least one Buff successfully triggers; otherwise false.
//
//===============================================================================//

function scr_status_trigger_heal_buffs(_ref_target,_val_healed){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_val_healed <= 0){
		return false;
	}

	if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
		return false;
	}

	var _flag_triggered = false;

	//===================//
	//CHECK HOSTED BUFFS//
	//===================//
	for (var _it_status = ds_list_size(_ref_target._list_statuses) - 1;_it_status >= 0;_it_status--){

		var _ref_status = ds_list_find_value(_ref_target._list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_type != "BUFF"){
			continue;
		}

		if (!variable_instance_exists(_ref_status,"_str_buff_trigger")){
			continue;
		}

		if (_ref_status._str_buff_trigger != "HEALED"){
			continue;
		}

		if (_ref_status._scr_status == undefined){
			continue;
		}

		//----------------//
		//SNAPSHOT BUFF//
		//----------------//
		var _str_status_name = _ref_status._str_status_name;
		var _ref_status_host = _ref_status._ref_host;

		//--------------//
		//TRIGGER BUFF//
		//--------------//
		var _flag_buff_triggered = _ref_status._scr_status(
			"TRIGGER",
			_ref_status,
			undefined,
			_val_healed
		);

		if (_flag_buff_triggered){

			_flag_triggered = true;

			scr_debug_log_battle_trigger(
				_str_status_name,
				_ref_status_host,
				_ref_target,
				"HEALING EFFECT: " + string(_val_healed),
				"SCR_STATUS_TRIGGER_HEAL_BUFFS"
			);
		}
	}

	return _flag_triggered;
}