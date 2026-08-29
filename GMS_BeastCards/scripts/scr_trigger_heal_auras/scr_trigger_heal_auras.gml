//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_HEAL_AURAS
// FUNCTION: Activates Auras when their host receives a healing effect.
//           Passes the attempted healing amount before Maximum HP capping.
//           Returns whether at least one Aura successfully triggered.
//
//===============================================================================//
function scr_trigger_heal_auras(_ref_target,_val_heal_effect){

	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_val_heal_effect <= 0){
		return false;
	}

	var _flag_triggered = false;

	//------------------------//
	//CHECK HOSTED AURA LIST//
	//------------------------//
	for (
		var _it_status = ds_list_size(_ref_target._list_statuses) - 1;
		_it_status >= 0;
		_it_status--
	){

		var _ref_status = ds_list_find_value(_ref_target._list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_type != "AURA"){
			continue;
		}

		if (_ref_status._str_aura_trigger != "HEALED"){
			continue;
		}

		if (_ref_status._scr_status == undefined){
			continue;
		}

		//--------------//
		//TRIGGER AURA//
		//--------------//
		var _flag_aura_triggered = _ref_status._scr_status(
			"TRIGGER",
			_ref_status,
			undefined,
			_val_heal_effect
		);

		if (_flag_aura_triggered){
			_flag_triggered = true;
		}
	}

	return _flag_triggered;
}