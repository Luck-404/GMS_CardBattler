//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_HEAL_BUFFS
// FUNCTION: Activates Buffs triggered when their host receives healing.
//           Checks the healed Beast's hosted Buff statuses.
//           Returns whether at least one Buff successfully triggered.
//
//===============================================================================//
function scr_trigger_heal_buffs(_ref_target,_val_healed){

	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_val_healed <= 0){
		return false;
	}

	var _flag_triggered =
		false;

	//-----------------------//
	//CHECK HOSTED BUFF LIST//
	//-----------------------//
	for (
		var _it_status = ds_list_size(_ref_target._list_statuses) - 1;
		_it_status >= 0;
		_it_status--
	){

		var _ref_status =
			ds_list_find_value(
				_ref_target._list_statuses,
				_it_status
			);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_type != "BUFF"){
			continue;
		}

		if (
			!variable_instance_exists(
				_ref_status,
				"_str_buff_trigger"
			)
		){
			continue;
		}

		if (_ref_status._str_buff_trigger != "HEALED"){
			continue;
		}

		if (_ref_status._scr_status == undefined){
			continue;
		}

		//--------------//
		//TRIGGER BUFF//
		//--------------//
		var _flag_buff_triggered =
			_ref_status._scr_status(
				"TRIGGER",
				_ref_status,
				undefined,
				_val_healed
			);

		if (_flag_buff_triggered){
			_flag_triggered = true;
		}
	}

	return _flag_triggered;
}