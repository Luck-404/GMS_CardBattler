//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRIGGER_DISCHARGE
// FUNCTION: Starts a DISCHARGE sequence when the host meets its current threshold.
//           Resolves the first DISCHARGE immediately.
//           If enough Stormstruck remains for additional DISCHARGES,
//           resolves one additional DISCHARGE every 10 frames.
//           Only one sequence may be active per Stormstruck Status.
//
// ARGUMENTS: _ref_host - Beast being checked for DISCHARGE.
// RETURNS: 1 when a DISCHARGE sequence begins; otherwise 0.
//
//===============================================================================//
function scr_battle_trigger_discharge(_ref_host){

	//----------------//
	//VALIDATE HOST//
	//----------------//
	if (
		!instance_exists(_ref_host) ||
		_ref_host._val_cur_hp <= 0
	){
		return 0;
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
		return 0;
	}

	//================//
	//CHECK THRESHOLD//
	//================//
	var _ct_threshold =
		scr_status_get_discharge_threshold(_ref_host);

	if (
		_ref_stormstruck._ct_status_stacks <
		_ct_threshold
	){
		return 0;
	}

	//=====================//
	//CHECK ACTIVE SEQUENCE//
	//=====================//
	if (
		!variable_instance_exists(
			_ref_stormstruck,
			"_flag_discharge_sequence_active"
		)
	){
		_ref_stormstruck._flag_discharge_sequence_active =
			false;
	}

	if (
		_ref_stormstruck._flag_discharge_sequence_active
	){
		return 0;
	}

	_ref_stormstruck._flag_discharge_sequence_active =
		true;

	//=======================//
	//RESOLVE FIRST DISCHARGE//
	//=======================//
	if (!scr_battle_resolve_discharge(_ref_host)){

		if (instance_exists(_ref_stormstruck)){
			_ref_stormstruck._flag_discharge_sequence_active =
				false;
		}

		return 0;
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

		return 1;
	}

	_ref_stormstruck =
		scr_status_check("STORMSTRUCK",_ref_host);

	if (
		_ref_stormstruck == -1 ||
		!instance_exists(_ref_stormstruck)
	){
		return 1;
	}

	_ct_threshold =
		scr_status_get_discharge_threshold(_ref_host);

	//======================//
	//NO MORE DISCHARGES//
	//======================//
	if (
		_ref_stormstruck._ct_status_stacks <
		_ct_threshold
	){
		_ref_stormstruck._flag_discharge_sequence_active =
			false;

		return 1;
	}

	//========================//
	//CREATE SEQUENCE WAIT//
	//========================//
	var _ref_wait = instance_create_layer(
		room_width * 0.5,
		room_height * 0.5,
		"ily_fx",
		obj_battle_wait
	);

	_ref_wait._ct_life = 10;

	_ref_wait._ref_discharge_host =
		_ref_host;

	_ref_wait._scr_on_complete =
		scr_battle_trigger_discharge_wait_step;

	return 1;
}