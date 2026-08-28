//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_MINION_COUNT_BUFFS
// FUNCTION: Updates Buffs that depend on the host's living Minion count.
//           Called whenever a Minion is added to or removed from a Beast.
//
//===============================================================================//
function scr_trigger_minion_count_buffs(_ref_host){

	if (!instance_exists(_ref_host)){
		return false;
	}

	var _flag_triggered = false;

	for (var _it_status = 0; _it_status < ds_list_size(_ref_host._list_statuses); _it_status++){

		var _ref_status = ds_list_find_value(_ref_host._list_statuses,_it_status);

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

		if (_ref_status._scr_status("TRIGGER",_ref_status)){
			_flag_triggered = true;
		}
	}

	return _flag_triggered;
}