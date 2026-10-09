//===============================================================================//
//
// SCRIPT: SCR_STATUS_GAIN_ECHO
// FUNCTION: Adds Echo stacks to the source Beast's Team Echo resource.
//           Creates the Team Status when needed and plays the shared Echo VFX/SFX.
//
// ARGUMENTS: _ct_amount defaults to 1.
//            _ref_source may be a Beast or PLAYER/ENEMY Team string. When omitted,
//            GLOBAL.REF_CASTER_BEAST supplies the active Team for legacy callers.
// RETURNS: Active Echo Status reference, or undefined.
//
//===============================================================================//

function scr_status_gain_echo(_ct_amount=undefined,_ref_source=undefined){

	if (_ct_amount == undefined){
		_ct_amount = 1;
	}

	_ct_amount = floor(_ct_amount);

	if (_ct_amount <= 0){
		return undefined;
	}

	var _ref_echo = scr_status_buff_echo(
		"APPLY",
		undefined,
		_ct_amount,
		_ref_source
	);

	if (!instance_exists(_ref_echo)){
		return undefined;
	}

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
