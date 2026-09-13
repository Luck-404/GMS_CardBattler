//===============================================================================//
//
// SCRIPT: SCR_STATUS_GAIN_ECHO
// FUNCTION: Adds Echo stacks to the global Echo Buff.
//           Creates the Echo Status when needed.
//           Plays the shared Echo Set VFX and SFX when Echo is gained.
//           Returns the active Echo Status reference.
//
//===============================================================================//

function scr_status_gain_echo(_ct_amount=undefined){

	//----------//
	//DEFAULTS//
	//----------//
	if (_ct_amount == undefined){
		_ct_amount = 1;
	}

	_ct_amount = floor(_ct_amount);

	//----------------//
	//VALIDATE AMOUNT//
	//----------------//
	if (_ct_amount <= 0){
		return undefined;
	}

	//===========//
	//GAIN ECHO//
	//===========//
	var _ref_echo = scr_status_buff_echo(
		"APPLY",
		undefined,
		_ct_amount
	);

	if (!instance_exists(_ref_echo)){
		return undefined;
	}

	//================//
	//ECHO SET VFX/SFX//
	//================//
	scr_battle_vfx(
		undefined,
		spr_battle_vfx_echo_set,
		room_width * 0.5,
		room_height * 0.25,
		0,
		0,
		1,
		0,
		snd_battle_echo
	);

	return _ref_echo;
}