//===============================================================================//
//
// SCRIPT: SCR_MINION_TRIGGER_COUNT_BUFFS
// FUNCTION: Updates Buffs that depend on the host's living Minion count.
//           Called whenever a Minion is added to or removed from a Beast.
//           Logs each Minion-count Buff that successfully recalculates.
//
// ARGUMENTS: _ref_host is the Beast whose hosted Minion count changed.
// RETURNS: True when at least one Minion-count Buff triggers.
//
//===============================================================================//

function scr_minion_trigger_count_buffs(_ref_host){

	//----------------//
	//VALIDATE HOST//
	//----------------//
	if (!instance_exists(_ref_host)){
		return false;
	}

	if (!ds_exists(_ref_host._list_statuses,ds_type_list)){
		return false;
	}

	if (!ds_exists(_ref_host._list_minions,ds_type_list)){
		return false;
	}

	var _flag_triggered = false;

	//=========================//
	//CHECK MINION COUNT BUFFS//
	//=========================//
	for (var _it_status = ds_list_size(_ref_host._list_statuses) - 1;_it_status >= 0;_it_status--){

		var _ref_status = ds_list_find_value(
			_ref_host._list_statuses,
			_it_status
		);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_type != "BUFF"){
			continue;
		}

		if (!variable_instance_exists(_ref_status,"_str_buff_trigger")){
			continue;
		}

		if (_ref_status._str_buff_trigger != "MINION_COUNT"){
			continue;
		}

		if (_ref_status._scr_status == undefined){
			continue;
		}

		//--------------//
		//TRIGGER BUFF//
		//--------------//
		if (_ref_status._scr_status("TRIGGER",_ref_status)){

			_flag_triggered = true;

			//================//
			//DEBUG TRIGGER//
			//================//
			scr_debug_log_battle_trigger(
				_ref_status._str_status_name,
				_ref_host,
				_ref_host,
				"MINION COUNT: " +
				string(ds_list_size(_ref_host._list_minions)),
				"SCR_MINION_TRIGGER_COUNT_BUFFS"
			);
		}
	}

	return _flag_triggered;
}