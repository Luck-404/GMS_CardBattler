//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRIGGER_DISCHARGE_WAIT_STEP
// FUNCTION: Advances an active multi-DISCHARGE sequence after a 10-frame wait.
//           Resolves one DISCHARGE, then rearms the same wait object while
//           the host still meets its current DISCHARGE threshold.
//
// ARGUMENTS: _ref_wait - active obj_battle_wait sequence instance.
// RETURNS: True while the wait should remain active; otherwise false.
//
//===============================================================================//
function scr_battle_trigger_discharge_wait_step(_ref_wait){

	//================//
	//VALIDATE WAIT//
	//================//
	if (!instance_exists(_ref_wait)){
		return false;
	}

	if (
		!variable_instance_exists(
			_ref_wait,
			"_ref_discharge_host"
		)
	){
		return false;
	}

	var _ref_host =
		_ref_wait._ref_discharge_host;

	if (!instance_exists(_ref_host)){
		return false;
	}

	//===================//
	//GET STORMSTRUCK//
	//===================//
	var _ref_stormstruck =
		scr_status_check("STORMSTRUCK",_ref_host);

	if (
		_ref_stormstruck == -1 ||
		!instance_exists(_ref_stormstruck)
	){
		return false;
	}

	if (
		!variable_instance_exists(
			_ref_stormstruck,
			"_flag_discharge_sequence_active"
		) ||
		!_ref_stormstruck._flag_discharge_sequence_active
	){
		return false;
	}

	//================//
	//VALIDATE HOST//
	//================//
	if (_ref_host._val_cur_hp <= 0){

		_ref_stormstruck._flag_discharge_sequence_active =
			false;

		return false;
	}

	//========================//
	//RESOLVE NEXT DISCHARGE//
	//========================//
	if (!scr_battle_resolve_discharge(_ref_host)){

		_ref_stormstruck._flag_discharge_sequence_active =
			false;

		return false;
	}

	//======================//
	//CHECK FOLLOW-UP STATE//
	//======================//
	if (
		!instance_exists(_ref_host) ||
		_ref_host._val_cur_hp <= 0
	){
		if (instance_exists(_ref_stormstruck)){
			_ref_stormstruck._flag_discharge_sequence_active =
				false;
		}

		return false;
	}

	_ref_stormstruck =
		scr_status_check("STORMSTRUCK",_ref_host);

	if (
		_ref_stormstruck == -1 ||
		!instance_exists(_ref_stormstruck)
	){
		return false;
	}

	var _ct_threshold =
		scr_status_get_discharge_threshold(_ref_host);

	//================//
	//REARM WAIT//
	//================//
	if (
		_ref_stormstruck._ct_status_stacks >=
		_ct_threshold
	){
		_ref_wait._ct_life = 10;

		return true;
	}

	//================//
	//END SEQUENCE//
	//================//
	_ref_stormstruck._flag_discharge_sequence_active =
		false;

	return false;
}